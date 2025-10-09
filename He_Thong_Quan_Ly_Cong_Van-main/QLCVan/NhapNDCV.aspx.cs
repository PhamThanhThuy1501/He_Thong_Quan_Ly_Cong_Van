using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

namespace QLCVan
{
    public partial class NhapNDCV : System.Web.UI.Page
    {
        InfoDataContext db = new InfoDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!(Session["TenDN"] != null))
            {
                Response.Redirect("Gioithieu.aspx");
            }
            if (Session["QuyenHan"].ToString().Trim() == "User")
            {
                Response.Write("<script type='text/javascript'>");
                Response.Write("alert('Bạn không có quyền truy cập trang này !');");
                Response.Write("document.location.href='Trangchu.aspx';");
                Response.Write("</script>");
            }

            if (!Page.IsPostBack)
            {

                btnsua.Visible = false;
                var cboLoaiCongvans = from d in db.tblLoaiCVs
                                      where d.MaLoaiCV.ToString() != null
                                      select d.TenLoaiCV;

                ddlLoaiCV.DataSource = cboLoaiCongvans;
                ddlLoaiCV.DataBind();
                var cbNguoiki = (from d in db.tblNoiDungCVs
                                 where d.MaLoaiCV.ToString() != null
                                 select d.NguoiKy).Distinct();
                var gv1 = from g in db.tblNoiDungCVs
                          from h in db.tblLoaiCVs
                          where g.MaLoaiCV == h.MaLoaiCV
                          orderby g.NgayGui descending
                          select new
                          {
                              g.MaCV,
                              g.SoCV,
                              h.TenLoaiCV,
                              g.NgayGui,
                              g.TieuDeCV,
                              g.CoQuanBanHanh,
                              g.GhiChu,
                              g.NgayBanHanh,
                              g.NguoiKy,
                              g.NoiNhan,
                              TrichYeuND = g.TrichYeuND.Substring(0, 250) + " ... ",
                              g.TrangThai

                          };

                gvnhapcnden.DataSource = gv1;
                gvnhapcnden.DataBind();
                ddlLoaiCV.DataSource = db.tblLoaiCVs;
                ddlLoaiCV.DataTextField = "TenLoaiCV";
                ddlLoaiCV.DataValueField = "MaLoaiCV";
                ddlLoaiCV.DataBind();

                if (Request.QueryString["macv"] != null)
                {
                    tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV.ToString() == (Request.QueryString["macv"].ToString()));

                    if (cv1 != null)
                    {
                        txttieude.Text = cv1.TieuDeCV;
                        txtngayracv.Text = cv1.NgayGui.ToString();
                        txtcqbh.Text = cv1.CoQuanBanHanh;
                        txtsocv.Text = cv1.SoCV;
                        txttrichyeu.InnerText = cv1.TrichYeuND;
                        btnthem.Visible = false;
                        btnsua.Visible = true;
                        ListBox1.DataTextField = "TenFile";
                        ListBox1.DataSource = cv1.tblFileDinhKems;
                        ListBox1.DataBind();
                        RadioButtonList1.SelectedIndex = (int)cv1.GuiHayNhan;
                    }
                }

            }
        }
        protected void lnk_Sua_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["macv"] != null)
            {
                tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV.ToString() == (Request.QueryString["macv"].ToString()));

                if (cv1 != null)
                {

                    txttieude.Text = cv1.TieuDeCV;
                    txtngayracv.Text = cv1.NgayGui.ToString();

                    txtcqbh.Text = cv1.CoQuanBanHanh;
                    txtsocv.Text = cv1.SoCV;
                    txttrichyeu.InnerText = cv1.TrichYeuND;
                    btnthem.Visible = false;
                    btnsua.Visible = true;
                    ListBox1.DataTextField = "TenFile";
                    ListBox1.DataSource = cv1.tblFileDinhKems;
                    ListBox1.DataBind();
                    RadioButtonList1.SelectedIndex = (int)cv1.GuiHayNhan;

                }
            }

            LinkButton lnk = (sender) as LinkButton;
            string str = lnk.CommandArgument;
            Response.Redirect("~/NhapNDCV.aspx?MaCV=" + str);

        }

        protected void lnk_Xoa_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (sender) as LinkButton;
            string str = lnk.CommandArgument;

            foreach (tblFileDinhKem item in db.tblFileDinhKems.Where(f => f.MaCV == str))
            {
                db.tblFileDinhKems.DeleteOnSubmit(item);
            }
            tblNoiDungCV cv = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV == str);
            if (cv != null)
            {
                db.tblNoiDungCVs.DeleteOnSubmit(cv);
                db.SubmitChanges();
                Page_Load(sender, e);

                Response.Redirect("~/NhapNDCV.aspx");

            }
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            string MaCongVan = Guid.NewGuid().ToString();

            tblNoiDungCV cv1 = new tblNoiDungCV();
            cv1.MaCV = MaCongVan.ToString();
            cv1.SoCV = txtsocv.Text;
            DateTime ngayguicv = DateTime.ParseExact(txtngayracv.Text.ToString(), "dd/MM/yyyy", null);
            cv1.NgayGui = ngayguicv;
            cv1.TieuDeCV = txttieude.Text;
            cv1.MaLoaiCV = int.Parse(ddlLoaiCV.SelectedValue.ToString());
            cv1.CoQuanBanHanh = txtcqbh.Text;
            cv1.TrichYeuND = txttrichyeu.InnerText;
            DateTime ngaybancv = DateTime.ParseExact(txtngaynhancv.Text.ToString(), "dd/MM/yyyy", null);
            cv1.NgayBanHanh = ngaybancv;
            if ((Session["TenDN"].ToString().Equals("quyen")))
            {
                cv1.TrangThai = false;
            }
            else
            {
                cv1.TrangThai = true;
            }
            if (RadioButtonList1.SelectedIndex == 0)
            {
                cv1.GuiHayNhan = 1;
            }
            else
                cv1.GuiHayNhan = 0;

            db.tblNoiDungCVs.InsertOnSubmit(cv1);
            db.SubmitChanges();
            if (ListBox1.Items.Count != 0)
            {
                foreach (ListItem item in ListBox1.Items)
                {
                    tblFileDinhKem fcv = new tblFileDinhKem();
                    fcv.MaCV = cv1.MaCV;
                    fcv.FileID = Guid.NewGuid().ToString();

                    fcv.Size = Convert.ToInt32(item.Value);
                    fcv.DateUpload = DateTime.Now.ToShortDateString();
                    fcv.TenFile = item.Text;
                    fcv.Url = "~/Upload/" + item.Text;

                    db.tblFileDinhKems.InsertOnSubmit(fcv);
                    db.SubmitChanges();

                }
            }
            Response.Redirect("NhapNDCV.aspx");

        }

        public string kttrangthai(object obj)
        {
            bool trangthai = bool.Parse(obj.ToString());
            if (trangthai)
            {
                return "Đã duyệt";
            }
            else
            {
                return "Chưa duyệt";
            }
        }

        protected void btnUp_Click(object sender, EventArgs e)
        {
            string UploadFolder = Server.MapPath("/Upload/");
            if (FileUpload1.HasFile)
                try
                {
                    string filename = FileUpload1.PostedFile.FileName;
                    string FileNameOnServer = UploadFolder + filename;
                    FileUpload1.SaveAs(FileNameOnServer);

                    ListItem item = new ListItem(filename, Convert.ToString(FileUpload1.PostedFile.ContentLength));
                    ListBox1.Items.Add(item);

                }
                catch (Exception ex)
                {
                    lblloi.Text = "Lỗi: " + ex.Message.ToString();
                }
            else
            {
                lblchuachonfile.Text = "Bạn chưa chọn file!";
            }
        }
        void RemoveFile(int index)
        {
            if (index >= ListBox1.Items.Count) return;
            string filename = ListBox1.Items[index].Value;
            System.IO.File.Delete(filename);
            ListBox1.Items.RemoveAt(index);
        }
        protected void btnRemove_Click(object sender, EventArgs e)
        {

            RemoveFile(ListBox1.SelectedIndex);
        }

        protected void btnReAll_Click(object sender, EventArgs e)
        {
            while (ListBox1.Items.Count > 0) RemoveFile(0);
        }

        protected void btnsua_Click(object sender, EventArgs e)
        {

            if (Request.QueryString["macv"] != null)
            {
                tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV.ToString() == (Request.QueryString["macv"].ToString()));
                if (cv1 != null)
                {
                    {
                        cv1.SoCV = txtsocv.Text;
                        cv1.NgayGui = new DateTime(
                Convert.ToInt32(txtngayracv.Text.Split('-')[2]),
                Convert.ToInt32(txtngayracv.Text.Split('-')[1]),
                Convert.ToInt32(txtngayracv.Text.Split('-')[0]));
                        cv1.TieuDeCV = txttieude.Text;
                        cv1.MaLoaiCV = int.Parse(ddlLoaiCV.SelectedValue.ToString());
                        cv1.CoQuanBanHanh = txtcqbh.Text;
                        cv1.TrichYeuND = txttrichyeu.InnerText;
                        cv1.NgayBanHanh = new DateTime(
               Convert.ToInt32(txtngayracv.Text.Split('-')[2]),
               Convert.ToInt32(txtngayracv.Text.Split('-')[1]),
               Convert.ToInt32(txtngayracv.Text.Split('-')[0]));
                        if (RadioButtonList1.SelectedIndex == 0)
                        {
                            cv1.GuiHayNhan = 1;
                        }
                        else
                            cv1.GuiHayNhan = 0;
                        for (int i = 0; i < ListBox1.Items.Count; i++)
                        {
                            var files = db.tblFileDinhKems.Where(t => t.MaCV.ToString() == (Request.QueryString["macv"].ToString()));
                            bool check = true;
                            foreach (var item in files)
                            {
                                if (ListBox1.Items[i].Text == item.TenFile)
                                {
                                    check = false;
                                    break;
                                }
                            }

                            if (check)
                            {
                                tblFileDinhKem file = new tblFileDinhKem();
                                file.FileID = Guid.NewGuid().ToString();
                                file.Url = ListBox1.Items[i].Value.ToString();
                                file.TenFile = (ListBox1.Items[i].Text);
                                file.DateUpload = DateTime.Now.ToShortDateString();
                                file.MaCV = cv1.MaCV;
                                db.tblFileDinhKems.InsertOnSubmit(file);
                                db.SubmitChanges();
                            }

                        }
                        db.SubmitChanges();

                    }
                    Response.Redirect("NhapNDCV.aspx");
                    btnthem.Visible = true;
                    btnsua.Visible = false;

                }
            }
        }

        protected void btnlammoi_Click(object sender, EventArgs e)
        {
            txtcqbh.Text = "";
            txtngaynhancv.Text = "";
            txtngayracv.Text = "";
            txtsocv.Text = "";
            txttieude.Text = "";
            txttrichyeu.InnerText = "";


        }

        protected void gvnhapcnden_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            var gv1 = from g in db.tblNoiDungCVs
                      from h in db.tblLoaiCVs
                      where g.MaLoaiCV == h.MaLoaiCV
                      orderby g.NgayGui descending
                      select new
                      {
                          g.MaCV,
                          g.SoCV,
                          h.TenLoaiCV,
                          g.NgayGui,
                          g.TieuDeCV,
                          g.CoQuanBanHanh,
                          g.NgayBanHanh,
                          g.NguoiKy,
                          TrichYeuND = g.TrichYeuND.Substring(0, 200) + ". . ."
                      };
            gvnhapcnden.PageIndex = e.NewPageIndex;
            gvnhapcnden.DataSource = gv1;
            gvnhapcnden.DataBind();

        }

        protected void gvnhapcnden_SelectedIndexChanged(object sender, EventArgs e)
        {


        }

        protected void cboLoaiCongvan_ItemInserting(object sender, AjaxControlToolkit.ComboBoxItemInsertEventArgs e)
        {
            string congvanmoi = e.Item.Value;
            tblLoaiCV pr = new tblLoaiCV();
            pr.TenLoaiCV = congvanmoi;
            db.tblLoaiCVs.InsertOnSubmit(pr);
            db.SubmitChanges();
            pr = db.tblLoaiCVs.SingleOrDefault(p => p.TenLoaiCV == congvanmoi);
            e.Item.Value = pr.MaLoaiCV.ToString();
        }

        protected void cboNguoiKy_ItemInserted(object sender, AjaxControlToolkit.ComboBoxItemInsertEventArgs e)
        {
            string nguoikimoi = e.Item.Value;
            tblNoiDungCV pr = new tblNoiDungCV();
            pr.NguoiKy = nguoikimoi;
            db.tblNoiDungCVs.InsertOnSubmit(pr);
            db.SubmitChanges();
            pr = db.tblNoiDungCVs.SingleOrDefault(p => p.NguoiKy == nguoikimoi);
            e.Item.Value = pr.MaLoaiCV.ToString();
        }


    }
}