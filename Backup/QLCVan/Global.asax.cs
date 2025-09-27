using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.IO;


namespace QLCVan
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            StreamReader sr = new StreamReader(Server.MapPath(@"Counter.txt"));
            string count = sr.ReadLine();
            sr.Close();
            sr.Dispose();

            Application["HitOnline"] = 0;
            Application["HitCount"] = count;
        }

        protected void Session_Start(object sender, EventArgs e)
        {
          
            Session["User"] = "";
            Application["HitOnline"] = int.Parse(Application["HitOnline"].ToString()) + 1;
            Application.Lock();
            Application["HitCount"] = int.Parse(Application["HitCount"].ToString()) + 1;

            StreamWriter sw = new StreamWriter(Server.MapPath(@"Counter.txt"));
            sw.Write(Application["HitCount"]);
            sw.Close();
            sw.Dispose();

            Application.UnLock();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Application["HitOnline"] = int.Parse(Application["HitOnline"].ToString()) - 1;
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

    }
}
