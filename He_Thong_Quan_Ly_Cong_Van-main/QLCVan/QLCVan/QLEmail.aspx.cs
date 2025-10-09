using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Net.Mail;


namespace QLCVan
{
    public partial class QLEmail : System.Web.UI.Page
    {

        public static string SelectedEmails = "";
        InfoDataContext db = new InfoDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var ddls = from d in db.tblPhongBans
                           where d.MaPhongBan.ToString() != null
                           select new { d.MaPhongBan, d.TenPhongBan };

                DropDownList1.DataSource = ddls;
                DropDownList1.DataTextField = "TenPhongBan";
                DropDownList1.DataValueField = "MaPhongBan";
                DropDownList1.DataBind();
                var list = db.DanhBaEmails;
                ltbdanhsachnhom.DataSource = list;
                ltbdanhsachnhom.DataBind();




            }

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var lay = from d in db.tblPhongBans
                      from a in db.DanhBaEmails
                      where d.MaPhongBan == int.Parse(DropDownList1.SelectedValue.ToString()) && a.MaPhongBan == d.MaPhongBan
                      select new { a.Email, a.UserName };

            ltbdanhsachnhom.DataSource = lay;
            ltbdanhsachnhom.DataBind();
        }

        protected void grvEmail_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void grvEmail_SelectedIndexChanged(object sender, EventArgs e)
        {


        }





        protected void btnchuyenleft_Click(object sender, EventArgs e)
        {
            int[] CacMucChon = ltbdanhsachnhom.GetSelectedIndices();
            for (int i = 0; i < CacMucChon.Count(); i++)
            {
                ListItem item = ltbdanhsachnhom.Items[CacMucChon[i]];

                if (checkexists(item.Value))
                {
                    ltbdanhsachnguoinhan.Items.Add(item);
                }
                else
                {
                    Response.Write("<script type='text/javascript'>alert('Email đã tồn tại!')</script>");
                }
            }
            for (int k = CacMucChon.Count() - 1; k >= 0; k--)
            {
                ltbdanhsachnhom.Items.RemoveAt(CacMucChon[k]);
            }
        }
        bool checkexists(string Email)
        {
            foreach (ListItem item in ltbdanhsachnguoinhan.Items)
            {

                if (item.Value.ToString() == Email)
                    return false;
            }

            return true;
        }

        protected void btnQuay_Click(object sender, EventArgs e)
        {

            int[] CacMucChon = ltbdanhsachnguoinhan.GetSelectedIndices();
            for (int i = 0; i < CacMucChon.Count(); i++)
            {
                ltbdanhsachnhom.Items.Add(ltbdanhsachnguoinhan.Items[CacMucChon[i]].Value);

            }
            for (int i = CacMucChon.Count() - 1; i >= 0; i--)
            {
                ltbdanhsachnguoinhan.Items.RemoveAt(CacMucChon[i]);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string tieude = Session["macv"].ToString().Split('|')[0];
            string noidung = Session["macv"].ToString().Split('|')[1];
            // int[] CacMucChon = ltbdanhsachnguoinhan.GetSelectedIndices();

            string nguoinhan = null;
            SmtpClient client = new SmtpClient();

            client = new SmtpClient("smtp.gmail.com", 587);
            client.Credentials = new System.Net.NetworkCredential("dangyen92@gmail.com", "maixuanquy1808");
            client.EnableSsl = true;
            for (int i = 0; i < ltbdanhsachnguoinhan.Items.Count; i++)
            {
                nguoinhan = ltbdanhsachnguoinhan.Items[i].ToString();

                MailMessage mail = new MailMessage("dangyen92@gmail.com", nguoinhan, tieude, noidung);
                client.Send(mail);
            }

            string address = nguoinhan;
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
        void RemoveFile(int index)
        {
            if (index >= ltbdanhsachnguoinhan.Items.Count) return;
            string filename = ltbdanhsachnguoinhan.Items[index].Value;
            System.IO.File.Delete(filename);
            ltbdanhsachnguoinhan.Items.RemoveAt(index);
        }
        protected void btXoa_Click(object sender, EventArgs e)
        {
            RemoveFile(ltbdanhsachnguoinhan.SelectedIndex);
        }

        





    }

}





