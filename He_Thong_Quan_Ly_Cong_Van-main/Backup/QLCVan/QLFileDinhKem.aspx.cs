using System;
using System.IO;
using System.Linq;

namespace QLCVan
{
    public partial class QuanLyFileDinhKem : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext(); 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFiles();
            }
        }

        private void LoadFiles()
        {
            string maCV = txtCV.Text.Trim();
            if (!string.IsNullOrEmpty(maCV))
            {
                gvFiles.DataSource = db.tblFileDinhKems.Where(f => f.MaCV == maCV).ToList();
                gvFiles.DataBind();
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (Session["Role"] == null || !HasPermission("ManageAttachments"))
            {
                lblMessage.Text = "Bạn không có quyền thao tác với file đính kèm.";
                return;
            }

            if (!fileUpload.HasFile)
            {
                lblMessage.Text = "Vui lòng chọn file để tải lên.";
                return;
            }
            string fileName = Path.GetFileName(fileUpload.FileName);
            string folder = Server.MapPath("/Uploads/");
            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);

            string filePath = Path.Combine(folder, fileName);
            fileUpload.SaveAs(filePath);

            tblFileDinhKem file = new tblFileDinhKem
            {
                MaCV = txtMaCV.Text.Trim(),
                Tenfile = fileName,
                Url = "/Uploads/" + fileName,
                Size = fileUpload.PostedFile.ContentLength,
                Mota = txtMota.Text.Trim()
            };

            db.tblFileDinhKems.InsertOnSubmit(file);
            db.SubmitChanges();

            lblMessage.Text = "Tải lên thành công!";
            LoadFiles();
        }

        protected void gvFiles_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            if (Session["Role"] == null || !HasPermission("ManageAttachments"))
            {
                lblMessage.Text = "⚠️ Bạn không có quyền xóa file.";
                return;
            }

            int fileId = Convert.ToInt32(gvFiles.DataKeys[e.RowIndex].Value);
            var file = db.tblFileDinhKems.FirstOrDefault(f => f.FileID == fileId);

            if (file != null)
            {
                string path = Server.MapPath(file.Url);
                if (File.Exists(path))
                    File.Delete(path);

                db.tblFileDinhKems.DeleteOnSubmit(file);
                db.SubmitChanges();
                lblMessage.Text = "🗑️ Đã xóa file.";
                LoadFiles();
            }
        }

        private bool HasPermission(string permissionName)
        {
            if (Session["Permissions"] != null)
            {
                var permissions = Session["Permissions"].ToString().Split(',');
                return permissions.Contains(permissionName);
            }
            return false;
        }
    }
}
