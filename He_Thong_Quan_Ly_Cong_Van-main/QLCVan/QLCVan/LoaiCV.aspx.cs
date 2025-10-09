using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class LoaiCV : System.Web.UI.Page
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
                load_LoaiCV();
            }
        }
        private void load_LoaiCV()
        {
            var list = (from p in db.tblLoaiCVs select p).ToList();
            grvLoaiCV.DataSource = list;
            grvLoaiCV.DataBind();
        }
        protected void rowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            tblLoaiCV pd = new tblLoaiCV();
            int idex = e.RowIndex;
            string key = grvLoaiCV.DataKeys[idex].Value.ToString();
            //string key = grvLoaiCV.Rows[e.RowIndex].Cells[1].Text;
            tblLoaiCV xoa = db.tblLoaiCVs.SingleOrDefault(p => p.MaLoaiCV == Convert.ToInt32(key));
            db.tblLoaiCVs.DeleteOnSubmit(xoa);
            db.SubmitChanges();
            load_LoaiCV();

        }
        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {

            grvLoaiCV.EditIndex = e.NewEditIndex;
            load_LoaiCV();
        }

        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (InfoDataContext db1 = new InfoDataContext())
            {

                int index = e.RowIndex;
                //string i = Session["ID"].ToString();

                tblLoaiCV pr = db.tblLoaiCVs.SingleOrDefault(p => p.MaLoaiCV == Convert.ToInt32(hdfID.Value));
                TextBox txtTenNhom = (TextBox)grvLoaiCV.Rows[e.RowIndex].FindControl("txtTenLoai");
                pr.TenLoaiCV = txtTenNhom.Text;
                db.SubmitChanges();
                grvLoaiCV.EditIndex = -1;
                load_LoaiCV();
            }



        }
        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grvLoaiCV.EditIndex = -1;
            load_LoaiCV();
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


                TextBox TxtTenLoai = (TextBox)grvLoaiCV.FooterRow.FindControl("txtTenLoai");
                tblLoaiCV pr = new tblLoaiCV();
                pr.TenLoaiCV = TxtTenLoai.Text;
                db.tblLoaiCVs.InsertOnSubmit(pr);
                db.SubmitChanges();

                grvLoaiCV.EditIndex = -1;
                load_LoaiCV();


            }
        }
    }
}