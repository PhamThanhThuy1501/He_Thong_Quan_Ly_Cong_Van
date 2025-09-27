using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan.UserControl
{
    public partial class HitCount : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            lblHitCount.Text = "<b>" + "Số lượng truy cập:" + "</b>" + "&nbsp;<font color=red>" + Application["HitCount"] + "</font>";
            lblHitOnline.Text = "<b>" + "Số người đang online:" + "</b>" + "&nbsp;<font color=red>" + Application["HitOnline"] + "&nbsp;&nbsp;&nbsp;&nbsp;</font>";
        }
    }
}