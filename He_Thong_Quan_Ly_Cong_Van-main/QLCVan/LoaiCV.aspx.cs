using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class LoaiCV : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
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
            // Sắp xếp để hiển thị ổn định
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // ĐÚNG ID textbox theo ASPX: txtTenLoaiNew
            TextBox txtTenLoaiNew = grvLoaiCV.FooterRow.FindControl("txtTenLoaiNew") as TextBox;

            if (txtTenLoaiNew != null)
            {
                var ten = txtTenLoaiNew.Text.Trim();
                if (!string.IsNullOrWhiteSpace(ten))
                {
                    tblLoaiCV pr = new tblLoaiCV { TenLoaiCV = ten };
                    db.tblLoaiCVs.InsertOnSubmit(pr);
                    db.SubmitChanges();

                    grvLoaiCV.EditIndex = -1;
                    load_LoaiCV();
                    txtTenLoaiNew.Text = string.Empty;
                }
            }
        }
    }
}
