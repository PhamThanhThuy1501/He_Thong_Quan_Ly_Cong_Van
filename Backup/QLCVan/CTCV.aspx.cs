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
        private List<string> lstAtt = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!(Session["TenDN"] != null))
            {
                Response.Redirect("Dangnhap.aspx");
            }
            if (!(Session["TenDN"].ToString().Equals("quynm")))
            {
                btnPheduyet.Visible = false;
                Label10.Visible = false;
            }
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
                txtNgayBH.Text = tk.NgayBanHanh.Value.ToString("dd-MM-yyyy");
                txtNgaynhan.Text = tk.NgayGui.Value.ToString("dd-MM-yyyy");
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
            //if (IsPostBack != true)
            //{
            //    CkGroup.DataSource = db.tblNhoms;
            //    CkGroup.DataTextField = "mota";
            //    CkGroup.DataValueField = "manhom";
            //    CkGroup.DataBind();
            //}
        }

        protected void btnGui_Click(object sender, EventArgs e)
        {
            SmtpClient client = new SmtpClient();
            client = new SmtpClient("smtp.gmail.com", 587);
            client.Credentials = new System.Net.NetworkCredential("dangyen92@gmail.com", "huyhoang1234");
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
        //public string Checklist(CheckBoxList ckl)
        //{
        //    List<string> selectvalue = ckl.Items.Cast<ListItem>().Where(li => li.Selected).Select(li => li.Value).ToList();
        //    string s = ""; string s2 = "";
        //    foreach (string item in selectvalue)
        //    {
        //        var a = db.tblNguoiDungs.FirstOrDefault(i=>i.MaNhom.ToString()==item);
        //        s += a.TenDN;
        //        s2 += a.MaNhom + ",";
        //    }
        //    return s2;
        //}
        protected void btnPheduyet_Click(object sender, EventArgs e)
        {

            string maCongVan = Request.QueryString["id"];
            tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV.ToString() == (Request.QueryString["id"].ToString()));
            cv1.TrangThai = true;
            db.SubmitChanges();



        }


    }
}
