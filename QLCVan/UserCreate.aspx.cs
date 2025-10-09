using System;
using System.Linq;

namespace QLCVan
{
    public partial class UserCreate : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDonVi();
            }
        }

        private void LoadDonVi()
        {
            ddlDonVi.DataSource = db.tblNhoms;
            ddlDonVi.DataTextField = "MoTa";
            ddlDonVi.DataValueField = "MaNhom";
            ddlDonVi.DataBind();
            ddlDonVi.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Đơn vị", ""));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtMatKhau.Text != txtMatKhau2.Text)
            {
                Response.Write("<script>alert('Mật khẩu xác nhận không khớp!');</script>");
                return;
            }

            tblNguoiDung nd = new tblNguoiDung
            {
                MaNguoiDung = txtMaND.Text.Trim(),
                HoTen = txtHoTen.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                TenDN = txtTenDN.Text.Trim(),
                MatKhau = txtMatKhau.Text.Trim(),
                QuyenHan = ddlChucVu.SelectedItem.Text,
                TrangThai = rdbActive.Checked ? 0 : 1,
                ChucVu = ddlChucVu.SelectedValue,
                MaNhom = string.IsNullOrEmpty(ddlDonVi.SelectedValue) ? 0 : int.Parse(ddlDonVi.SelectedValue)
            };

            db.tblNguoiDungs.InsertOnSubmit(nd);
            db.SubmitChanges();

            Response.Write("<script>alert('Thêm người dùng thành công!');window.location='QLnguoidung.aspx';</script>");
        }
    }
}
