using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class PhanQuyen : System.Web.UI.Page
    {
        private const string VS_KEY = "QuyenTable";
        private const int PAGE_SIZE = 5;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string maNhom = Request.QueryString["MaNhom"];
                if (!string.IsNullOrEmpty(maNhom))
                    hdfMaNhom.Value = maNhom;

                EnsureData();
                LoadData(1);
            }
        }

        private void EnsureData()
        {
            if (ViewState[VS_KEY] != null) return;

            DataTable dt = new DataTable();
            dt.Columns.Add("MaQuyen");
            dt.Columns.Add("TenQuyen");
            dt.Columns.Add("DaGan", typeof(bool));

            dt.Rows.Add("CV_01", "Xem danh sách người dùng", false);
            dt.Rows.Add("TK_01", "Sửa danh sách người dùng", false);
            dt.Rows.Add("CV_02", "Xem danh sách công văn", true);
            dt.Rows.Add("QL_01", "Quản lý loại công văn", false);
            dt.Rows.Add("QL_02", "Thêm công văn mới", false);
            dt.Rows.Add("QL_03", "Xóa công văn", false);
            dt.Rows.Add("QL_04", "Phê duyệt công văn", true);
            dt.Rows.Add("QL_05", "Báo cáo thống kê", false);
            dt.Rows.Add("QL_06", "Xem báo cáo chi tiết", false);
            dt.Rows.Add("QL_07", "In báo cáo tổng hợp", false);

            ViewState[VS_KEY] = dt;
        }

        private DataTable GetDT() => ViewState[VS_KEY] as DataTable;

        private string BuildFilter()
        {
            string f = "";
            string ten = (txtTenNhom.Text ?? "").Trim().Replace("'", "''");
            string ma = (txtMaNhom.Text ?? "").Trim().Replace("'", "''");

            if (!string.IsNullOrEmpty(ten))
                f += $"TenQuyen LIKE '%{ten}%'";
            if (!string.IsNullOrEmpty(ma))
            {
                if (!string.IsNullOrEmpty(f)) f += " AND ";
                f += $"MaQuyen LIKE '%{ma}%'";
            }
            return f;
        }

        private void LoadData(int pageIndex)
        {
            DataTable dt = GetDT();
            if (dt == null) return;

            // Áp dụng filter nếu có
            DataView dv = string.IsNullOrEmpty(BuildFilter())
                ? new DataView(dt)
                : new DataView(dt, BuildFilter(), "", DataViewRowState.CurrentRows);

            DataTable filtered = dv.ToTable();
            int totalRecords = filtered.Rows.Count;
            int totalPages = (int)Math.Ceiling((double)totalRecords / PAGE_SIZE);

            // Lấy dữ liệu cho trang hiện tại
            DataTable pageData = filtered.AsEnumerable()
                .Skip((pageIndex - 1) * PAGE_SIZE)
                .Take(PAGE_SIZE)
                .CopyToDataTable();

            gvPhanQuyen.DataSource = pageData;
            gvPhanQuyen.DataBind();

            // Build phân trang ngoài bảng
            BuildPager(totalPages, pageIndex);
        }

        private void BuildPager(int totalPages, int currentPage)
        {
            DataTable pager = new DataTable();
            pager.Columns.Add("PageIndex", typeof(int));
            pager.Columns.Add("PageNumber", typeof(int));
            pager.Columns.Add("IsCurrentPage", typeof(bool));

            for (int i = 1; i <= totalPages; i++)
            {
                DataRow r = pager.NewRow();
                r["PageIndex"] = i;
                r["PageNumber"] = i;
                r["IsCurrentPage"] = (i == currentPage);
                pager.Rows.Add(r);
            }

            rptPager.DataSource = pager;
            rptPager.DataBind();
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                int pageIndex = Convert.ToInt32(e.CommandArgument);
                LoadData(pageIndex);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData(1);
        }

        protected void gvPhanQuyen_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "GanQuyen")
            {
                string maQuyen = e.CommandArgument.ToString();
                DataTable dt = GetDT();
                if (dt != null)
                {
                    foreach (DataRow r in dt.Rows)
                    {
                        if (r["MaQuyen"].ToString() == maQuyen)
                        {
                            r["DaGan"] = !Convert.ToBoolean(r["DaGan"]);
                            break;
                        }
                    }
                    ViewState[VS_KEY] = dt;
                }
                LoadData(1);
            }
        }
    }
}
