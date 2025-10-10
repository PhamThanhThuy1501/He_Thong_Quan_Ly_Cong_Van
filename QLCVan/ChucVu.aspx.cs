using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class ChucVu : Page
    {
        // ----- MODEL TẠM -----
        [Serializable]
        public class PositionVM
        {
            public int Id { get; set; }
            public string Code { get; set; }
            public string Name { get; set; }
        }

        // ----- CẤU HÌNH -----
        private const int PageSize = 5; // ✅ hiển thị 5 hàng mỗi trang

        private List<PositionVM> Data
        {
            get
            {
                var list = ViewState["__positions"] as List<PositionVM>;
                if (list == null)
                {
                    list = new List<PositionVM>
                    {
                        new PositionVM{ Id = 1, Code = "NV_01", Name = "Trưởng khoa"},
                        new PositionVM{ Id = 2, Code = "TK_01", Name = "Giáo viên"},
                        new PositionVM{ Id = 3, Code = "NV_02", Name = "Phó khoa"},
                        new PositionVM{ Id = 4, Code = "NV_03", Name = "Chuyên viên"},
                        new PositionVM{ Id = 5, Code = "NV_04", Name = "Trợ lý"},
                        new PositionVM{ Id = 6, Code = "TK_02", Name = "Giảng viên chính"},
                        new PositionVM{ Id = 7, Code = "TK_03", Name = "Giảng viên tập sự"},
                        new PositionVM{ Id = 8, Code = "HC_01", Name = "Hành chính"},
                        new PositionVM{ Id = 9, Code = "HC_02", Name = "Văn thư"},
                        new PositionVM{ Id = 10, Code = "KT_01", Name = "Kế toán"},
                        new PositionVM{ Id = 11, Code = "KT_02", Name = "Thủ quỹ"}
                    };
                    ViewState["__positions"] = list;
                }
                return list;
            }
            set { ViewState["__positions"] = value; }
        }

        private int CurrentPage
        {
            get { return (int)(ViewState["__page"] ?? 1); }
            set { ViewState["__page"] = value; }
        }

        // ----- PAGE LOAD -----
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindData();
        }

        // ----- HIỂN THỊ DỮ LIỆU -----
        private void BindData()
        {
            string kw = (txtCodeSearch.Text ?? "").Trim().ToLower();
            var list = string.IsNullOrEmpty(kw)
                ? Data
                : Data.FindAll(x => (x.Code ?? "").ToLower().Contains(kw)
                                 || (x.Name ?? "").ToLower().Contains(kw));

            int total = list.Count;
            int totalPages = (int)Math.Ceiling((double)total / PageSize);
            if (CurrentPage < 1) CurrentPage = 1;
            if (CurrentPage > totalPages && totalPages > 0) CurrentPage = totalPages;

            var pageItems = list
                .OrderBy(x => x.Id)
                .Skip((CurrentPage - 1) * PageSize)
                .Take(PageSize)
                .ToList();

            rptPositions.DataSource = pageItems;
            rptPositions.DataBind();

            BuildPager(totalPages);
        }

        // ----- PHÂN TRANG -----
        private void BuildPager(int totalPages)
        {
            phPager.Controls.Clear();
            if (totalPages <= 1) return;

            // Prev
            if (CurrentPage > 1)
                phPager.Controls.Add(MakePageLink("«", CurrentPage - 1));

            // Các số trang
            for (int i = 1; i <= totalPages; i++)
            {
                if (i == CurrentPage)
                    phPager.Controls.Add(new Literal { Text = $"<span class='active'>{i}</span>" });
                else
                    phPager.Controls.Add(MakePageLink(i.ToString(), i));
            }

            // Next
            if (CurrentPage < totalPages)
                phPager.Controls.Add(MakePageLink("»", CurrentPage + 1));
        }

        private LinkButton MakePageLink(string text, int page)
        {
            var btn = new LinkButton
            {
                Text = text,
                CommandName = "page",
                CommandArgument = page.ToString(),
                CausesValidation = false,
                CssClass = "page-link"
            };
            btn.Command += Pager_Command; // ✅ Sự kiện click trang
            return btn;
        }

        private void Pager_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "page")
            {
                CurrentPage = int.Parse(e.CommandArgument.ToString());
                BindData();
            }
        }

        // ----- TÌM KIẾM -----
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 1;
            BindData();
        }

        // ----- SỰ KIỆN TRONG BẢNG -----
        protected void rptPositions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "edit")
            {
                var p = Data.FirstOrDefault(x => x.Id == id);
                if (p != null)
                {
                    hidId.Value = p.Id.ToString();
                    txtCode.Text = p.Code;
                    txtName.Text = p.Name;
                    litModalTitle.Text = "Sửa chức vụ";
                    ScriptManager.RegisterStartupScript(this, GetType(),
                        "open", "$('#modalPosition').modal('show');", true);
                }
            }
            else if (e.CommandName == "delete")
            {
                var list = Data;
                var p = list.FirstOrDefault(x => x.Id == id);
                if (p != null)
                {
                    list.Remove(p);
                    Data = list;
                }
                BindData();
            }
        }

        // ----- LƯU DỮ LIỆU -----
        protected void btnSave_Click(object sender, EventArgs e)
        {
            lbError.Text = "";
            var code = (txtCode.Text ?? "").Trim();
            var name = (txtName.Text ?? "").Trim();

            if (string.IsNullOrWhiteSpace(code) || string.IsNullOrWhiteSpace(name))
            {
                lbError.Text = "Vui lòng nhập đầy đủ Mã và Chức vụ.";
                ScriptManager.RegisterStartupScript(this, GetType(),
                    "open", "$('#modalPosition').modal('show');", true);
                return;
            }

            var list = Data;

            if (string.IsNullOrEmpty(hidId.Value))
            {
                // Thêm mới
                if (list.Any(x => x.Code.Equals(code, StringComparison.OrdinalIgnoreCase)))
                {
                    lbError.Text = "Mã chức vụ đã tồn tại.";
                    ScriptManager.RegisterStartupScript(this, GetType(),
                        "open", "$('#modalPosition').modal('show');", true);
                    return;
                }

                int newId = (list.Count == 0) ? 1 : list.Max(x => x.Id) + 1;
                list.Add(new PositionVM { Id = newId, Code = code, Name = name });
            }
            else
            {
                // Cập nhật
                int id = int.Parse(hidId.Value);
                if (list.Any(x => x.Id != id && x.Code.Equals(code, StringComparison.OrdinalIgnoreCase)))
                {
                    lbError.Text = "Mã chức vụ đã tồn tại.";
                    ScriptManager.RegisterStartupScript(this, GetType(),
                        "open", "$('#modalPosition').modal('show');", true);
                    return;
                }

                var p = list.FirstOrDefault(x => x.Id == id);
                if (p != null)
                {
                    p.Code = code;
                    p.Name = name;
                }
            }

            Data = list;
            hidId.Value = "";
            txtCode.Text = "";
            txtName.Text = "";
            litModalTitle.Text = "Thêm chức vụ";
            CurrentPage = 1;
            BindData();
            ScriptManager.RegisterStartupScript(this, GetType(),
                "hide", "$('#modalPosition').modal('hide');", true);
        }
    }
}
