using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class DanhBaEmail : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!(Session["TenDN"] != null))
            //{
            //    Response.Redirect("Dangnhap.aspx");
            //}
            //if (Session["QuyenHan"].ToString().Trim() == "User")
            //{
            //    Response.Write("<script type='text/javascript'>");
            //    Response.Write("alert('Bạn không có quyền truy cập trang này !');");
            //    Response.Write("document.location.href='Dangnhap.aspx';");
            //    Response.Write("</script>");
            //}
            if (!IsPostBack)
            {
                load_Email();
            }
        }
        private void load_Email()
        {
            var list = (from p in db.DanhBaEmails select p).ToList();
            gvQLEmail.DataSource = list;
            gvQLEmail.DataBind();
        }
    }
}