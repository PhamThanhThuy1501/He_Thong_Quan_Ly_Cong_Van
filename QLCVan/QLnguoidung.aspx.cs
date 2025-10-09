using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLnguoidung : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilters();
                LoadUsers();
            }
        }

        private void LoadFilters()
        {
            ddlDonVi.DataSource = db.tblNhoms;
            ddlDonVi.DataTextField = "MoTa";
            ddlDonVi.DataValueField = "MaNhom";
            ddlDonVi.DataBind();
            ddlDonVi.Items.Insert(0, new ListItem("Đơn vị", ""));
        }

        private void LoadUsers()
        {
            var users = from u in db.tblNguoiDungs
                        join n in db.tblNhoms on u.MaNhom equals n.MaNhom
                        select new
                        {
                            u.MaNguoiDung,
                            u.TenDN,
                            u.Email,
                            DonVi = n.MoTa,
                            ChucVu = u.ChucVu,   // ✅ nhớ lấy thêm ChucVu
                            TrangThai = u.TrangThai
                        };

            gvUsers.DataSource = users.ToList();
            gvUsers.DataBind();
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string tenDN = txtTenDN.Text.Trim();
            string email = txtEmail.Text.Trim();
            int maNhom = string.IsNullOrEmpty(ddlDonVi.SelectedValue) ? 0 : int.Parse(ddlDonVi.SelectedValue);
            string chucVu = ddlChucVuFilter.SelectedValue;

            var users = from u in db.tblNguoiDungs
                        join n in db.tblNhoms on u.MaNhom equals n.MaNhom
                        where (tenDN == "" || u.TenDN.Contains(tenDN))
                           && (email == "" || u.Email.Contains(email))
                           && (maNhom == 0 || u.MaNhom == maNhom)
                           && (chucVu == "" || u.ChucVu == chucVu)
                        select new
                        {
                            u.MaNguoiDung,
                            u.TenDN,
                            u.Email,
                            DonVi = n.MoTa,
                            u.ChucVu,
                            u.TrangThai
                        };

            gvUsers.DataSource = users.ToList();
            gvUsers.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            tblNguoiDung nd = new tblNguoiDung
            {
                MaNguoiDung = Guid.NewGuid().ToString(),
                TenDN = txtTenDN.Text,
                Email = txtEmail.Text,
                MatKhau = txtMatKhau.Text,
                HoTen = txtHoTen.Text,
                DonVi = ddlDonVi.SelectedValue,
                ChucVu = ddlChucVu.SelectedValue,   // ✅ thêm chức vụ
                TrangThai = 0,
                MaNhom = 1
            };

            db.tblNguoiDungs.InsertOnSubmit(nd);
            db.SubmitChanges();

            LoadUsers();
        }


        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string id = gvUsers.DataKeys[e.NewEditIndex].Value.ToString();
            Response.Redirect("UserEdit.aspx?id=" + id);
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvUsers.DataKeys[e.RowIndex].Value.ToString();
            var user = db.tblNguoiDungs.SingleOrDefault(u => u.MaNguoiDung == id);
            if (user != null)
            {
                db.tblNguoiDungs.DeleteOnSubmit(user);
                db.SubmitChanges();
                LoadUsers();
            }
        }
    }
}
