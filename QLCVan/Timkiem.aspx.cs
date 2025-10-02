using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq.SqlClient;

namespace QLCVan
{
    public partial class Timkiem : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDropdowns();
                LoadData();

                // Ẩn nút Xóa cho User
                if (Session["QuyenHan"] != null && Session["QuyenHan"].ToString() == "User")
                {
                    if (gvTimkiem != null && gvTimkiem.Columns.Count > 4)
                    {
                        gvTimkiem.Columns[4].Visible = false;
                    }
                }
            }
        }

        private void LoadDropdowns()
        {
            // Loại Công Văn
            var loaiCVs = db.tblLoaiCVs.ToList();
            ddlLoaiCV.DataSource = loaiCVs;
            ddlLoaiCV.DataTextField = "TenLoaiCV";
            ddlLoaiCV.DataValueField = "MaLoaiCV";
            ddlLoaiCV.DataBind();
            ddlLoaiCV.Items.Insert(0, new ListItem("-- Tất cả --", "0"));

            // Cơ quan ban hành (Distinct)
            var cqBanHanh = db.tblNoiDungCVs
                              .Where(x => x.CoQuanBanHanh != null && x.CoQuanBanHanh != "")
                              .Select(x => x.CoQuanBanHanh)
                              .Distinct()
                              .ToList();
            ddlCoQuan.DataSource = cqBanHanh;
            ddlCoQuan.DataBind();
            ddlCoQuan.Items.Insert(0, new ListItem("-- Tất cả --", ""));

            // Năm ban hành (Distinct từ NgayBanHanh)
            var namBanHanh = db.tblNoiDungCVs
                               .Where(x => x.NgayBanHanh.HasValue)
                               .Select(x => x.NgayBanHanh.Value.Year)
                               .Distinct()
                               .OrderByDescending(y => y)
                               .ToList();
            ddlNam.DataSource = namBanHanh;
            ddlNam.DataBind();
            ddlNam.Items.Insert(0, new ListItem("-- Tất cả --", "0"));
        }

        private void LoadData()
        {
            var lay = from d in db.tblNoiDungCVs
                      select new
                      {
                          d.SoCV,
                          d.MaCV,
                          d.TieuDeCV,
                          TrichYeuND = d.TrichYeuND.Length > 100 ? d.TrichYeuND.Substring(0, 100) + " ..." : d.TrichYeuND
                      };

            gvTimkiem.DataSource = lay;
            gvTimkiem.DataBind();
        }

        protected void btnTim_Click(object sender, EventArgs e)
        {
            string strSearch = txtNoiDung.Text.Trim();
            int loai = int.Parse(ddlLoaiCV.SelectedValue);

            var q = from d in db.tblNoiDungCVs
                    where SqlMethods.Like(d.TieuDeCV, "%" + strSearch + "%")
                       || SqlMethods.Like(d.TrichYeuND, "%" + strSearch + "%")
                       || SqlMethods.Like(d.SoCV, "%" + strSearch + "%")
                    select d;

            // lọc theo loại CV
            if (loai > 0)
            {
                q = q.Where(d => d.MaLoaiCV == loai);
            }

            // lọc theo cơ quan ban hành
            if (!string.IsNullOrEmpty(ddlCoQuan.SelectedValue))
            {
                q = q.Where(d => d.CoQuanBanHanh == ddlCoQuan.SelectedValue);
            }

            // lọc theo năm ban hành
            if (ddlNam.SelectedValue != "0")
            {
                int nam = int.Parse(ddlNam.SelectedValue);
                q = q.Where(d => d.NgayBanHanh.HasValue && d.NgayBanHanh.Value.Year == nam);
            }

            gvTimkiem.DataSource = q.Select(d => new
            {
                d.SoCV,
                d.MaCV,
                d.TieuDeCV,
                TrichYeuND = d.TrichYeuND.Length > 100 ? d.TrichYeuND.Substring(0, 100) + " ..." : d.TrichYeuND
            });
            gvTimkiem.DataBind();
        }

        protected void gvTimkiem_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTimkiem.PageIndex = e.NewPageIndex;
            LoadData();
        }

        protected void lnk_Xoa_Click(object sender, EventArgs e)
        {
            if (Session["QuyenHan"].ToString().Trim() == "Admin")
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
            else
            {
                Response.Write("<script>alert('Bạn không có quyền xóa!');</script>");
            }
        }
    }
}
