using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLNguoiDung : System.Web.UI.Page
    {
        public class NguoiDung
        {
            public string TenDangNhap { get; set; }
            public string Email { get; set; }
            public string DonVi { get; set; }
            public string ChucVu { get; set; }
            public bool DangKichHoat { get; set; }
        }

        private List<NguoiDung> GetDanhSachNguoiDung()
        {
            if (Session["DanhSachNguoiDung"] == null)
            {
                Session["DanhSachNguoiDung"] = new List<NguoiDung>
                {
                    new NguoiDung { TenDangNhap = "duchm", Email = "duchm@gmail.com", DonVi = "Khoa Binh chủng hợp thành", ChucVu = "Giáo viên", DangKichHoat = true },
                    new NguoiDung { TenDangNhap = "hungnh", Email = "hungnh@gmail.com", DonVi = "Khoa Binh chủng hợp thành", ChucVu = "Giáo viên", DangKichHoat = false }
                };
            }
            return (List<NguoiDung>)Session["DanhSachNguoiDung"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNguoiDung();
            }
        }

        private void LoadNguoiDung()
        {
            gvNguoiDung.DataSource = GetDanhSachNguoiDung();
            gvNguoiDung.DataBind();
        }

       public static void ThemNguoiDungMoi(string ten, string email, string donvi, string chucvu, bool kichHoat)
{
    var ds = (List<NguoiDung>)System.Web.HttpContext.Current.Session["DanhSachNguoiDung"];
    if (ds == null)
        ds = new List<NguoiDung>();

    ds.Add(new NguoiDung
    {
        TenDangNhap = ten,
        Email = email,
        DonVi = donvi,
        ChucVu = chucvu,
        DangKichHoat = kichHoat
    });

    System.Web.HttpContext.Current.Session["DanhSachNguoiDung"] = ds;
}


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keywordTen = txtSearchTenDN.Text.Trim().ToLower();
            string keywordEmail = txtSearchEmail.Text.Trim().ToLower();

            var ds = GetDanhSachNguoiDung();
            var ketQua = ds.Where(u =>
                (string.IsNullOrEmpty(keywordTen) || u.TenDangNhap.ToLower().Contains(keywordTen)) &&
                (string.IsNullOrEmpty(keywordEmail) || u.Email.ToLower().Contains(keywordEmail))
            ).ToList();

            gvNguoiDung.DataSource = ketQua;
            gvNguoiDung.DataBind();
        }

        protected void gvNguoiDung_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNguoiDung.PageIndex = e.NewPageIndex;
            LoadNguoiDung();
        }

        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {
            gvNguoiDung.EditIndex = e.NewEditIndex;
            LoadNguoiDung();
        }

        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvNguoiDung.EditIndex = -1;
            LoadNguoiDung();
        }

        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            var ds = GetDanhSachNguoiDung();
            string ten = gvNguoiDung.DataKeys[e.RowIndex].Value.ToString();

            TextBox txtEmail = (TextBox)gvNguoiDung.Rows[e.RowIndex].FindControl("txtEmail");
            TextBox txtDonVi = (TextBox)gvNguoiDung.Rows[e.RowIndex].FindControl("txtDonVi");
            TextBox txtChucVu = (TextBox)gvNguoiDung.Rows[e.RowIndex].FindControl("txtChucVu");

            var user = ds.FirstOrDefault(u => u.TenDangNhap == ten);
            if (user != null)
            {
                user.Email = txtEmail.Text.Trim();
                user.DonVi = txtDonVi.Text.Trim();
                user.ChucVu = txtChucVu.Text.Trim();
            }

            gvNguoiDung.EditIndex = -1;
            LoadNguoiDung();
        }

        protected void rowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var ds = GetDanhSachNguoiDung();
            string ten = gvNguoiDung.DataKeys[e.RowIndex].Value.ToString();

            var user = ds.FirstOrDefault(u => u.TenDangNhap == ten);
            if (user != null)
            {
                ds.Remove(user);
            }

            LoadNguoiDung();
        }
        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string ten = hdnDeleteUser.Value; // Lấy tên đăng nhập từ hidden field
            var ds = GetDanhSachNguoiDung();  // Lấy danh sách từ Session

            var user = ds.FirstOrDefault(u => u.TenDangNhap == ten);
            if (user != null)
                ds.Remove(user);

            Session["DanhSachNguoiDung"] = ds; // Cập nhật lại Session
            LoadNguoiDung(); // Load lại bảng sau khi xóa
        }

    }
}
