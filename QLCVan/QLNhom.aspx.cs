using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLNhom1 : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Session["TenDN"] != null))
            {
                Response.Redirect("Dangnhap.aspx");
            }
            if (Session["QuyenHan"].ToString().Trim() == "User")
            {
                Response.Write("<script type='text/javascript'>");
                Response.Write("alert('Bạn không có quyền truy cập trang này !');");
                Response.Write("document.location.href='Trangchu.aspx';");
                Response.Write("</script>");
            }
            if (!IsPostBack)
            {
                load_Nhom();
            }
        }

        private void load_Nhom()
        {
            var list = (from p in db.tblNhoms select p).ToList();
            gvQLNhom.DataSource = list;
            gvQLNhom.DataBind();
        }

        protected void rowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string key = gvQLNhom.DataKeys[e.RowIndex].Value.ToString();
            tblNhom xoa = db.tblNhoms.SingleOrDefault(p => p.MaNhom == Convert.ToInt32(key));
            if (xoa != null)
            {
                db.tblNhoms.DeleteOnSubmit(xoa);
                db.SubmitChanges();
            }
            load_Nhom();
        }

        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {
            gvQLNhom.EditIndex = e.NewEditIndex;
            load_Nhom();
        }

        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int index = e.RowIndex;
            tblNhom pr = db.tblNhoms.SingleOrDefault(p => p.MaNhom == Convert.ToInt32(hdfID.Value));
            TextBox txtTenNhom = (TextBox)gvQLNhom.Rows[e.RowIndex].FindControl("txtTenNhom");
            if (pr != null && txtTenNhom != null)
            {
                pr.MoTa = txtTenNhom.Text.Trim();
                db.SubmitChanges();
            }
            gvQLNhom.EditIndex = -1;
            load_Nhom();
        }

        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQLNhom.EditIndex = -1;
            load_Nhom();
        }

        protected void rowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                hdfID.Value = Convert.ToString(e.CommandArgument.ToString());
            }
        }

        // ✅ Hàm xử lý lưu khi bấm nút trong popup modal
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string tenNhom = txtTenNhomMoi.Text.Trim();

            if (string.IsNullOrEmpty(tenNhom))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Tên nhóm không được để trống!');", true);
                return;
            }

            // Kiểm tra trùng tên
            var check = db.tblNhoms.FirstOrDefault(p => p.MoTa == tenNhom);
            if (check != null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Tên nhóm đã tồn tại!');", true);
                return;
            }

            tblNhom pr = new tblNhom();
            pr.MoTa = tenNhom;
            db.tblNhoms.InsertOnSubmit(pr);
            db.SubmitChanges();

            load_Nhom();
            txtTenNhomMoi.Text = "";

            // Đóng modal sau khi thêm
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#addModal').modal('hide');", true);
        }
        protected void gvQLNhom_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvQLNhom.PageIndex = e.NewPageIndex; // chuyển đến trang mới
            load_Nhom(); // gọi lại hàm load dữ liệu
        }

    }
}
