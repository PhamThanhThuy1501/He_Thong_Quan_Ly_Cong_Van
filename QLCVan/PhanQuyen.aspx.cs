using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class PhanQuyen : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlNguoiDung.DataSource = db.tblNguoiDungs.ToList();
                ddlNguoiDung.DataTextField = "TenDangNhap";
                ddlNguoiDung.DataValueField = "MaNguoiDung";
                ddlNguoiDung.DataBind();

                if (ddlNguoiDung.Items.Count > 0)
                {
                    LoadQuyenTheoNguoiDung(int.Parse(ddlNguoiDung.SelectedValue));
                }
            }
        }

        protected void ddlNguoiDung_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadQuyenTheoNguoiDung(int.Parse(ddlNguoiDung.SelectedValue));
        }

        private void LoadQuyenTheoNguoiDung(int maNguoiDung)
        {
            var query = from q in db.tblQuyens
                        join pq in db.tblPhanQuyens.Where(x => x.MaNguoiDung == maNguoiDung)
                        on q.MaQuyen equals pq.MaQuyen into gj
                        from subpq in gj.DefaultIfEmpty()
                        select new
                        {
                            q.MaQuyen,
                            q.TenQuyen,
                            DuocCap = subpq != null
                        };

            gvQuyen.DataSource = query.ToList();
            gvQuyen.DataBind();
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            int maNguoiDung = int.Parse(ddlNguoiDung.SelectedValue);

            // Xoá quyền cũ
            var old = db.tblPhanQuyens.Where(p => p.MaNguoiDung == maNguoiDung);
            db.tblPhanQuyens.DeleteAllOnSubmit(old);

            // Lấy quyền mới từ GridView
            foreach (GridViewRow row in gvQuyen.Rows)
            {
                int maQuyen = int.Parse(gvQuyen.DataKeys[row.RowIndex].Value.ToString());
                CheckBox chk = (CheckBox)row.FindControl("chkQuyen");

                if (chk != null && chk.Checked)
                {
                    tblPhanQuyen pq = new tblPhanQuyen();
                    pq.MaNguoiDung = maNguoiDung;
                    pq.MaQuyen = maQuyen;
                    db.tblPhanQuyens.InsertOnSubmit(pq);
                }
            }

            db.SubmitChanges();
        }
    }
}
