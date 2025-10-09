using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class LoaiCV : System.Web.UI.Page
    {
        InfoDataContext db; // Khởi tạo trong Page_Load

        // Dùng ViewState để lưu điều kiện tìm kiếm giữa các postback
        private string FilterMa
        {
            get { return (ViewState["FilterMa"] ?? "").ToString(); }
            set { ViewState["FilterMa"] = value ?? ""; }
        }

        private string FilterTen
        {
            get { return (ViewState["FilterTen"] ?? "").ToString(); }
            set { ViewState["FilterTen"] = value ?? ""; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Khởi tạo db bằng connection string trong Web.config
            db = new InfoDataContext(
                System.Configuration.ConfigurationManager.ConnectionStrings["QuanLyCongVanConnectionString1"].ConnectionString
            );

            // Kiểm tra đăng nhập
            if (Session["TenDN"] == null)
            {
                Response.Redirect("Dangnhap.aspx");
            }

            // Kiểm tra quyền
            if (Session["QuyenHan"] != null && Session["QuyenHan"].ToString().Trim() == "User")
            {
                Response.Write("<script>alert('Bạn không có quyền truy cập trang này!');document.location.href='Trangchu.aspx';</script>");
            }

            // Chỉ load dữ liệu lần đầu (không phải postback)
            if (!IsPostBack)
            {
                FilterMa = "";
                FilterTen = "";
                load_LoaiCV();
            }
        }

        // =====================================================
        // LOAD DỮ LIỆU LÊN GRIDVIEW
        // =====================================================
        private void load_LoaiCV()
        {
            var q = db.tblLoaiCVs.AsQueryable();

            if (!string.IsNullOrWhiteSpace(FilterMa))
                q = q.Where(p => p.MaLoaiCV.ToString().Contains(FilterMa));

            if (!string.IsNullOrWhiteSpace(FilterTen))
                q = q.Where(p => p.TenLoaiCV.Contains(FilterTen));

            var data = q.OrderBy(p => p.MaLoaiCV).ToList();

            grvLoaiCV.DataSource = data;
            grvLoaiCV.DataBind();
        }

        // =====================================================
        // XỬ LÝ SỰ KIỆN TÌM KIẾM
        // =====================================================
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FilterMa = txtSearchMaLoai.Text.Trim();
            FilterTen = txtSearchTenLoai.Text.Trim();

            grvLoaiCV.PageIndex = 0; // về trang đầu
            load_LoaiCV();
        }

        // =====================================================
        // PHÂN TRANG
        // =====================================================
        protected void grvLoaiCV_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvLoaiCV.PageIndex = e.NewPageIndex;
            load_LoaiCV();
        }

        // =====================================================
        // CHỈNH SỬA
        // =====================================================
        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {
            grvLoaiCV.EditIndex = e.NewEditIndex;
            load_LoaiCV();
        }

        // HỦY CHỈNH SỬA
        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grvLoaiCV.EditIndex = -1;
            load_LoaiCV();
        }

        // CẬP NHẬT DỮ LIỆU
        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(grvLoaiCV.DataKeys[e.RowIndex].Value);
            TextBox txtTenLoai = grvLoaiCV.Rows[e.RowIndex].FindControl("txtTenLoai") as TextBox;

            if (txtTenLoai != null)
            {
                var pr = db.tblLoaiCVs.SingleOrDefault(p => p.MaLoaiCV == id);
                if (pr != null)
                {
                    pr.TenLoaiCV = txtTenLoai.Text.Trim();
                    db.SubmitChanges();
                }
            }

            grvLoaiCV.EditIndex = -1;
            load_LoaiCV();
        }

        // =====================================================
        // XÓA
        // =====================================================
        protected void rowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(grvLoaiCV.DataKeys[e.RowIndex].Value);
            var xoa = db.tblLoaiCVs.SingleOrDefault(p => p.MaLoaiCV == id);
            if (xoa != null)
            {
                db.tblLoaiCVs.DeleteOnSubmit(xoa);
                db.SubmitChanges();
            }
            load_LoaiCV();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string maStr = txtMaLoaiCV.Text.Trim();
            string ten = txtTenLoaiCV.Text.Trim();

            if (!string.IsNullOrWhiteSpace(maStr) && !string.IsNullOrWhiteSpace(ten))
            {
                int maLoai;
                if (int.TryParse(maStr, out maLoai))
                {
                    try
                    {
                        // Kiểm tra trùng mã loại
                        var checkTrung = db.tblLoaiCVs.Any(p => p.MaLoaiCV == maLoai);
                        if (!checkTrung)
                        {
                            tblLoaiCV pr = new tblLoaiCV
                            {
                                MaLoaiCV = maLoai,
                                TenLoaiCV = ten
                            };

                            db.tblLoaiCVs.InsertOnSubmit(pr);
                            db.SubmitChanges();

                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ok", "alert('Đã thêm thành công');", true);

                            // Xóa input
                            txtMaLoaiCV.Text = "";
                            txtTenLoaiCV.Text = "";

                            load_LoaiCV();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "trung", "alert('Mã loại công văn đã tồn tại!');", true);
                            mpeAdd.Show();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "err", $"alert('Lỗi khi thêm: {ex.Message}');", true);
                        mpeAdd.Show();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loi", "alert('Mã loại phải là số!');", true);
                    mpeAdd.Show();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "rong", "alert('Vui lòng nhập đầy đủ');", true);
                mpeAdd.Show();
            }
        }
    }
}
