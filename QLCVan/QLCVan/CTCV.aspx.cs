using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Net.Mail;


namespace QLCVan
{
    public partial class CTCV : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();
        private string file;
        private List<string> lstAtt = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!(Session["TenDN"] != null))
            {
                Response.Redirect("Dangnhap.aspx");
            }
            ////tải nd cv
            string maCongVan = Request.QueryString["id"];

            tblNoiDungCV tk = db.tblNoiDungCVs.SingleOrDefault(n => n.MaCV == Request.QueryString["id"].ToString());
            if (tk != null)
            {
                txtTieuDe.Text = tk.TieuDeCV;
                txtSoCV.Text = tk.SoCV;
                txtTenloaiCV.Text = (from lcv in db.tblLoaiCVs
                                     from ndCV in db.tblNoiDungCVs
                                     where ndCV.MaCV == maCongVan && lcv.MaLoaiCV == ndCV.MaLoaiCV
                                     select lcv.TenLoaiCV).SingleOrDefault();
                txtCQBH.Text = tk.CoQuanBanHanh;
                txtNguoiki.Text = tk.NguoiKy;
                //câu lệnh này có thấy lỗi cho nào không?

                txtNgayBH.Text = tk.NgayBanHanh.Value.ToString("dd-MM-yyyy");
                txtNgaynhan.Text = tk.NgayGui.Value.ToString("dd-MM-yyyy");
                txtaButphe.InnerText = tk.ButPheLanhDao;
                txtaTrichyeu.InnerText = tk.TrichYeuND;

                rptfilecv.DataSource = db.tblFileDinhKems.Where(t => t.MaCV == tk.MaCV);
                rptfilecv.DataBind();
            }

            //lay và xu ly file

            var v = db.tblFileDinhKems.Where(f => f.MaCV.Equals(maCongVan)).Select(n => new { n.TenFile });
            if (v != null)
            {

                foreach (var file in v)
                {
                    lstAtt.Add(file.TenFile);
                }

            }

            Session["macv"] = txtTieuDe.Text + "|" + txtaTrichyeu.InnerText + "|";
        }

        protected void btnGui_Click(object sender, EventArgs e)
        {


            SmtpClient client = new SmtpClient();
            client = new SmtpClient("smtp.gmail.com", 587);
            client.Credentials = new System.Net.NetworkCredential("dangyen92@gmail.com", "maixuanquy1808");
            client.EnableSsl = true;

            MailMessage mail = new MailMessage("dangyen92@gmail.com", txtNguoiNhan.Text.Trim(), txtTieuDe.Text, txtaTrichyeu.InnerText);
            if (lstAtt != null)
            {
                foreach (string file in lstAtt)
                {
                    mail.Attachments.Add(new Attachment(file));
                }
            }
            client.Send(mail);
            string address = txtNguoiNhan.Text;
            DanhBaEmail email = db.DanhBaEmails.SingleOrDefault(a => a.Email == address);
            if (email == null)
            {
                email = new DanhBaEmail();
                email.Email = address;
                email.SoLanGui = 1;
                email.MaPhongBan = 5;
                db.DanhBaEmails.InsertOnSubmit(email);
            }
            else
            {
                email.SoLanGui++;

            }
            db.SubmitChanges();
        }
    }

}