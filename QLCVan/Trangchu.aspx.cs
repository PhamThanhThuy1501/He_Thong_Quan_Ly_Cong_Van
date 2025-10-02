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

            if (!IsPostBack)
            {
                LoadData();
            }
        }
        private void LoadData()
        {
            var data = from g in db.tblNoiDungCVs
                       from h in db.tblLoaiCVs
                       where g.MaLoaiCV == h.MaLoaiCV
                       orderby g.NgayGui descending
                       select new
                       {
                           g.MaCV,
                           g.SoCV,
                           h.TenLoaiCV,
                           g.NgayGui,
                           TieuDeCV = g.TieuDeCV.Length > 50 ? g.TieuDeCV.Substring(0, 50) + "..." : g.TieuDeCV,
                           g.CoQuanBanHanh,
                           g.GhiChu,
                           g.NgayBanHanh,
                           g.NguoiKy,
                           g.NoiNhan,
                           TrichYeuND = g.TrichYeuND.Length > 200 ? g.TrichYeuND.Substring(0, 200) + "..." : g.TrichYeuND,
                           g.TrangThai,
                           g.GuiHayNhan
                       };

            // Nếu chọn "Xem tất cả" thì bỏ lọc
            if (!chkTatCa.Checked)
            {
                if (chkCVDen.Checked)
                    data = data.Where(x => x.GuiHayNhan == 1); // công văn đến
                if (chkCVdi.Checked)
                    data = data.Where(x => x.GuiHayNhan == 0); // công văn đi
                if (chkCVmoi.Checked)
                    data = data.Where(x => x.TrangThai == false); // công văn mới
            }

            GridView1.DataSource = data;
            GridView1.DataBind();
        }

        protected void lnk_Xoa_Click(object sender, EventArgs e)
        {
            string permisson = Session["QuyenHan"].ToString().Trim();
            if (permisson == "Admin")
            {
                LinkButton lnk = sender as LinkButton;
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
                    LoadData();
                }
            }
        }

        protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            LoadData();
        }

        // Sự kiện cho CheckBox
        protected void chkCVDen_CheckedChanged(object sender, EventArgs e)
        {
            if (chkCVDen.Checked)
            {
                chkCVdi.Checked = false;
                chkCVmoi.Checked = false;
                chkTatCa.Checked = false;
            }
            LoadData();
        }

        protected void chkCVdi_CheckedChanged(object sender, EventArgs e)
        {
            if (chkCVdi.Checked)
            {
                chkCVDen.Checked = false;
                chkCVmoi.Checked = false;
                chkTatCa.Checked = false;
            }
            LoadData();
        }

        protected void chkCVmoi_CheckedChanged(object sender, EventArgs e)
        {
            if (chkCVmoi.Checked)
            {
                chkCVDen.Checked = false;
                chkCVdi.Checked = false;
                chkTatCa.Checked = false;
            }
            LoadData();
        }

        protected void chkTatCa_CheckedChanged(object sender, EventArgs e)
        {
            if (chkTatCa.Checked)
            {
                chkCVDen.Checked = false;
                chkCVdi.Checked = false;
                chkCVmoi.Checked = false;
            }

            var lay = from g in db.tblNoiDungCVs
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

            GridView1.DataSource = lay;
            GridView1.DataBind();
        }

        public string kttrangthai(object obj)
        {
            bool trangthai = bool.Parse(obj.ToString());
            return trangthai ? "Đã duyệt" : "Chưa duyệt";
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // bạn có thể bổ sung code search ở đây
        }
    }
}

