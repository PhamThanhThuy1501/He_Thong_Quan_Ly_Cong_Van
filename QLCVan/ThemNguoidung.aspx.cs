using System;

namespace QLCVan
{
    public partial class ThemNguoiDung : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string maNguoiDung = txtMaNguoiDung.Text.Trim();
            string tenDN = txtTenDN.Text.Trim();
            string email = txtEmail.Text.Trim();
            string donvi = ddlDonVi.SelectedValue;
            string chucvu = ddlChucVu.SelectedValue;
            bool kichHoat = rbKichHoat.Checked;

            if (string.IsNullOrEmpty(maNguoiDung))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng nhập mã người dùng!');", true);
                return;
            }

            if (string.IsNullOrEmpty(tenDN) || string.IsNullOrEmpty(email))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng nhập đầy đủ thông tin!');", true);
                return;
            }

            QLNguoiDung.ThemNguoiDungMoi(tenDN, email, donvi, chucvu, kichHoat);
            Response.Redirect("QLNguoiDung.aspx?added=1");
        }
    }
}
