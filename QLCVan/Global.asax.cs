using System;
using System.Web;
using System.Web.SessionState;
using System.IO;

namespace QLCVan
{
    public class Global : System.Web.HttpApplication
    {
        private string CounterFilePath => Server.MapPath(@"Counter.txt");

        protected void Application_Start(object sender, EventArgs e)
        {
            // Tạo file nếu chưa tồn tại
            if (!File.Exists(CounterFilePath))
            {
                File.WriteAllText(CounterFilePath, "0");
            }

            // Đọc giá trị từ file, parse an toàn
            int count = 0;
            string text = File.ReadAllText(CounterFilePath).Trim();
            int.TryParse(text, out count);

            // Lưu dưới dạng int
            Application["HitOnline"] = 0;
            Application["HitCount"] = count;
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["User"] = "";

            Application.Lock();

            // Khởi tạo mặc định nếu null
            if (Application["HitOnline"] == null) Application["HitOnline"] = 0;
            if (Application["HitCount"] == null) Application["HitCount"] = 0;

            // Tăng số lượng online
            int hitOnline = (int)Application["HitOnline"];
            hitOnline++;
            Application["HitOnline"] = hitOnline;

            // Tăng tổng lượt truy cập
            int hitCount = (int)Application["HitCount"];
            hitCount++;
            Application["HitCount"] = hitCount;

            // Ghi vào file
            File.WriteAllText(CounterFilePath, hitCount.ToString());

            Application.UnLock();
        }

        protected void Session_End(object sender, EventArgs e)
        {
            Application.Lock();

            // Giảm số lượng online, đảm bảo không âm
            if (Application["HitOnline"] != null)
            {
                int hitOnline = (int)Application["HitOnline"];
                hitOnline = Math.Max(hitOnline - 1, 0);
                Application["HitOnline"] = hitOnline;
            }

            Application.UnLock();
        }

        protected void Application_BeginRequest(object sender, EventArgs e) { }

        protected void Application_AuthenticateRequest(object sender, EventArgs e) { }

        protected void Application_Error(object sender, EventArgs e) { }

        protected void Application_End(object sender, EventArgs e) { }
    }
}
