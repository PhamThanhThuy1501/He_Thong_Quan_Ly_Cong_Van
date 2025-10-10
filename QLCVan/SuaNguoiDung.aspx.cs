using System;
using System.Collections.Generic;
using System.Linq;

namespace QLCVan
{
    public partial class SuaNguoiDung : System.Web.UI.Page
    {
        private List<QLNguoiDung.NguoiDung> GetDanhSachNguoiDung()
        {
            return (List<QLNguoiDung.NguoiDung>)Session["DanhSachNguoiDung"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tenDN = Request.QueryString["TenDangNhap"];
                if (string.IsNullOrEmpty(tenDN))
                {
                    Response.Redirect("QLNguoiDung.aspx");
                    return;
                }

                var ds = GetDanhSachNguoiDung();
                var user = ds?.FirstOrDefault(u => u.TenDangNhap == tenDN);
                if (user == null)
                {
                    Response.Redirect("QLNguoiDung.aspx");
                    return;
                }

                txtTenDN.Text = user.TenDangNhap;
                txtEmail.Text = user.Email;
                ddlDonVi.SelectedValue = user.DonVi;
                ddlChucVu.SelectedValue = user.ChucVu;
                rbKichHoat.Checked = user.DangKichHoat;
                rbChuaKichHoat.Checked = !user.DangKichHoat;
            }
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            string tenDN = txtTenDN.Text.Trim();
            string email = txtEmail.Text.Trim();
            string donvi = ddlDonVi.SelectedValue;
            string chucvu = ddlChucVu.SelectedValue;
            bool kichHoat = rbKichHoat.Checked;

            var ds = GetDanhSachNguoiDung();
            var user = ds?.FirstOrDefault(u => u.TenDangNhap == tenDN);
            if (user != null)
            {
                user.Email = email;
                user.DonVi = donvi;
                user.ChucVu = chucvu;
                user.DangKichHoat = kichHoat;
            }

            Session["DanhSachNguoiDung"] = ds;
            Response.Redirect("QLNguoiDung.aspx?updated=1");
        }
    }
}
