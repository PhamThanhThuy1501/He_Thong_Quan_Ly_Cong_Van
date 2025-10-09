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

        // Lấy danh sách đơn vị từ Session (dữ liệu fix cứng)
        private List<DonVi> GetDanhSachDonVi()
        {
            if (Session["DanhSachDonVi"] == null)
            {
                Session["DanhSachDonVi"] = new List<DonVi>
                {
                    new DonVi { MaDonVi = "BCHT", TenDonVi = "Binh chủng hợp thành", MoTa = "Bộ chỉ huy tổng hợp" },
                    new DonVi { MaDonVi = "QSDP", TenDonVi = "Quân sự địa phương", MoTa = "Cơ sở đào tạo" },
                    new DonVi { MaDonVi = "KHXH_NV", TenDonVi = "Khoa học xã hội nhân văn", MoTa = "Khoa lý luận nghiệp vụ" },
                    new DonVi { MaDonVi = "BTN", TenDonVi = "Ban tuyển huấn", MoTa = "Tuyển sinh và huấn luyện" }
                };
            }
            return (List<DonVi>)Session["DanhSachDonVi"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_DonVi();
            }
        }

        private void load_DonVi()
        {
            gvQLNhom.DataSource = GetDanhSachDonVi();
            gvQLNhom.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string ten = txtTenDonVi.Text.Trim();
            string mota = txtMoTaDonVi.Text.Trim();

            if (string.IsNullOrEmpty(ten) || string.IsNullOrEmpty(mota))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Vui lòng nhập đầy đủ thông tin đơn vị!');", true);
                return;
            }

            var danhSach = GetDanhSachDonVi();
            if (danhSach.Any(p => p.TenDonVi.Equals(ten, StringComparison.OrdinalIgnoreCase)))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Tên đơn vị đã tồn tại!');", true);
                return;
            }

            string ma = "DV" + (danhSach.Count + 1);
            danhSach.Add(new DonVi { MaDonVi = ma, TenDonVi = ten, MoTa = mota });

            txtTenDonVi.Text = "";
            txtMoTaDonVi.Text = "";
            load_DonVi();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#addModal').modal('hide');", true);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keywordMa = txtSearchMa.Text.Trim().ToLower();
            string keywordTen = txtSearchTen.Text.Trim().ToLower();

            var danhSach = GetDanhSachDonVi();

            var ketQua = danhSach.Where(dv =>
                (string.IsNullOrEmpty(keywordMa) || dv.MaDonVi.ToLower().Contains(keywordMa)) &&
                (string.IsNullOrEmpty(keywordTen) || dv.TenDonVi.ToLower().Contains(keywordTen))
            ).ToList();

            gvQLNhom.DataSource = ketQua;
            gvQLNhom.DataBind();
        }

        protected void gvQLNhom_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvQLNhom.PageIndex = e.NewPageIndex;
            load_DonVi();
        }

        protected void rowEditing(object sender, GridViewEditEventArgs e)
        {
            gvQLNhom.EditIndex = e.NewEditIndex;
            load_DonVi();
        }

        protected void rowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQLNhom.EditIndex = -1;
            load_DonVi();
        }

        protected void rowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            var danhSach = GetDanhSachDonVi();
            string ma = gvQLNhom.DataKeys[e.RowIndex].Value.ToString();
            TextBox txtTen = (TextBox)gvQLNhom.Rows[e.RowIndex].FindControl("txtTenNhom");
            TextBox txtMoTa = (TextBox)gvQLNhom.Rows[e.RowIndex].FindControl("txtMoTa");

            var dv = danhSach.FirstOrDefault(x => x.MaDonVi == ma);
            if (dv != null)
            {
                dv.TenDonVi = txtTen.Text.Trim();
                dv.MoTa = txtMoTa.Text.Trim();
            }

            gvQLNhom.EditIndex = -1;
            load_DonVi();
        }

        protected void rowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var danhSach = GetDanhSachDonVi();
            string ma = gvQLNhom.DataKeys[e.RowIndex].Value.ToString();
            var dv = danhSach.FirstOrDefault(x => x.MaDonVi == ma);
            if (dv != null)
            {
                danhSach.Remove(dv);
            }

            load_DonVi();
        }

        protected void rowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                hdfID.Value = Convert.ToString(e.CommandArgument);
            }
        }
    }
}
