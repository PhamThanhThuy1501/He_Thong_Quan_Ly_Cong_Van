using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class Dangnhap : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
           
        }
        // mã hóa
        private string encryptpass(string pass)
        {
            System.Security.Cryptography.SHA1 sha = System.Security.Cryptography.SHA1.Create();
            string hashade = System.Convert.ToBase64String(sha.ComputeHash(System.Text.UnicodeEncoding.Unicode.GetBytes(pass)));
            return hashade.Length > 49 ? hashade.Substring(0, 49) : hashade;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            tblNguoiDung acc = db.tblNguoiDungs.SingleOrDefault(a => a.TenDN == Username.Text && a.MatKhau == encryptpass(Password.Text));
            if (acc != null)
            {
                Session["TenDN"] = Username.Text;
                Session["Matkhau"] = encryptpass(Password.Text);
                Session["QuyenHan"] = acc.QuyenHan.ToString();
                Response.Redirect("Trangchu.aspx");

            }
            else
            {
                lbThongbaoLoi.Text = "Tài khoản hoặc mật khẩu không đúng! Yêu cầu nhập lại!";
            }
        }
    }
}