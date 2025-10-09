using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLNhomQuyen : System.Web.UI.Page
    {
        // Lớp đại diện cho quyền
        public class Quyen
        {
            public string MaQuyen { get; set; }
            public string TenQuyen { get; set; }
        }

        // Lấy danh sách quyền từ Session
        private List<Quyen> GetDanhSachQuyen()
        {
            if (Session["DanhSachQuyen"] == null)
            {
                Session["DanhSachQuyen"] = new List<Quyen>
                {
                    new Quyen { MaQuyen = "Q1", TenQuyen = "Quản trị hệ thống" },
                    new Quyen { MaQuyen = "Q2", TenQuyen = "Quản lý người dùng" },
                    new Quyen { MaQuyen = "Q3", TenQuyen = "Xem báo cáo" }
                };
            }
            return (List<Quyen>)Session["DanhSachQuyen"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_Quyen();
            }
        }

        private void load_Quyen()
        {
            gvQuyen.DataSource = GetDanhSachQuyen();
            gvQuyen.DataBind();
        }

        protected void gvQuyen_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvQuyen.PageIndex = e.NewPageIndex;
            load_Quyen();
        }
        protected void btnSaveQuyen_Click(object sender, EventArgs e)
        {
            string tenQuyen = txtTenQuyenMoi.Text.Trim();

            if (string.IsNullOrEmpty(tenQuyen))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Vui lòng nhập tên quyền!');", true);
                return;
            }

            var danhSach = GetDanhSachQuyen();
            if (danhSach.Any(q => q.TenQuyen.Equals(tenQuyen, StringComparison.OrdinalIgnoreCase)))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Tên quyền đã tồn tại!');", true);
                return;
            }

            string maQuyen = "Q" + (danhSach.Count + 1);
            danhSach.Add(new Quyen { MaQuyen = maQuyen, TenQuyen = tenQuyen });

            txtTenQuyenMoi.Text = "";
            load_Quyen();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#addQuyenModal').modal('hide');", true);
        }

        protected void gvQuyen_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvQuyen.EditIndex = e.NewEditIndex;
            load_Quyen();
        }

        protected void gvQuyen_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQuyen.EditIndex = -1;
            load_Quyen();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keywordMa = txtSearchMa.Text.Trim().ToLower();
            string keywordTen = txtSearchTen.Text.Trim().ToLower();

            var danhSach = GetDanhSachQuyen();

            var ketQua = danhSach.Where(q =>
                (string.IsNullOrEmpty(keywordMa) || q.MaQuyen.ToLower().Contains(keywordMa)) &&
                (string.IsNullOrEmpty(keywordTen) || q.TenQuyen.ToLower().Contains(keywordTen))
            ).ToList();

            gvQuyen.DataSource = ketQua;
            gvQuyen.DataBind();
        }

        protected void gvQuyen_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            var danhSach = GetDanhSachQuyen();
            string maQuyen = gvQuyen.DataKeys[e.RowIndex].Value.ToString();
            TextBox txtTenQuyen = (TextBox)gvQuyen.Rows[e.RowIndex].FindControl("txtTenQuyen");

            var quyen = danhSach.FirstOrDefault(q => q.MaQuyen == maQuyen);
            if (quyen != null)
            {
                quyen.TenQuyen = txtTenQuyen.Text.Trim();
            }

            gvQuyen.EditIndex = -1;
            load_Quyen();
        }

        protected void gvQuyen_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var danhSach = GetDanhSachQuyen();
            string maQuyen = gvQuyen.DataKeys[e.RowIndex].Value.ToString();
            var quyen = danhSach.FirstOrDefault(q => q.MaQuyen == maQuyen);
            if (quyen != null)
            {
                danhSach.Remove(quyen);
            }

            load_Quyen();
        }
    }
}
