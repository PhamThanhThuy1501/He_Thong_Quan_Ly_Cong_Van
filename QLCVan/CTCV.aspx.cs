using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace QLCVan
{
    public partial class CTCV : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();
        private List<string> lstAtt = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null)
            {
                Response.Redirect("Dangnhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // nếu bạn dùng DropDownList ddlEmails, load ở đây (nếu có)
                // var emails = db.DanhBaEmails.Select(d => d.Email).Distinct().OrderBy(x => x).ToList();
                // ddlEmails.DataSource = emails; ddlEmails.DataBind();
            }

            string maCongVan = Request.QueryString["id"];
            if (String.IsNullOrEmpty(maCongVan)) return;

            tblNoiDungCV tk = db.tblNoiDungCVs.SingleOrDefault(n => n.MaCV == maCongVan);
            if (tk != null)
            {
                txtTieuDe.Text = tk.TieuDeCV;
                txtSoCV.Text = tk.SoCV;
                txtTenloaiCV.Text = (from lcv in db.tblLoaiCVs
                                     from ndCV in db.tblNoiDungCVs
                                     where ndCV.MaCV == maCongVan && lcv.MaLoaiCV == ndCV.MaLoaiCV
                                     select lcv.TenLoaiCV).SingleOrDefault();
                txtCQBH.Text = tk.CoQuanBanHanh;
                // txtNguoiki.Text = tk.NguoiKy; // nếu có
                txtNgayBH.Text = tk.NgayBanHanh.HasValue ? tk.NgayBanHanh.Value.ToString("dd-MM-yyyy") : "";
                txtNgaynhan.Text = tk.NgayGui.HasValue ? tk.NgayGui.Value.ToString("dd-MM-yyyy") : "";
                // <--- FIX: dùng .Text thay vì .InnerText
                txtaTrichyeu.Text = tk.TrichYeuND ?? "";
                rptfilecv.DataSource = db.tblFileDinhKems.Where(t => t.MaCV == tk.MaCV);
                rptfilecv.DataBind();
            }

            // lay và xu ly file
            lstAtt.Clear();
            var v = db.tblFileDinhKems.Where(f => f.MaCV.Equals(maCongVan)).Select(n => n.TenFile).ToList();
            if (v != null && v.Count > 0)
            {
                foreach (var file in v)
                {
                    lstAtt.Add(file);
                }
            }

            // FIX: .Text thay vì .InnerText
            Session["macv"] = txtTieuDe.Text + "|" + txtaTrichyeu.Text + "|";
        }

        protected void btnGui_Click(object sender, EventArgs e)
        {
            string toAddress = txtNguoiNhan.Text.Trim();

            if (string.IsNullOrEmpty(toAddress))
            {
                lblThongBao.Text = "<span style='color:red'>Vui lòng nhập địa chỉ email.</span>";
                return;
            }

            try
            {
                using (SmtpClient client = new SmtpClient("smtp.gmail.com", 587))
                {
                    client.Credentials = new System.Net.NetworkCredential("dangyen92@gmail.com", "huyhoang1234");
                    client.EnableSsl = true;

                    // FIX: dùng .Text cho body
                    MailMessage mail = new MailMessage("dangyen92@gmail.com", toAddress, txtTieuDe.Text, txtaTrichyeu.Text);

                    if (lstAtt != null && lstAtt.Count > 0)
                    {
                        foreach (string file in lstAtt)
                        {
                            try
                            {
                                // Nếu file chỉ là tên, build path: Server.MapPath("~/Uploads/" + file)
                                mail.Attachments.Add(new Attachment(file));
                            }
                            catch
                            {
                                // bỏ qua file không tìm thấy để vẫn gửi được mail
                            }
                        }
                    }

                    client.Send(mail);
                }

                // update danh bạ
                DanhBaEmail email = db.DanhBaEmails.SingleOrDefault(a => a.Email == toAddress);
                if (email == null)
                {
                    email = new DanhBaEmail
                    {
                        Email = toAddress,
                        SoLanGui = 1,
                        MaPhongBan = 5
                    };
                    db.DanhBaEmails.InsertOnSubmit(email);
                }
                else
                {
                    email.SoLanGui = (email.SoLanGui ?? 0) + 1;
                }

                db.SubmitChanges();
                lblThongBao.Text = "<span style='color:green'>Gửi mail thành công.</span>";
            }
            catch (Exception ex)
            {
                lblThongBao.Text = "<span style='color:red'>Lỗi khi gửi mail: " + Server.HtmlEncode(ex.Message) + "</span>";
            }
        }

        protected void btnPheduyet_Click(object sender, EventArgs e)
        {
            string maCongVan = Request.QueryString["id"];
            if (string.IsNullOrEmpty(maCongVan)) return;

            tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV == maCongVan);
            if (cv1 != null)
            {
                cv1.TrangThai = true;
                db.SubmitChanges();
            }
        }
    }
}
