using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
            if (IsPostBack != true)
            {
                cbl1.DataSource = db.tblNhoms;
                cbl1.DataTextField = "mota";
                cbl1.DataValueField = "manhom";
                cbl1.DataBind();
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            // Kiểm tra các trường bắt buộc
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

            // Lưu thông tin người dùng
            tblNguoiDung nd = new tblNguoiDung();
            nd.MaNguoiDung = txtMaNguoiDung.Text;
            nd.HoTen = txtHoTen.Text;
            nd.Email = txtEmail.Text;
            nd.QuyenHan = ddlQuyen.SelectedItem.ToString();
            nd.TenDN = txtTenDN.Text;
            nd.MatKhau = txtMatkhau.Text;  // Lưu mật khẩu
            nd.TrangThai = rblTrangThai.SelectedIndex == 0 ? 0 : 1;  // Kiểm tra trạng thái

            // Thêm người dùng vào bảng tblNguoiDungs
            db.tblNguoiDungs.InsertOnSubmit(nd);
            db.SubmitChanges();

            // Lưu nhóm người dùng (nếu có)
         /*   foreach (ListItem item in cbl1.Items)
            {
                if (item.Selected)  // Kiểm tra nếu nhóm đã được chọn
                {
                    tblNguoiDungNhom ndNhom = new tblNguoiDungNhom
                    {
                        MaNguoiDung = txtMaNguoiDung.Text,  // Mã người dùng
                        MaNhom = int.Parse(item.Value)  // Mã nhóm đã chọn
                    };
                    db.tblNguoiDungNhom.InsertOnSubmit(ndNhom);  // Thêm vào bảng liên kết
                }
            }*/

            // Lưu thay đổi vào cơ sở dữ liệu
            db.SubmitChanges();

            // Thông báo thành công
            lblAlert.Text = "Thông tin người dùng đã được thêm thành công!";

            // Reset form sau khi thêm thành công
            ResetForm();
        }

        private void ResetForm()
        {
            // Reset các trường
            txtMaNguoiDung.Text = "";
            txtHoTen.Text = "";
            txtEmail.Text = "";
            txtTenDN.Text = "";
            txtMatkhau.Text = "";
            txtMatkhau1.Text = "";

            // Deselect checkbox
            foreach (ListItem item in cbl1.Items)
            {
                item.Selected = false;
            }

            // Reset radio button
            rblTrangThai.ClearSelection();
            ddlQuyen.SelectedIndex = 0;  // Set quyền mặc định là User
        }


        //private string encryptpass(string pass)
        //{
        //    System.Security.Cryptography.SHA1 sha = System.Security.Cryptography.SHA1.Create();
        //    string hashade = System.Convert.ToBase64String(sha.ComputeHash(System.Text.UnicodeEncoding.Unicode.GetBytes(pass)));
        //    return hashade.Length > 49 ? hashade.Substring(0, 49) : hashade;
        //}

        protected void btnTaoMoi_Click(object sender, EventArgs e)
        {
            txtMaNguoiDung.Text = "";
            txtHoTen.Text = "";
            txtEmail.Text = "";
            txtTenDN.Text = "";
            txtMatkhau.Text = "";
            txtMatkhau1.Text = "";
        }

    }
}
