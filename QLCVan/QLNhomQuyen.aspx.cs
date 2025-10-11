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
            string maQuyen = txtMaQuyenMoi.Text.Trim();
            string tenQuyen = txtTenQuyenMoi.Text.Trim();

            if (string.IsNullOrEmpty(maQuyen))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Vui lòng nhập mã quyền!');", true);
                return;
            }

            if (string.IsNullOrEmpty(tenQuyen))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Vui lòng nhập tên quyền!');", true);
                return;
            }

            var danhSach = GetDanhSachQuyen();

            // Kiểm tra trùng mã quyền
            if (danhSach.Any(q => q.MaQuyen.Equals(maQuyen, StringComparison.OrdinalIgnoreCase)))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Mã quyền đã tồn tại!');", true);
                return;
            }

            // Kiểm tra trùng tên quyền
            if (danhSach.Any(q => q.TenQuyen.Equals(tenQuyen, StringComparison.OrdinalIgnoreCase)))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Tên quyền đã tồn tại!');", true);
                return;
            }

            danhSach.Add(new Quyen { MaQuyen = maQuyen, TenQuyen = tenQuyen });

            txtMaQuyenMoi.Text = "";
            txtTenQuyenMoi.Text = "";
            load_Quyen();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#addQuyenModal').modal('hide');", true);
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


        protected void gvQuyen_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvQuyen.EditIndex = e.NewEditIndex;
            gvQuyen.DataSource = GetDanhSachQuyen(); // hoặc từ DB
            gvQuyen.DataBind();
        }

        // Khi nhấn nút Cancel
        protected void gvQuyen_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQuyen.EditIndex = -1;
            gvQuyen.DataSource = GetDanhSachQuyen();
            gvQuyen.DataBind();
        }

        // Khi nhấn nút Update
        protected void gvQuyen_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvQuyen.Rows[e.RowIndex];
            string tenQuyenMoi = ((TextBox)row.FindControl("txtEditTenQuyen")).Text.Trim();

            var danhSach = GetDanhSachQuyen();

            // Giả sử vị trí dòng trong danh sách tương ứng với e.RowIndex
            if (e.RowIndex < danhSach.Count)
            {
                danhSach[e.RowIndex].TenQuyen = tenQuyenMoi;
            }

            gvQuyen.EditIndex = -1;
            gvQuyen.DataSource = danhSach;
            gvQuyen.DataBind();
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