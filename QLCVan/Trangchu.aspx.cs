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
            // Không lọc gì, chỉ lấy mới nhất
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
                    x.g.TrangThai,
                    x.g.GuiHayNhan
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

                // Xóa file đính kèm
                foreach (tblFileDinhKem item in db.tblFileDinhKems.Where(f => f.MaCV == maCv))
                {
                    db.tblFileDinhKems.DeleteOnSubmit(item);
                }

                // Xóa nội dung công văn
                tblNoiDungCV cv = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV == maCv);
                if (cv != null)
                {
                    db.tblNoiDungCVs.DeleteOnSubmit(cv);
                    db.SubmitChanges();
                    LoadData();
                }
            }
            // Không phải Admin -> bỏ qua (tránh NullReference)
        }

        protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            LoadData(); // đơn giản: chuyển trang dùng danh sách mặc định
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
            string keyword = TextBox1.Text.Trim();     // Số CV
            string tieuDe = txtTieuDe.Text.Trim();     // Tiêu đề
            string loai = ddlLoai.SelectedValue;       // 1: đến, 0: đi, 2: dự thảo, 3: nội bộ (= tất cả)
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
                    // Dự thảo
                    q = q.Where(x => x.g.TrangThai == false);
                }
                else if (loai == "3")
                {
                    // Nội bộ -> không lọc thêm (giữ đúng ý "tất cả")
                }
                else
                {
                    // 1: Công văn đến, 0: Công văn đi
                    int loaiCV = int.Parse(loai);
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
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //chỉ cho phép Admin sửa
            //string permisson = (Session["QuyenHan"] as string)?.Trim();
            //if (!string.Equals(permisson, "Admin", StringComparison.OrdinalIgnoreCase))
            //{
            //return; // Không cho phép sửa
            //}
            if (e.CommandName == "EditCV")
            {
                string maCV = e.CommandArgument.ToString();
                Response.Redirect("ChinhSuaCV.aspx?id=" + maCV);
            }
        }



    }
}
