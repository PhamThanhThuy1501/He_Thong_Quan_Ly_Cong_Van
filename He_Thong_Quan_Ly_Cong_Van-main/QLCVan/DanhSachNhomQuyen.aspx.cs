using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class DanhSachNhomQuyen : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            var ds = db.tblNhomQuyens.Select(x => new
            {
                x.MaNhomQuyen,
                x.TenNhomQuyen
            }).ToList();

            gvNhomQuyen.DataSource = ds;
            gvNhomQuyen.DataBind();
        }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            string ma = txtMaNhom.Text.Trim();
            string ten = txtTenNhom.Text.Trim();

            var ds = db.tblNhomQuyens.AsQueryable();

            if (!string.IsNullOrEmpty(ma))
                ds = ds.Where(x => x.MaNhomQuyen.Contains(ma));

            if (!string.IsNullOrEmpty(ten))
                ds = ds.Where(x => x.TenNhomQuyen.Contains(ten));

            gvNhomQuyen.DataSource = ds.ToList();
            gvNhomQuyen.DataBind();
        }

        protected void gvNhomQuyen_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string maNhom = e.CommandArgument.ToString();

            switch (e.CommandName)
            {
                case "GanQuyen":
                    Response.Redirect($"GanQuyen.aspx?MaNhom={maNhom}");
                    break;

                case "Sua":
                    Response.Redirect($"SuaNhomQuyen.aspx?MaNhom={maNhom}");
                    break;

                case "Xoa":
                    XoaNhomQuyen(maNhom);
                    break;
            }
        }

        private void XoaNhomQuyen(string maNhom)
        {
            try
            {
                var nhom = db.tblNhomQuyens.FirstOrDefault(x => x.MaNhomQuyen == maNhom);
                if (nhom != null)
                {
                    db.tblNhomQuyens.DeleteOnSubmit(nhom);
                    db.SubmitChanges();
                    lblThongBao.Text = "🗑️ Đã xóa nhóm quyền thành công!";
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                lblThongBao.Text = "Lỗi khi xóa: " + ex.Message;
            }
        }

        protected void gvNhomQuyen_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Sự kiện xóa mặc định — đã xử lý trong RowCommand
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThemNhomQuyen.aspx");
        }
    }
}
