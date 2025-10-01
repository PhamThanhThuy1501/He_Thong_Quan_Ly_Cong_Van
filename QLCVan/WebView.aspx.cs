using GroupDocs.Viewer;
using GroupDocs.Viewer.Config;
using GroupDocs.Viewer.Converter.Options;
using GroupDocs.Viewer.Domain;
using GroupDocs.Viewer.Domain.Containers;
using GroupDocs.Viewer.Domain.Html;
using GroupDocs.Viewer.Domain.Options;
using GroupDocs.Viewer.Handler;
using System;
using System.IO;
using System.Text;

namespace QLCVan
{
    public partial class WebView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string fileName = Request.QueryString["file"];
                if (!string.IsNullOrEmpty(fileName))
                {
                    string filePath = Server.MapPath("~/Upload/" + fileName);

                    if (File.Exists(filePath))
                    {
                        string tempDir = Server.MapPath("~/Upload/Temp/" + Guid.NewGuid());
                        Directory.CreateDirectory(tempDir);

                        string combinedHtmlPath = Path.Combine(tempDir, "all_pages.html");
                        StringBuilder sb = new StringBuilder();

                        // 1. Config
                        ViewerConfig config = new ViewerConfig();
                        config.StoragePath = Path.GetDirectoryName(filePath);

                        ViewerHtmlHandler handler = new ViewerHtmlHandler(config);

                        // 2. Thông tin file
                        DocumentInfoContainer info = handler.GetDocumentInfo(filePath);
                        int totalPages = info.Pages.Count;

                        // 3. Render từng trang
                        for (int page = 1; page <= totalPages; page++)
                        {
                            HtmlOptions htmlOptions = new HtmlOptions();
                            htmlOptions.EmbedResources = true;
                            htmlOptions.PageNumber = page;
                            htmlOptions.CountPagesToRender = 1; // chỉ render 1 trang

                            var pages = handler.GetPages(filePath, htmlOptions);

                            foreach (PageHtml p in pages)
                            {
                                string html = p.HtmlContent;

                                int bodyStart = html.IndexOf("<body>", StringComparison.OrdinalIgnoreCase);
                                int bodyEnd = html.IndexOf("</body>", StringComparison.OrdinalIgnoreCase);

                                if (bodyStart >= 0 && bodyEnd > bodyStart)
                                {
                                    string bodyContent = html.Substring(bodyStart + 6, bodyEnd - (bodyStart + 6));
                                    sb.Append(bodyContent);
                                }
                            }
                        }

                        // 4. Ghép HTML
                        string finalHtml = "<html><head><meta charset='utf-8'></head><body>"
                                           + sb.ToString()
                                           + "</body></html>";
                        File.WriteAllText(combinedHtmlPath, finalHtml, Encoding.UTF8);

                        iframeDoc.Attributes["src"] = ResolveUrl("~/Upload/Temp/"
                            + Path.GetFileName(tempDir) + "/all_pages.html");
                    }
                    else
                    {
                        Response.Write("❌ File không tồn tại: " + filePath);
                    }
                }
            }
        }
    }
}
