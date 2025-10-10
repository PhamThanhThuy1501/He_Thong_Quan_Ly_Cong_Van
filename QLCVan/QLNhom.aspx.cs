using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLNhom : System.Web.UI.Page
    {
        // Lớp đại diện cho đơn vị
        public class DonVi
        {
            public string MaDonVi { get; set; }
            public string TenDonVi { get; set; }
            public string MoTa { get; set; }
        }

        // Lấy danh sách đơn vị từ Session (mock data)
        private List<DonVi> GetDanhSachDonVi()
        {
            if (Session["DanhSachDonVi"] == null)
            {
                Session["DanhSachDonVi"] = new List<DonVi>
                {
                    new DonVi { MaDonVi = "BCHT",   TenDonVi = "Binh chủng hợp thành",         MoTa = "Bộ chỉ huy tổng hợp" },
                    new DonVi { MaDonVi = "QSDP",   TenDonVi = "Quân sự địa phương",            MoTa = "Cơ sở đào tạo" },
                    new DonVi { MaDonVi = "KHXH_NV",TenDonVi = "Khoa học xã hội nhân văn",       MoTa = "Khoa lý luận nghiệp vụ" },
                    new DonVi { MaDonVi = "BTN",    TenDonVi = "Ban tuyển huấn",                 MoTa = "Tuyển sinh và huấn luyện" }
                };
            }
            return (List<DonVi>)Session["DanhSachDonVi"];
        }

        private void BindGrid(IEnumerable<DonVi> data = null)
        {
            gvQLNhom.DataSource = data ?? GetDanhSachDonVi();
            gvQLNhom.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        // Thêm đơn vị (modal "Thêm")
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string ten = txtTenDonVi.Text.Trim();
            string mota = txtMoTaDonVi.Text.Trim();

            if (string.IsNullOrEmpty(ten) || string.IsNullOrEmpty(mota))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Vui lòng nhập đầy đủ thông tin đơn vị!');", true);
                return;
            }

            var danhSach = GetDanhSachDonVi();
            if (danhSach.Any(p => p.TenDonVi.Equals(ten, StringComparison.OrdinalIgnoreCase)))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert2",
                    "alert('Tên đơn vị đã tồn tại!');", true);
                return;
            }

            string ma = "DV" + (danhSach.Count + 1);
            danhSach.Add(new DonVi { MaDonVi = ma, TenDonVi = ten, MoTa = mota });

            txtTenDonVi.Text = "";
            txtMoTaDonVi.Text = "";
            BindGrid();

            // Đóng modal theo Bootstrap 5
            ScriptManager.RegisterStartupScript(this, GetType(), "hideAddModal",
                "var el=document.getElementById('addModal'); if(el){var m=bootstrap.Modal.getInstance(el)||new bootstrap.Modal(el); m.hide();}", true);
        }

        // Tìm kiếm
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keywordMa = txtSearchMa.Text.Trim().ToLower();
            string keywordTen = txtSearchTen.Text.Trim().ToLower();

            var danhSach = GetDanhSachDonVi();
            var ketQua = danhSach.Where(dv =>
                 (string.IsNullOrEmpty(keywordMa) || (dv.MaDonVi ?? "").ToLower().Contains(keywordMa)) &&
                 (string.IsNullOrEmpty(keywordTen) || (dv.TenDonVi ?? "").ToLower().Contains(keywordTen))
            ).ToList();

            BindGrid(ketQua);
        }

        // Phân trang
        protected void gvQLNhom_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvQLNhom.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        /* ====== SỬA BẰNG MODAL (không edit inline) ====== */

        // Bấm nút Sửa trong GridView -> mở modal & fill dữ liệu
        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {
            // Chặn chế độ edit inline
            e.Cancel = true;

            // Lấy row & dữ liệu đang chọn
            GridViewRow row = gvQLNhom.Rows[e.NewEditIndex];
            string ma = ((Label)row.FindControl("lblMaDonVi"))?.Text?.Trim();
            string ten = ((Label)row.FindControl("lblTenDonVi"))?.Text?.Trim();

            // Đổ vào control trong modal
            hdfID.Value = ma;
            txtEditMaDonVi.Text = ma;        // readonly trong .aspx
            txtEditTenDonVi.Text = ten ?? "";

            // Mở modal (JS function đã khai báo trong .aspx)
            ScriptManager.RegisterStartupScript(this, GetType(), "showEditModal", "showEditModal();", true);
        }

        // Nút "Sửa" trong modal -> lưu & đóng
        protected void btnEditSave_Click(object sender, EventArgs e)
        {
            string ma = hdfID.Value;
            string tenMoi = txtEditTenDonVi.Text.Trim();

            if (string.IsNullOrEmpty(ma))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert3",
                    "alert('Thiếu mã đơn vị!');", true);
                return;
            }

            var danhSach = GetDanhSachDonVi();
            var dv = danhSach.FirstOrDefault(x => x.MaDonVi == ma);
            if (dv == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert4",
                    "alert('Không tìm thấy đơn vị để cập nhật!');", true);
                return;
            }

            // Kiểm tra trùng tên (ngoại trừ chính nó)
            if (danhSach.Any(x => !x.MaDonVi.Equals(ma, StringComparison.OrdinalIgnoreCase)
                                  && x.TenDonVi.Equals(tenMoi, StringComparison.OrdinalIgnoreCase)))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert5",
                    "alert('Tên đơn vị đã tồn tại!');", true);
                return;
            }

            dv.TenDonVi = tenMoi;
            BindGrid();

            // Đóng modal
            ScriptManager.RegisterStartupScript(this, GetType(), "hideEditModal", "hideEditModal();", true);
        }

        /* ====== CÁC HÀM DƯ THỪA DO EDIT INLINE (để trống/không dùng) ====== */
        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQLNhom.EditIndex = -1;
            BindGrid();
        }

        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Không dùng nữa vì đã chuyển sang modal edit.
            e.Cancel = true;
            gvQLNhom.EditIndex = -1;
            BindGrid();
        }

        // Xóa
        protected void rowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var danhSach = GetDanhSachDonVi();
            string ma = gvQLNhom.DataKeys[e.RowIndex].Value.ToString();

            var dv = danhSach.FirstOrDefault(x => x.MaDonVi == ma);
            if (dv != null)
                danhSach.Remove(dv);

            BindGrid();
        }

        protected void rowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Không bắt buộc; giữ lại nếu bạn có CommandName khác cần xử lý
            if (e.CommandName.Equals("Edit"))
            {
                hdfID.Value = Convert.ToString(e.CommandArgument);
            }
        }
    }
}
