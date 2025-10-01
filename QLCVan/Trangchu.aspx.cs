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
            if (Session["TenDN"] == null)
            {
                Response.Redirect("Dangnhap.aspx");
                return;
            }

            // Ẩn / hiện control tuỳ quyền
            if (Session["QuyenHan"] != null && Session["QuyenHan"].ToString().Trim() == "User")
            {
                // cột index có thể khác tuỳ GridView, điều chỉnh index nếu cần
                if (GridView1.Columns.Count > 5)
                    GridView1.Columns[5].Visible = false;
            }

            if (Session["TenDN"].ToString().Trim() == "quynm")
            {
                rdoCVmoi.Visible = true;
            }
            else
            {
                rdoCVmoi.Visible = false;
            }

            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        private void BindGrid()
        {
            // Bắt đầu từ bảng NoidungCV, áp filter theo Radio nếu có
            IQueryable<tblNoiDungCV> q = db.tblNoiDungCVs;

            if (rdpCVDen != null && rdpCVDen.Checked)
            {
                q = q.Where(d => d.GuiHayNhan == 1);
            }
            else if (rdoCVdi != null && rdoCVdi.Checked)
            {
                q = q.Where(d => d.GuiHayNhan == 0);
            }
            else if (rdoCVmoi != null && rdoCVmoi.Checked)
            {
                q = q.Where(d => d.TrangThai == false);
            }
            else
            {
                // mặc định không filter
            }

            var ds = from g in q
                     join h in db.tblLoaiCVs on g.MaLoaiCV equals h.MaLoaiCV into lgroup
                     from h in lgroup.DefaultIfEmpty()
                     join f in db.tblFileDinhKems on g.MaCV equals f.MaCV into files
                     orderby g.NgayGui descending
                     select new
                     {
                         g.MaCV,
                         g.SoCV,
                         TenLoaiCV = (h != null ? h.TenLoaiCV : ""),
                         g.NgayGui,
                         TieuDeCV = (g.TieuDeCV ?? "").Length > 50 ? g.TieuDeCV.Substring(0, 50) + "..." : g.TieuDeCV,
                         g.CoQuanBanHanh,
                         g.GhiChu,
                         g.NgayBanHanh,
                         g.NguoiKy,
                         g.NoiNhan,
                         TrichYeuND = (g.TrichYeuND ?? "").Length > 200 ? g.TrichYeuND.Substring(0, 200) + "..." : g.TrichYeuND,
                         // Lấy 1 TenFile (nếu có nhiều file, sẽ lấy file đầu tiên)
                         TenFile = files.Select(ff => ff.TenFile).FirstOrDefault()
                     };

            GridView1.DataSource = ds;
            GridView1.DataBind();
        }


        protected void lnk_Xoa_Click(object sender, EventArgs e)
        {
            string permisson = Session["QuyenHan"] != null ? Session["QuyenHan"].ToString().Trim() : "";
            if (permisson == "Admin")
            {
                LinkButton lnk = (LinkButton)sender;
                string str = lnk.CommandArgument;

                // Xóa file đính kèm DB
                var files = db.tblFileDinhKems.Where(f => f.MaCV == str).ToList();
                foreach (var item in files)
                {
                    db.tblFileDinhKems.DeleteOnSubmit(item);

                    // Nếu bạn lưu file vật lý trên server (Uploads), xóa file trên disk ở đây nếu cần.
                    // var path = Server.MapPath("~/Uploads/" + item.TenFile);
                    // if (System.IO.File.Exists(path)) System.IO.File.Delete(path);
                }

                tblNoiDungCV cv = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV == str);
                if (cv != null)
                {
                    db.tblNoiDungCVs.DeleteOnSubmit(cv);
                    db.SubmitChanges();
                }

                // Reload lại grid
                BindGrid();
            }
        }

        protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }


        protected void rdpCVDen_CheckedChanged(object sender, EventArgs e)
        {
            GridView1.PageIndex = 0;
            BindGrid();
        }

        protected void rdoCVdi_CheckedChanged(object sender, EventArgs e)
        {
            GridView1.PageIndex = 0;
            BindGrid();
        }

        protected void rdoCVmoi_CheckedChanged(object sender, EventArgs e)
        {
            GridView1.PageIndex = 0;
            BindGrid();
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
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        protected void lnkView_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            string fileName = lnk.CommandArgument;
            Response.Redirect("WebView.aspx?file=" + fileName);
        }

    }

}