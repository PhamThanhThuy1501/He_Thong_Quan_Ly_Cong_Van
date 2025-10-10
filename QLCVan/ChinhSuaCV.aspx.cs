using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class ChinhSuaCV : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra đăng nhập
            if (Session["TenDN"] == null)
            {
                Response.Redirect("Dangnhap.aspx");
                return;
            }

            // Kiểm tra quyền truy cập
            if (Session["QuyenHan"] != null && Session["QuyenHan"].ToString().Trim() == "User")
            {
                Response.Write("<script>alert('Bạn không có quyền truy cập trang này!');window.location='Trangchu.aspx';</script>");
                return;
            }

            if (!Page.IsPostBack)
            {
                btnsua.Visible = false;

                // Nạp danh sách loại công văn
                ddlLoaiCV.DataSource = db.tblLoaiCVs.ToList();
                ddlLoaiCV.DataTextField = "TenLoaiCV";
                ddlLoaiCV.DataValueField = "MaLoaiCV";
                ddlLoaiCV.DataBind();

                // Kiểm tra có id truyền vào không
                if (Request.QueryString["id"] != null)
                {
                    string maCV = Request.QueryString["id"].ToString();
                    tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV.ToString() == maCV);

                    if (cv1 != null)
                    {
                        txttieude.Text = cv1.TieuDeCV;
                        txtngayracv.Text = cv1.NgayGui?.ToString("yyyy-MM-dd");
                        txtcqbh.Text = cv1.CoQuanBanHanh;
                        txtsocv.Text = cv1.SoCV;
                        txttrichyeu.Text = cv1.TrichYeuND ?? "";
                        ddlLoaiCV.SelectedValue = cv1.MaLoaiCV.ToString();
                        RadioButtonList1.SelectedIndex = cv1.GuiHayNhan ?? 0;

                        btnsua.Visible = true;

                        // Hiển thị file đính kèm (nếu có)
                        ListBox1.DataTextField = "TenFile";
                        ListBox1.DataSource = cv1.tblFileDinhKems;
                        ListBox1.DataBind();
                    }
                    else
                    {
                        lblchuachonfile.Text = "Không tìm thấy công văn cần sửa.";
                    }
                }
            }
        }

        // ✅ Nút Lưu / Cập nhật
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                string maCV = Request.QueryString["id"].ToString();
                tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV.ToString() == maCV);

                if (cv1 != null)
                {
                    cv1.TieuDeCV = txttieude.Text.Trim();
                    cv1.NgayGui = DateTime.Parse(txtngayracv.Text);
                    cv1.CoQuanBanHanh = txtcqbh.Text.Trim();
                    cv1.SoCV = txtsocv.Text.Trim();
                    cv1.TrichYeuND = txttrichyeu.Text.Trim();
                    cv1.MaLoaiCV = int.Parse(ddlLoaiCV.SelectedValue);
                    cv1.GuiHayNhan = RadioButtonList1.SelectedIndex;

                    db.SubmitChanges();

                    lblchuachonfile.Text = "✅ Đã cập nhật công văn thành công!";
                    lblchuachonfile.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblchuachonfile.Text = "Không tìm thấy công văn cần cập nhật.";
                    lblchuachonfile.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblchuachonfile.Text = "Không có ID công văn để lưu.";
                lblchuachonfile.ForeColor = System.Drawing.Color.Red;
            }
        }

        // ✅ Nút Upload file
        protected void btnUp_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                try
                {
                    string folderPath = Server.MapPath("~/Uploads/");

                    // Tạo thư mục nếu chưa có
                    if (!System.IO.Directory.Exists(folderPath))
                    {
                        System.IO.Directory.CreateDirectory(folderPath);
                    }

                    string fileName = System.IO.Path.GetFileName(FileUpload1.FileName);
                    string filePath = System.IO.Path.Combine(folderPath, fileName);

                    FileUpload1.SaveAs(filePath);

                    lblchuachonfile.Text = "Tải lên thành công: " + fileName;
                    lblchuachonfile.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    lblchuachonfile.Text = "Lỗi khi tải file: " + ex.Message;
                    lblchuachonfile.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblchuachonfile.Text = "Vui lòng chọn file trước khi upload.";
                lblchuachonfile.ForeColor = System.Drawing.Color.OrangeRed;
            }
        }

        void RemoveFile(int index)
        {
            if (index >= ListBox1.Items.Count) return;
            string filename = ListBox1.Items[index].Value;
            System.IO.File.Delete(filename);
            ListBox1.Items.RemoveAt(index);
        }
        protected void btnRemove_Click(object sender, EventArgs e)
        {

            RemoveFile(ListBox1.SelectedIndex);
        }

        // ✅ Nút Hủy / Quay lại
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Trangchu.aspx");
        }
    }
}
