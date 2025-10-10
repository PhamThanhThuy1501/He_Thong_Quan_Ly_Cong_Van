using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLCV : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            InfoDataContext db = new InfoDataContext();
            lblWelcome.Visible = false;
            if (Session["TenDN"] != null)
            {
                lblWelcome.Visible = true;
                lbtLogIn.Visible = false;
                lblWelcome.Text = "Xin chào: " + Session["TenDN"].ToString();
            }

            // Loại bỏ mục "Danh bạ email" và "Tìm kiếm công văn" khỏi menu
            rptMenu.DataSource = db.tblMenus.Where(c => c.MenuID.ToString() == "1" || c.MenuID.ToString() == "7" ||
                                                        c.MenuID.ToString() == "6" || c.MenuID.ToString() == "4" ||
                                                        c.MenuID.ToString() == "5" || c.MenuID.ToString() == "2" ||
                                                        c.MenuID.ToString() == "3")
                                             .Where(c => c.MenuName != "Danh bạ email" && c.MenuName != "Tìm kiếm công văn");  // Loại bỏ cả "Danh bạ email" và "Tìm kiếm công văn"
            rptMenu.DataBind();

            /*rptMenu2.DataSource = db.tblMenus.Where(c => c.MenuID.ToString() == "2" || c.MenuID.ToString() == "7" ||
                                                         c.MenuID.ToString() == "3" || c.MenuID.ToString() == "4");
            rptMenu2.DataBind();*/
        }


        protected void lbtLogOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            lbtLogIn.Visible = true;
            lblWelcome.Visible = false;
            lbtLogOut.Visible = false;
            Response.Redirect("Trangchu.aspx");
        }

        protected void lbtLogIn_Click(object sender, EventArgs e)
        {

            Response.Redirect("Dangnhap.aspx");
        }
    }
}