using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace QLCVan
{
    public partial class Trangchu : System.Web.UI.Page
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
                GridView1.Columns[5].Visible = false;
                var lay = from d in db.tblNoiDungCVs
                          where d.TrangThai == true
                          select new
                          {
                              d.MaCV,
                              d.SoCV,
                              d.NgayGui,
                              d.TieuDeCV,
                              d.CoQuanBanHanh,
                              d.GhiChu,
                              d.NgayBanHanh,
                              d.NguoiKy,
                              d.NoiNhan,
                              TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..."
                          };

                GridView1.DataSource = lay;
                GridView1.DataBind();

            }
            if (Session["TenDN"].ToString().Trim() == "quynm")
            {
                rdoCVmoi.Visible = true;
                var lay = from d in db.tblNoiDungCVs
                          where d.TrangThai == false
                          select new
                          {
                              d.MaCV,
                              d.SoCV,
                              d.NgayGui,
                              d.TieuDeCV,
                              d.CoQuanBanHanh,
                              d.GhiChu,
                              d.NgayBanHanh,
                              d.NguoiKy,
                              d.NoiNhan,
                              TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..."
                          };

                GridView1.DataSource = lay;
                GridView1.DataBind();
            }
            else
            {
                rdoCVmoi.Visible = false;
            }

            var gv1 = from g in db.tblNoiDungCVs
                      from h in db.tblLoaiCVs
                      where g.MaLoaiCV == h.MaLoaiCV
                      orderby g.NgayGui descending
                      select new
                      {
                          g.MaCV,
                          g.SoCV,
                          h.TenLoaiCV,
                          g.NgayGui,
                          TieuDeCV = g.TieuDeCV.Substring(0, 50) + "...",
                          g.CoQuanBanHanh,
                          g.GhiChu,
                          g.NgayBanHanh,
                          g.NguoiKy,
                          g.NoiNhan,
                          TrichYeuND = g.TrichYeuND.Substring(0, 200) + "..."
                      };
            GridView1.DataSource = gv1;
            GridView1.DataBind();

        }


        protected void lnk_Xoa_Click(object sender, EventArgs e)
        {
            string permisson = Session["QuyenHan"].ToString().Trim();
            if (permisson == "Admin")
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

                    Response.Redirect("~/Trangchu.aspx");

                }
            }

        }

        protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {

            var ddls = from d in db.tblLoaiCVs
                       where d.MaLoaiCV.ToString() != null
                       select d.TenLoaiCV;

            var gv1 = from g in db.tblNoiDungCVs
                      from h in db.tblLoaiCVs
                      where g.MaLoaiCV == h.MaLoaiCV
                      orderby g.NgayGui descending
                      select new
                      {
                          g.MaCV,
                          g.SoCV,
                          h.TenLoaiCV,
                          g.NgayGui,
                          g.TieuDeCV,
                          g.CoQuanBanHanh,
                          g.GhiChu,
                          g.NgayBanHanh,
                          g.NguoiKy,
                          g.NoiNhan,
                          TrichYeuND = g.TrichYeuND.Substring(0, 200) + "..."

                      };
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataSource = gv1;
            GridView1.DataBind();
        }

        protected void rdpCVDen_CheckedChanged(object sender, EventArgs e)
        {
            var lay = from d in db.tblNoiDungCVs
                      where d.GuiHayNhan == 1
                      select new
                      {
                          d.MaCV,
                          d.SoCV,
                          d.NgayGui,
                          d.TieuDeCV,
                          d.CoQuanBanHanh,
                          d.GhiChu,
                          d.NgayBanHanh,
                          d.NguoiKy,
                          d.NoiNhan,
                          TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..."
                      };

            GridView1.DataSource = lay;
            GridView1.DataBind();
        }

        protected void rdoCVdi_CheckedChanged(object sender, EventArgs e)
        {
            var lay = from d in db.tblNoiDungCVs
                      where d.GuiHayNhan == 0
                      select new
                      {
                          d.MaCV,
                          d.SoCV,

                          d.NgayGui,
                          d.TieuDeCV,
                          d.CoQuanBanHanh,
                          d.GhiChu,
                          d.NgayBanHanh,
                          d.NguoiKy,
                          d.NoiNhan,
                          TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..."
                      };

            GridView1.DataSource = lay;
            GridView1.DataBind();
        }

        protected void rdoCVmoi_CheckedChanged(object sender, EventArgs e)
        {
            var lay = from d in db.tblNoiDungCVs
                      where d.TrangThai == false
                      select new
                      {
                          d.MaCV,
                          d.SoCV,
                          d.NgayGui,
                          d.TieuDeCV,
                          d.CoQuanBanHanh,
                          d.GhiChu,
                          d.NgayBanHanh,
                          d.NguoiKy,
                          d.NoiNhan,
                          TrichYeuND = d.TrichYeuND.Substring(0, 100) + " ..."
                      };

            GridView1.DataSource = lay;
            GridView1.DataBind();
        }
        public string kttrangthai(object obj)
        {
            bool trangthai = bool.Parse(obj.ToString());
            if (trangthai)
            {
                return "Đã duyệt";
            }
            else
            {
                return "Chưa duyệt";
            }
        }


    }

}