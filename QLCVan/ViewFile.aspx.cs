using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class ViewFile : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Session["TenDN"] != null))
            {
                Response.Redirect("Dangnhap.aspx");
            }
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (string.IsNullOrEmpty(id))
                {
                    Response.Write("Không tìm thấy mã công văn!");
                    return;
                }

                // Lấy file đầu tiên theo mã công văn
                var file = db.tblFileDinhKems.FirstOrDefault(f => f.MaCV == id);
                if (file == null)
                {
                    Response.Write("Không tìm thấy file đính kèm!");
                    return;
                }

                // Lấy đường dẫn url từ DB
                string url = file.Url?.Trim();
                if (string.IsNullOrEmpty(url))
                {
                    Response.Write("File không có URL hợp lệ!");
                    return;
                }

                // Map ra đường dẫn vật lý
                string physicalPath = Server.MapPath(url);
                string ext = System.IO.Path.GetExtension(url).ToLower();

                // Debug 
                System.Diagnostics.Debug.WriteLine("📂 URL: " + url);
                System.Diagnostics.Debug.WriteLine("📂 Physical path: " + physicalPath);
                System.Diagnostics.Debug.WriteLine("📂 Exists: " + System.IO.File.Exists(physicalPath));

                if (!System.IO.File.Exists(physicalPath))
                {
                    Response.Write("File không tồn tại trên server!");
                    return;
                }

                if (ext == ".pdf")
                {
                    // Hiển thị PDF qua ViewerJS
                    viewerFrame.Src = "/Scripts/viewerjs-0.5.8/ViewerJS/#" + ResolveUrl(url);
                }
                else
                {
                    // File khác thì tải xuống
                    Response.Clear();
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader(
                        "Content-Disposition",
                        "attachment; filename=" + HttpUtility.UrlPathEncode(System.IO.Path.GetFileName(url))
                    );
                    Response.TransmitFile(physicalPath);
                    Response.End();
                }
            }
        }
    }
}