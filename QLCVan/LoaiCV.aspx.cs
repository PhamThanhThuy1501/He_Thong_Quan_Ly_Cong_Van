using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class LoaiCV : System.Web.UI.Page
    {
        //InfoDataContext db = new InfoDataContext();
        InfoDataContext db; // chỉ khai báo biến, chưa khởi tạo

        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (Session["TenDN"] == null)
        //    {
        //        Response.Redirect("Dangnhap.aspx");
        //    }
        //    if (Session["QuyenHan"] != null && Session["QuyenHan"].ToString().Trim() == "User")
        //    {
        //        Response.Write("<script>alert('Bạn không có quyền truy cập trang này!');document.location.href='Trangchu.aspx';</script>");
        //    }
        //    if (!IsPostBack)
        //    {
        //        load_LoaiCV();
        //    }
        //}

        // code mới gpt
        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ BẮT BUỘC: khởi tạo db bằng connection string trong web.config
            db = new InfoDataContext(
                System.Configuration.ConfigurationManager.ConnectionStrings["QuanLyCongVanConnectionString1"].ConnectionString
            );

            if (Session["TenDN"] == null)
            {
                Response.Redirect("Dangnhap.aspx");
            }

            if (Session["QuyenHan"] != null && Session["QuyenHan"].ToString().Trim() == "User")
            {
                Response.Write("<script>alert('Bạn không có quyền truy cập trang này!');document.location.href='Trangchu.aspx';</script>");
            }

            if (!IsPostBack)
            {
                load_LoaiCV();
            }
        }


        private void load_LoaiCV()
        {
            var data = db.tblLoaiCVs
                         .OrderBy(p => p.MaLoaiCV)
                         .ToList();

            grvLoaiCV.DataSource = data;
            grvLoaiCV.DataBind();
        }

        protected void grvLoaiCV_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvLoaiCV.PageIndex = e.NewPageIndex;
            load_LoaiCV();
        }

        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {
            grvLoaiCV.EditIndex = e.NewEditIndex;
            load_LoaiCV();
        }

        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grvLoaiCV.EditIndex = -1;
            load_LoaiCV();
        }

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
        //protected void btnAdd_Click(object sender, EventArgs e)
        //{
        //    string maStr = txtMaLoaiCV.Text.Trim();
        //    string ten = txtTenLoaiCV.Text.Trim();

        //    if (!string.IsNullOrWhiteSpace(maStr) && !string.IsNullOrWhiteSpace(ten))
        //    {
        //        int maLoai;
        //        if (int.TryParse(maStr, out maLoai))
        //        {
        //            var checkTrung = db.tblLoaiCVs.Any(p => p.MaLoaiCV == maLoai);
        //            if (!checkTrung)
        //            {
        //                tblLoaiCV pr = new tblLoaiCV
        //                {
        //                    MaLoaiCV = maLoai,
        //                    TenLoaiCV = ten
        //                };

        //                db.tblLoaiCVs.InsertOnSubmit(pr);
        //                db.SubmitChanges();

        //                // XÓA input
        //                txtMaLoaiCV.Text = "";
        //                txtTenLoaiCV.Text = "";

        //                // ✅ HIDE modal
        //                mpeAdd.Hide();

        //                // ✅ LOAD lại dữ liệu mới vào GridView
        //                load_LoaiCV();
        //            }
        //            else
        //            {
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "trung", "alert('Mã loại công văn đã tồn tại!');", true);
        //                mpeAdd.Show(); // giữ modal nếu lỗi
        //            }
        //        }
        //        else
        //        {
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "loi", "alert('Mã loại phải là số!');", true);
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "loi", "alert('Mã loại phải là số!');", true);
        //            mpeAdd.Show();
        //        }
        //    }
        //    else
        //    {
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "rong", "alert('Vui lòng nhập đầy đủ thông tin');", true);
        //        mpeAdd.Show();
        //    }
        //}

        // code mói
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

                            // Thông báo debug xem có chạy vào đây không
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ok", "alert('Đã thêm thành công ');", true);

                            // Xóa input
                            txtMaLoaiCV.Text = "";
                            txtTenLoaiCV.Text = "";

                            // Ẩn modal


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
                        // Nếu có lỗi LINQ/SubmitChanges thì sẽ hiện ra ở đây
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
