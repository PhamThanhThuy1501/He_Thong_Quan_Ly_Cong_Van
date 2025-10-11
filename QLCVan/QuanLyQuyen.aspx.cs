using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QuanLyQuyen : System.Web.UI.Page
    {
        public class Quyen
        {
            public string MaQuyen { get; set; }
            public string TenQuyen { get; set; }
        }

        private List<Quyen> GetDanhSachQuyen()
        {
            if (Session["DanhSachQuyen"] == null)
            {
                Session["DanhSachQuyen"] = new List<Quyen>
                {
                    new Quyen { MaQuyen = "CV_01", TenQuyen = "Xem công văn" },
                    new Quyen { MaQuyen = "CV_02", TenQuyen = "Sửa công văn" },
                    new Quyen { MaQuyen = "CV_03", TenQuyen = "Thêm công văn" },
                    new Quyen { MaQuyen = "CV_04", TenQuyen = "Xóa công văn" },
                    new Quyen { MaQuyen = "CV_05", TenQuyen = "Phê duyệt công văn" },
                    new Quyen { MaQuyen = "CV_06", TenQuyen = "Từ chối công văn" },
                    new Quyen { MaQuyen = "CV_07", TenQuyen = "In công văn" },
                    new Quyen { MaQuyen = "CV_08", TenQuyen = "Xuất công văn" }
                };
            }
            return (List<Quyen>)Session["DanhSachQuyen"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadQuyen();
        }

        private void LoadQuyen()
        {
            gvQuyen.DataSource = GetDanhSachQuyen();
            gvQuyen.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keywordTen = txtTenQuyen.Text.Trim().ToLower();
            string keywordMa = txtMaQuyen.Text.Trim().ToLower();

            var ds = GetDanhSachQuyen();
            var ketQua = ds.Where(q =>
                (string.IsNullOrEmpty(keywordTen) || q.TenQuyen.ToLower().Contains(keywordTen)) &&
                (string.IsNullOrEmpty(keywordMa) || q.MaQuyen.ToLower().Contains(keywordMa))
            ).ToList();

            gvQuyen.DataSource = ketQua;
            gvQuyen.DataBind();
        }

        protected void gvQuyen_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvQuyen.PageIndex = e.NewPageIndex;
            LoadQuyen();
        }
    }
}
