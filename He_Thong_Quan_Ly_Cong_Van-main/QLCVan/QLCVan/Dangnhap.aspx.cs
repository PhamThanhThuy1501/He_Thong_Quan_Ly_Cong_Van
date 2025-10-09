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
           // tblNguoiDung acc = db.tblNguoiDungs.SingleOrDefault(a => a.TenDN == Login1.UserName && a.MatKhau == encryptpass(Login1.Password));
            tblNguoiDung acc = db.tblNguoiDungs.SingleOrDefault(a => a.TenDN == Login1.UserName && a.MatKhau == Login1.Password);
            if (acc != null)
            {
                Session["TenDN"] = Login1.UserName;
                Session["Matkhau"] = (Login1.Password);
                Session["QuyenHan"] = acc.QuyenHan.ToString();
                Response.Redirect("Trangchu.aspx");

            }
            else
                Login1.FailureText = "Mật khẩu tài khoản không hợp lệ!";
        }
        // mã hóa
        private string encryptpass(string pass)
        {
            System.Security.Cryptography.SHA1 sha = System.Security.Cryptography.SHA1.Create();
            string hashade = System.Convert.ToBase64String(sha.ComputeHash(System.Text.UnicodeEncoding.Unicode.GetBytes(pass)));
            return hashade.Length > 49 ? hashade.Substring(0, 49) : hashade;
        }
    }
}