using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.Linq;
using System.Data.Linq.SqlClient;
using System.Data.Linq.Provider;

namespace QLCVan
{
    public partial class Timkiem : System.Web.UI.Page
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
                if (rdpCVDen.Checked == true)
                {

                }
                var lay = from d in db.tblNoiDungCVs
                          select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };

                gvTimkiem.DataSource = lay;
                gvTimkiem.DataBind();
                rdoTatCa.Checked = true;

                var ddls = from d in db.tblLoaiCVs
                           where d.MaLoaiCV.ToString() != null
                           select d;


                DropDownList1.DataSource = ddls;
                DropDownList1.DataTextField = "TenLoaiCV";
                DropDownList1.DataValueField = "MaLoaiCV";
                DropDownList1.DataBind();
            }

            if (Session["QuyenHan"].ToString().Trim() == "User")
            {
                gvTimkiem.Columns[4].Visible = false;

            }

        }
        protected void btnTim_Click(object sender, EventArgs e)
        {
            string strSearch = txtNoiDung.Text;
            var q = from d in db.tblNoiDungCVs
                    where SqlMethods.Like(d.TieuDeCV, "%" + strSearch + "%") || SqlMethods.Like(d.TrichYeuND, "%" + strSearch + "%") || SqlMethods.Like(d.SoCV, "%" + strSearch + "%")
                    select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };
            //var kq = db.NoiDungCVSelect(strSearch);
            gvTimkiem.DataSource = q;
            gvTimkiem.DataBind();

        }
        protected void lnk_Xoa_Click(object sender, EventArgs e)
        {
            if (Session["QuyenHan"].ToString().Trim() == "Admin")
            {
                LinkButton lnk = (sender) as LinkButton;
                string str = lnk.CommandArgument;
                foreach (tblFileDinhKem item in db.tblFileDinhKems.Where(f => f.MaCV == str))
                {
                    db.tblFileDinhKems.DeleteOnSubmit(item);
                }
                tblNoiDungCV cv = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV == str);
                if (cv != null)
                {
                    db.tblNoiDungCVs.DeleteOnSubmit(cv);
                    db.SubmitChanges();
                    Page_Load(sender, e);

                    Response.Redirect("~/Timkiem.aspx");

                }
            }
            if (Session["QuyenHan"].ToString().Trim() == "User")
            {

                Response.Write("<script type='text/javascript'>");
                Response.Write("alert('Bạn không có quyền truy cập trang này !');");
                Response.Write("document.location.href='Trangchu.aspx';");
                Response.Write("</script>");
            }
        }


        protected void gvTimkiem_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

            var lay = from d in db.tblNoiDungCVs
                      select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };
            gvTimkiem.PageIndex = e.NewPageIndex;
            gvTimkiem.DataSource = lay;
            gvTimkiem.DataBind();
        }

        protected void rdpCVDen_CheckedChanged(object sender, EventArgs e)
        {
            var lay = from d in db.tblNoiDungCVs
                      where d.GuiHayNhan == 1
                      select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };

            gvTimkiem.DataSource = lay;
            gvTimkiem.DataBind();
        }

        protected void rdoCVdi_CheckedChanged(object sender, EventArgs e)
        {
            var lay = from d in db.tblNoiDungCVs
                      where d.GuiHayNhan == 0
                      select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };

            gvTimkiem.DataSource = lay;
            gvTimkiem.DataBind();
        }

        protected void rdoTatCa_CheckedChanged(object sender, EventArgs e)
        {
            var lay = from d in db.tblNoiDungCVs
                      select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };

            gvTimkiem.DataSource = lay;
            gvTimkiem.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {


            var lay = from d in db.tblNoiDungCVs
                      where d.MaLoaiCV == int.Parse(DropDownList1.SelectedValue.ToString())
                      select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };

            gvTimkiem.DataSource = lay;
            gvTimkiem.DataBind();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string strSearch = txtNoiDung.Text;
            var q = from d in db.tblNoiDungCVs
                    where SqlMethods.Like(d.TieuDeCV, "%" + strSearch + "%") || SqlMethods.Like(d.TrichYeuND, "%" + strSearch + "%") || SqlMethods.Like(d.SoCV, "%" + strSearch + "%")
                    select new { d.SoCV, d.MaCV, d.TieuDeCV, TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..." };
            //var kq = db.NoiDungCVSelect(strSearch);
            gvTimkiem.DataSource = q;
            gvTimkiem.DataBind();
        }
    }


}
