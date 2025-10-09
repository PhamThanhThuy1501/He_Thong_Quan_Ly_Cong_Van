using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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

            tblNhom pd = new tblNhom();
            int idex = e.RowIndex;
            string key = gvQLNhom.DataKeys[e.RowIndex].Value.ToString();
            tblNhom xoa = db.tblNhoms.SingleOrDefault(p => p.MaNhom == Convert.ToInt32(key));
            db.tblNhoms.DeleteOnSubmit(xoa);
            db.SubmitChanges();
            load_Nhom();

        }
        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {

            gvQLNhom.EditIndex = e.NewEditIndex;
            load_Nhom();
        }

        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (InfoDataContext db1 = new InfoDataContext())
            {

                int index = e.RowIndex;
                tblNhom pr = db.tblNhoms.SingleOrDefault(p => p.MaNhom == Convert.ToInt32(hdfID.Value));
                TextBox txtTenNhom = (TextBox)gvQLNhom.Rows[e.RowIndex].FindControl("txtTenNhom");
                pr.MoTa = txtTenNhom.Text;
                db.SubmitChanges();
                gvQLNhom.EditIndex = -1;
                load_Nhom();
            }



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
                //Session["ID"] = Convert.ToString(e.CommandArgument.ToString());
                hdfID.Value = Convert.ToString(e.CommandArgument.ToString());


            }




            if (e.CommandName.Equals("AddNew"))
            {


                TextBox TxtTenNhom = (TextBox)gvQLNhom.FooterRow.FindControl("txtTenNhom");
                tblNhom pr = new tblNhom();
                pr.MoTa = TxtTenNhom.Text;


                db.tblNhoms.InsertOnSubmit(pr);
                db.SubmitChanges();

                gvQLNhom.EditIndex = -1;
                load_Nhom();



            }
        }

    }
}