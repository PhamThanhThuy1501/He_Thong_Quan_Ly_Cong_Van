using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLCVan
{
    public partial class QLNhom : Page
    {
        // ===== Model mock =====
        public class DonVi
        {
            public string MaDonVi { get; set; }
            public string TenDonVi { get; set; }
            public string MoTa { get; set; }
        }

        private const string SessionKey = "DanhSachDonVi";

        // Lấy danh sách đơn vị từ Session (mock data)
        private List<DonVi> GetDanhSachDonVi()
        {
            if (Session[SessionKey] == null)
            {
                Session[SessionKey] = new List<DonVi>
                {
                    new DonVi { MaDonVi = "BCHT",    TenDonVi = "Binh chủng hợp thành",      MoTa = "Bộ chỉ huy tổng hợp" },
                    new DonVi { MaDonVi = "QSDP",    TenDonVi = "Quân sự địa phương",         MoTa = "Cơ sở đào tạo" },
                    new DonVi { MaDonVi = "KHXH_NV", TenDonVi = "Khoa học xã hội nhân văn",   MoTa = "Khoa lý luận nghiệp vụ" },
                    new DonVi { MaDonVi = "BTN",     TenDonVi = "Ban tuyển huấn",              MoTa = "Tuyển sinh và huấn luyện" }
                };
            }
            return (List<DonVi>)Session[SessionKey];
        }

        private void BindGrid(IEnumerable<DonVi> data = null)
        {
            gvQLNhom.DataSource = data ?? GetDanhSachDonVi();
            gvQLNhom.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        // ===== Thêm đơn vị (modal "Thêm") =====
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string ten = txtTenDonVi.Text.Trim();
            string mota = txtMoTaDonVi.Text.Trim();

            if (string.IsNullOrEmpty(ten) || string.IsNullOrEmpty(mota))
            {
                Alert("Vui lòng nhập đầy đủ thông tin đơn vị!");
                return;
            }

            var danhSach = GetDanhSachDonVi();
            if (danhSach.Any(p => p.TenDonVi.Equals(ten, StringComparison.OrdinalIgnoreCase)))
            {
                Alert("Tên đơn vị đã tồn tại!");
                return;
            }

            // Sinh mã đơn vị đơn giản, đảm bảo không trùng
            string ma;
            int i = danhSach.Count + 1;
            do { ma = "DV" + i++; } while (danhSach.Any(x => x.MaDonVi.Equals(ma, StringComparison.OrdinalIgnoreCase)));

            danhSach.Add(new DonVi { MaDonVi = ma, TenDonVi = ten, MoTa = mota });

            txtTenDonVi.Text = "";
            txtMoTaDonVi.Text = "";
            BindGrid();

            // Đóng modal theo Bootstrap 5
            ScriptManager.RegisterStartupScript(this, GetType(), "hideAddModal",
                "var el=document.getElementById('addModal');if(el){var m=bootstrap.Modal.getInstance(el)||new bootstrap.Modal(el);m.hide();}", true);
        }

        // ===== Tìm kiếm =====
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keywordMa = txtSearchMa.Text.Trim().ToLower();
            string keywordTen = txtSearchTen.Text.Trim().ToLower();

            var danhSach = GetDanhSachDonVi();
            var ketQua = danhSach.Where(dv =>
                (string.IsNullOrEmpty(keywordMa) || (dv.MaDonVi ?? "").ToLower().Contains(keywordMa)) &&
                (string.IsNullOrEmpty(keywordTen) || (dv.TenDonVi ?? "").ToLower().Contains(keywordTen))
            );

            BindGrid(ketQua.ToList());
        }

        // ===== Phân trang =====
        protected void gvQLNhom_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvQLNhom.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        // ===== XÓA qua modal xác nhận =====
        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            var ma = hdfDeleteKey.Value;
            if (!string.IsNullOrWhiteSpace(ma))
            {
                if (DeleteDonVi(ma)) BindGrid();
                else Alert("Không tìm thấy đơn vị để xóa!");
            }
            else
            {
                Alert("Thiếu mã đơn vị cần xóa!");
            }
        }

        private bool DeleteDonVi(string ma)
        {
            var danhSach = GetDanhSachDonVi();
            var dv = danhSach.FirstOrDefault(x => x.MaDonVi.Equals(ma, StringComparison.OrdinalIgnoreCase));
            if (dv == null) return false;
            danhSach.Remove(dv);
            return true;
        }

        /* ====== SỬA BẰNG MODAL (không edit inline) ====== */

        // Bấm nút Sửa trong GridView -> mở modal & fill dữ liệu
        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {
            e.Cancel = true; // không dùng edit inline

            GridViewRow row = gvQLNhom.Rows[e.NewEditIndex];
            string ma = ((Label)row.FindControl("lblMaDonVi"))?.Text?.Trim();
            string ten = ((Label)row.FindControl("lblTenDonVi"))?.Text?.Trim();

            hdfID.Value = ma;
            txtEditMaDonVi.Text = ma;      // readonly trong .aspx
            txtEditTenDonVi.Text = ten ?? "";

            ScriptManager.RegisterStartupScript(this, GetType(), "showEditModal", "showEditModal();", true);
        }

        // Nút "Sửa" trong modal -> lưu
        protected void btnEditSave_Click(object sender, EventArgs e)
        {
            string ma = hdfID.Value;
            string tenMoi = txtEditTenDonVi.Text.Trim();

            if (string.IsNullOrEmpty(ma))
            {
                Alert("Thiếu mã đơn vị!");
                return;
            }

            var danhSach = GetDanhSachDonVi();
            var dv = danhSach.FirstOrDefault(x => x.MaDonVi == ma);
            if (dv == null)
            {
                Alert("Không tìm thấy đơn vị để cập nhật!");
                return;
            }

            if (danhSach.Any(x => !x.MaDonVi.Equals(ma, StringComparison.OrdinalIgnoreCase)
                                  && x.TenDonVi.Equals(tenMoi, StringComparison.OrdinalIgnoreCase)))
            {
                Alert("Tên đơn vị đã tồn tại!");
                return;
            }

            dv.TenDonVi = tenMoi;
            BindGrid();

            ScriptManager.RegisterStartupScript(this, GetType(), "hideEditModal", "hideEditModal();", true);
        }

        /* ====== Các handler cũ của edit inline (giữ cho an toàn) ====== */
        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQLNhom.EditIndex = -1;
            BindGrid();
        }

        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.Cancel = true; // không dùng
            gvQLNhom.EditIndex = -1;
            BindGrid();
        }

        // Nếu còn bắt sự kiện Delete của GridView (trường hợp không dùng modal)
        protected void rowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string ma = gvQLNhom.DataKeys[e.RowIndex].Value.ToString();
            if (DeleteDonVi(ma)) BindGrid();
        }

        protected void rowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                hdfID.Value = Convert.ToString(e.CommandArgument);
            }
        }

        // ===== Gán JS mở modal xoá cho từng dòng =====
        protected void gvQLNhom_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var data = e.Row.DataItem as DonVi;
                var btn = e.Row.FindControl("btnDelete") as LinkButton;
                if (btn != null && data != null)
                {
                    // Escape nháy đơn nếu có trong mã
                    string ma = (data.MaDonVi ?? string.Empty).Replace("'", "\\'");
                    btn.Attributes["onclick"] = "return openDeleteModal('" + ma + "');";
                }
            }
        }

        // ===== Helper =====
        private void Alert(string msg)
        {
            // Trả về chuỗi đã escape và có kèm dấu ngoặc kép
            string encoded = System.Web.HttpUtility.JavaScriptStringEncode(msg, true);
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                Guid.NewGuid().ToString(),
                "alert(" + encoded + ");",
                true
            );
        }
    }
}
