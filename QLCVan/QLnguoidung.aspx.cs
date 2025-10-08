using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLnguoidung : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Session["TenDN"] != null))
            {
                Response.Redirect("Dangnhap.aspx");
            }
            if (Session["QuyenHan"].ToString().Trim() == "User")
            {
                Response.Write("<script type='text/javascript'>");
                Response.Write("alert('Bạn không có quyền truy cập trang này !');");
                Response.Write("document.location.href='Trangchu.aspx';");
                Response.Write("</script>");
            }

            if (!IsPostBack)
            {
                // ✅ Bind combobox nhóm
                ddlNhom.DataSource = db.tblNhoms;
                ddlNhom.DataTextField = "MoTa";
                ddlNhom.DataValueField = "MaNhom";
                ddlNhom.DataBind();
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            if (txtMaNguoiDung.Text == "")
            {
                lblAlert.Text = "Mã người dùng không được để trống";
                return;
            }
            if (txtHoTen.Text == "")
            {
                lblAlert.Text = "Họ tên không được để trống";
                return;
            }
            if (txtTenDN.Text == "")
            {
                lblAlert.Text = "Tên đăng nhập không được để trống";
                return;
            }
            if (txtMatkhau.Text == "")
            {
                lblAlert.Text = "Bạn chưa điền mật khẩu";
                return;
            }
            if (txtMatkhau.Text != txtMatkhau1.Text)
            {
                lblAlert.Text = "Mật khẩu không khớp";
                return;
            }

            tblNguoiDung nd = new tblNguoiDung();
            nd.MaNguoiDung = txtMaNguoiDung.Text;
            nd.HoTen = txtHoTen.Text;
            nd.Email = txtEmail.Text;
            nd.QuyenHan = ddlQuyen.SelectedItem.ToString();
            nd.TenDN = txtTenDN.Text;
            nd.MatKhau = txtMatkhau.Text;
            nd.TrangThai = rblTrangThai.SelectedIndex == 0 ? 0 : 1;

            // ✅ Lưu nhóm
            nd.MaNhom = int.Parse(ddlNhom.SelectedValue);

            db.tblNguoiDungs.InsertOnSubmit(nd);
            db.SubmitChanges();

            lblAlert.Text = "Thông tin người dùng đã được thêm thành công!";
            ResetForm();
        }

        private void ResetForm()
        {
            txtMaNguoiDung.Text = "";
            txtHoTen.Text = "";
            txtEmail.Text = "";
            txtTenDN.Text = "";
            txtMatkhau.Text = "";
            txtMatkhau1.Text = "";
            ddlNhom.SelectedIndex = 0;
            rblTrangThai.ClearSelection();
            ddlQuyen.SelectedIndex = 0;
        }

        protected void btnTaoMoi_Click(object sender, EventArgs e)
        {
            ResetForm();
        }
    }
}
