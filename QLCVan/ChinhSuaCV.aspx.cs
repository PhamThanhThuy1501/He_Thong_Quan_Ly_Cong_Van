using System;
using System.Linq;
using System.Web.UI;

namespace QLCVan
{
    public partial class ChinhSuaCV : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null)
            {
                Response.Redirect("Dangnhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // load ddlLoaiCV
                ddlLoaiCV.DataSource = db.tblLoaiCVs.OrderBy(x => x.TenLoaiCV).ToList();
                ddlLoaiCV.DataTextField = "TenLoaiCV";
                ddlLoaiCV.DataValueField = "MaLoaiCV";
                ddlLoaiCV.DataBind();
                ddlLoaiCV.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Chọn loại --", ""));

                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    LoadData(id.Trim());
                }
                else
                {
                    lblMsg.Text = "<span style='color:red'>Không có mã công văn truyền vào.</span>";
                }
            }
        }

        private void LoadData(string maCV)
        {
            try
            {
                // MaCV là string (GUID hoặc chuỗi)
                var cv = db.tblNoiDungCVs.SingleOrDefault(x => (x.MaCV ?? "").Trim() == maCV);
                if (cv == null)
                {
                    lblMsg.Text = "<span style='color:red'>Không tìm thấy công văn.</span>";
                    return;
                }

                hdnMaCV.Value = cv.MaCV;
                txtTieuDe.Text = cv.TieuDeCV ?? "";
                txtSoCV.Text = cv.SoCV ?? "";
                txtCQBH.Text = cv.CoQuanBanHanh ?? "";
                txtTrichYeu.Text = cv.TrichYeuND ?? "";
                txtNgayBH.Text = cv.NgayBanHanh.HasValue ? cv.NgayBanHanh.Value.ToString("yyyy-MM-dd") : "";
                txtNgayGui.Text = cv.NgayGui.HasValue ? cv.NgayGui.Value.ToString("yyyy-MM-dd") : "";

                // chọn ddl
                if (cv.MaLoaiCV.HasValue)
                {
                    var it = ddlLoaiCV.Items.FindByValue(cv.MaLoaiCV.Value.ToString());
                    if (it != null) ddlLoaiCV.SelectedValue = cv.MaLoaiCV.Value.ToString();
                }

                // binding file list (nếu cần)
                var files = db.tblFileDinhKems.Where(f => (f.MaCV ?? "").Trim() == maCV).Select(f => new { f.TenFile, f.Url }).ToList();
                rptFiles.DataSource = files;
                rptFiles.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "<span style='color:red'>Lỗi khi tải dữ liệu: " + Server.HtmlEncode(ex.Message) + "</span>";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string maCV = hdnMaCV.Value;
                if (string.IsNullOrEmpty(maCV))
                {
                    lblMsg.Text = "<span style='color:red'>Không xác định mã công văn.</span>";
                    return;
                }

                var cv = db.tblNoiDungCVs.SingleOrDefault(x => (x.MaCV ?? "").Trim() == maCV.Trim());
                if (cv == null)
                {
                    lblMsg.Text = "<span style='color:red'>Không tìm thấy công văn để cập nhật.</span>";
                    return;
                }

                // Cập nhật
                cv.TieuDeCV = txtTieuDe.Text.Trim();
                cv.SoCV = txtSoCV.Text.Trim();
                cv.CoQuanBanHanh = txtCQBH.Text.Trim();
                cv.TrichYeuND = txtTrichYeu.Text.Trim();

                if (DateTime.TryParse(txtNgayBH.Text, out DateTime ngaybh))
                    cv.NgayBanHanh = ngaybh;
                else
                    cv.NgayBanHanh = null;

                if (DateTime.TryParse(txtNgayGui.Text, out DateTime ngaygui))
                    cv.NgayGui = ngaygui;
                else
                    cv.NgayGui = null;

                if (int.TryParse(ddlLoaiCV.SelectedValue, out int maloai))
                    cv.MaLoaiCV = maloai;
                else
                    cv.MaLoaiCV = null;

                db.SubmitChanges();

                lblMsg.Text = "<span style='color:green'>Cập nhật thành công.</span>";

                // Redirect về trang chi tiết hoặc trang chủ nếu muốn:
                Response.Redirect("CTCV.aspx?id=" + Server.UrlEncode(maCV));
            }
            catch (Exception ex)
            {
                lblMsg.Text = "<span style='color:red'>Lỗi khi lưu: " + Server.HtmlEncode(ex.Message) + "</span>";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            string maCV = hdnMaCV.Value;
            if (!string.IsNullOrEmpty(maCV))
                Response.Redirect("CTCV.aspx?id=" + Server.UrlEncode(maCV));
            else
                Response.Redirect("Trangchu.aspx");
        }
    }
}
