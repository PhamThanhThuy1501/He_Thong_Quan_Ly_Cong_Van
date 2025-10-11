using System;
using System.Linq;
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
            }

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            var q = from g in db.tblNoiDungCVs
                    join h in db.tblLoaiCVs on g.MaLoaiCV equals h.MaLoaiCV
                    select new { g, h };

            var data = q
                .OrderByDescending(x => x.g.NgayGui)
                .Select(x => new
                {
                    x.g.MaCV,
                    x.g.SoCV,
                    TenLoaiCV = x.h.TenLoaiCV,
                    x.g.NgayGui,
                    TieuDeCV = x.g.TieuDeCV.Length > 50 ? x.g.TieuDeCV.Substring(0, 50) + "..." : x.g.TieuDeCV,
                    x.g.CoQuanBanHanh,
                    x.g.GhiChu,
                    x.g.NgayBanHanh,
                    x.g.NguoiKy,
                    x.g.NoiNhan,
                    TrichYeuND = x.g.TrichYeuND.Length > 200 ? x.g.TrichYeuND.Substring(0, 200) + "..." : x.g.TrichYeuND,
                    x.g.TrangThai,         // bool
                    x.g.GuiHayNhan         // int (0: đi, 1: đến)
                });

            GridView1.DataSource = data;
            GridView1.DataBind();
        }

        protected void lnk_Xoa_Click(object sender, EventArgs e)
        {
            string permisson = (Session["QuyenHan"] as string)?.Trim();

            if (string.Equals(permisson, "Admin", StringComparison.OrdinalIgnoreCase))
            {
                LinkButton lnk = sender as LinkButton;
                string maCv = lnk.CommandArgument;

                foreach (tblFileDinhKem item in db.tblFileDinhKems.Where(f => f.MaCV == maCv))
                    db.tblFileDinhKems.DeleteOnSubmit(item);

                tblNoiDungCV cv = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV == maCv);
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

        // DÙNG LẠI: nếu cần text đơn giản
        public string kttrangthai(object obj)
        {
            bool trangthai = bool.Parse(obj.ToString());
            return trangthai ? "Đã duyệt" : "Chưa duyệt";
        }

        // **TRẠNG THÁI HIỂN THỊ DẠNG BADGE – CỐ ĐỊNH THEO 3 GIÁ TRỊ**
        // - true  -> "Đã gửi" (xanh đặc)
        // - false + GuiHayNhan = 0 -> "Không duyệt" (đỏ viền)
        // - false + GuiHayNhan != 0 -> "Đang trình" (cam viền)
        public string GetTrangThai(object oTrangThai, object oGuiHayNhan)
        {
            bool trangThai = false;
            int guiHayNhan = -1;
            if (oTrangThai != null) bool.TryParse(oTrangThai.ToString(), out trangThai);
            if (oGuiHayNhan != null) int.TryParse(oGuiHayNhan.ToString(), out guiHayNhan);

            if (trangThai)
                return "<span class='badge badge--success'>Đã gửi</span>";

            if (guiHayNhan == 0)
                return "<span class='badge badge--danger'>Không duyệt</span>";

            return "<span class='badge badge--warning'>Đang trình</span>";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = TextBox1.Text.Trim();
            string tieuDe = txtTieuDe.Text.Trim();
            string loai = ddlLoai.SelectedValue;
            DateTime fromDate, toDate;

            var q = from g in db.tblNoiDungCVs
                    join h in db.tblLoaiCVs on g.MaLoaiCV equals h.MaLoaiCV
                    select new { g, h };

            if (!string.IsNullOrEmpty(keyword))
                q = q.Where(x => x.g.SoCV.Contains(keyword));

            if (!string.IsNullOrEmpty(tieuDe))
                q = q.Where(x => x.g.TieuDeCV.Contains(tieuDe));

            if (!string.IsNullOrEmpty(loai))
            {
                if (loai == "2")
                {
                    q = q.Where(x => x.g.TrangThai == false); // Dự thảo
                }
                else if (loai == "3")
                {
                    // Nội bộ -> không lọc thêm
                }
                else
                {
                    int loaiCV = int.Parse(loai); // 1: đến, 0: đi
                    q = q.Where(x => x.g.GuiHayNhan == loaiCV);
                }
            }

            if (DateTime.TryParse(txtFromDate.Text.Trim(), out fromDate))
                q = q.Where(x => x.g.NgayGui >= fromDate);

            if (DateTime.TryParse(txtToDate.Text.Trim(), out toDate))
                q = q.Where(x => x.g.NgayGui <= toDate);

            var data = q
                .OrderByDescending(x => x.g.NgayGui)
                .Select(x => new
                {
                    x.g.MaCV,
                    x.g.SoCV,
                    TenLoaiCV = x.h.TenLoaiCV,
                    x.g.NgayGui,
                    TieuDeCV = x.g.TieuDeCV.Length > 50 ? x.g.TieuDeCV.Substring(0, 50) + "..." : x.g.TieuDeCV,
                    x.g.CoQuanBanHanh,
                    x.g.GhiChu,
                    x.g.NgayBanHanh,
                    x.g.NguoiKy,
                    x.g.NoiNhan,
                    TrichYeuND = x.g.TrichYeuND.Length > 200 ? x.g.TrichYeuND.Substring(0, 200) + "..." : x.g.TrichYeuND,
                    x.g.TrangThai,
                    x.g.GuiHayNhan
                });

            GridView1.DataSource = data;
            GridView1.DataBind();
        }
    }
}
