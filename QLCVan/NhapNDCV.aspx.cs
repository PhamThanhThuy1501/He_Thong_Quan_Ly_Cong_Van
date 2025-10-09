using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

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

                }
            }

            LinkButton lnk = (sender) as LinkButton;
            string str = lnk.CommandArgument;
            Response.Redirect("~/NhapNDCV.aspx?MaCV=" + str);

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (ListBox1.GetSelectedIndices().Length == 0)
            {
                lblloi.Text = "Vui lòng chọn file để xóa!";
                lblloi.CssClass = "text-danger small d-block";
                return;
            }

            string uploadPath = Server.MapPath("~/Uploads/");
            List<ListItem> toRemove = new List<ListItem>();

            foreach (ListItem item in ListBox1.Items)
            {
                if (item.Selected)
                {
                    string filePath = Path.Combine(uploadPath, item.Text);
                    try
                    {
                        if (File.Exists(filePath))
                            File.Delete(filePath);

                        toRemove.Add(item);
                    }
                    catch (Exception ex)
                    {
                        lblloi.Text = "Lỗi xóa file " + item.Text + ": " + ex.Message;
                        lblloi.CssClass = "text-danger small d-block";
                    }
                }
            }

            foreach (ListItem item in toRemove)
            {
                ListBox1.Items.Remove(item);
            }

            if (toRemove.Count > 0)
            {
                lblloi.Text = "Xóa file thành công!";
                lblloi.CssClass = "text-success small d-block";
            }
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!FileUpload1.HasFiles)
            {
                lblchuachonfile.Text = "Vui lòng chọn file để upload!";
                lblchuachonfile.CssClass = "text-danger small ms-1";
                return;
            }

            string uploadPath = Server.MapPath("~/Uploads/");
            if (!Directory.Exists(uploadPath))
                Directory.CreateDirectory(uploadPath);

            List<string> uploadedFiles = new List<string>();

            foreach (HttpPostedFile file in FileUpload1.PostedFiles)
            {
                string fileName = Path.GetFileName(file.FileName);
                string fullPath = Path.Combine(uploadPath, fileName);

                try
                {
                    file.SaveAs(fullPath);

                    if (!ListBox1.Items.Contains(new ListItem(fileName)))
                        ListBox1.Items.Add(fileName);

                    uploadedFiles.Add(fileName);
                }
                catch (Exception ex)
                {
                    lblloi.Text = "Lỗi upload file " + fileName + ": " + ex.Message;
                    lblloi.CssClass = "text-danger small d-block";
                }
            }

            if (uploadedFiles.Count > 0)
            {
                lblchuachonfile.Text = "Upload thành công: " + string.Join(", ", uploadedFiles);
                lblchuachonfile.CssClass = "text-success small ms-1";
            }
        }
        private void LoadFileList()
    {
        string uploadPath = Server.MapPath("~/Uploads/");
        if (!Directory.Exists(uploadPath))
            return;

        ListBox1.Items.Clear();
        foreach (string file in Directory.GetFiles(uploadPath))
        {
            ListBox1.Items.Add(Path.GetFileName(file));
        }
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


        protected void btnsua_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["macv"] != null)
            {
                tblNoiDungCV cv1 = db.tblNoiDungCVs.SingleOrDefault(t => t.MaCV.ToString() == (Request.QueryString["macv"].ToString()));
                if (cv1 != null)
                {
                    // ✅ XỬ LÝ NGÀY KIỂU dd/MM/yyyy AN TOÀN
                    DateTime ngayGui, ngayBanHanh;
                    if (!DateTime.TryParseExact(
                        txtngayracv.Text.Trim(),
                        "dd/MM/yyyy",
                        System.Globalization.CultureInfo.InvariantCulture,
                        System.Globalization.DateTimeStyles.None,
                        out ngayGui))
                    {
                        // Nếu lỗi format ngày thì không lưu
                        return;
                    }

                    if (!DateTime.TryParseExact(
                        txtngaynhancv.Text.Trim(),
                        "dd/MM/yyyy",
                        System.Globalization.CultureInfo.InvariantCulture,
                        System.Globalization.DateTimeStyles.None,
                        out ngayBanHanh))
                    {
                        return;
                    }

                    // ✅ GÁN GIÁ TRỊ AN TOÀN
                    cv1.SoCV = txtsocv.Text;
                    cv1.NgayGui = ngayGui;
                    cv1.TieuDeCV = txttieude.Text;
                    cv1.MaLoaiCV = int.Parse(ddlLoaiCV.SelectedValue.ToString());
                    cv1.CoQuanBanHanh = txtcqbh.Text;
                    cv1.TrichYeuND = txttrichyeu.InnerText;
                    cv1.NgayBanHanh = ngayBanHanh;

                    // ✅ XỬ LÝ FILE AN TOÀN
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

                        if (check &&
                            !string.IsNullOrEmpty(ListBox1.Items[i].Value) &&
                            !string.IsNullOrEmpty(ListBox1.Items[i].Text))
                        {
                            tblFileDinhKem file = new tblFileDinhKem();
                            file.FileID = Guid.NewGuid().ToString();
                            file.Url = ListBox1.Items[i].Value.ToString();
                            file.TenFile = (ListBox1.Items[i].Text);
                            file.DateUpload = DateTime.Now.ToShortDateString();
                            file.MaCV = cv1.MaCV;
                            db.tblFileDinhKems.InsertOnSubmit(file);
                        }
                    }

                    // ✅ CHẶN LỖI Ở SubmitChanges
                    try
                    {
                        db.SubmitChanges();
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                        return;
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