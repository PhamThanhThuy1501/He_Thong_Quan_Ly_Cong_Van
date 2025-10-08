<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLNhom1.aspx.cs" Inherits="QLCVan.QLNhom1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <!-- Bootstrap 5 CSS + FontAwesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <!-- Style nút phân trang giống trang “Xem công văn” -->
  <style>
    :root{ --red:#c00; } /* nếu Master đã có thì có thể bỏ dòng này */

 .page {
  box-sizing: border-box;
  padding-bottom: 90px; /* đảm bảo luôn có khoảng trống phía dưới */
  max-width: 1340px;    /* giống Master */
  margin: 0 auto;
}
    .pager td{ text-align:center !important; } /* CĂN GIỮA hàng pager */

    .pager a, .pager span{
      display:inline-block; margin:0 6px; padding:10px 14px;
      min-width:40px; border:1px solid #e1e1e1; border-radius:4px;
      color:#0066cc; text-decoration:none;
    }
    .pager a:hover{ border-color:var(--red); color:var(--red); }
    .pager span{ background:var(--red); border-color:var(--red); color:#fff; font-weight:bold; }

        /* khung trang */
        .cv{max-width:1340px; margin:0 auto; padding:12px}

        /* tiêu đề + gạch đỏ ngang */
        .cv-head{
            font-size:20px; font-weight:bold; color:#003366; margin:6px 0 10px;
        }.cv-headbar{height:12px; background:var(--red); margin:8px 0 14px; border-radius:2px}
       

/* banner chữ chạy căn giữa vùng (vùng chạy được thu gọn và căn giữa) */
.cv-banner{
    background:var(--red);
    color:#fff;
     display:flex;
  align-items:center;
  justify-content:center;
  padding: 12px 16px;   /* 12px trên + 12px dưới => chia đều */
  height: 30px;         /* để padding quyết định khoảng trên/dưới */
  box-sizing: border-box;
}

/* khu vực chứa vùng chạy, width điều chỉnh để vùng chạy nằm chính giữa ô */
.cv-banner .marquee-container{
     width:100%;        /* <-- thay 70% thành 600px nếu muốn cố định */
  max-width:1340px;
  overflow:hidden;
  margin:0 auto;
  position:relative;
     
}

/* chữ chạy bên trong vùng chạy */
.cv-banner .marquee {
    display:inline-block;
    white-space:nowrap;
    will-change:transform;
    animation: scroll-left 12s linear infinite; /* đổi 12s để nhanh/chậm */
    font-size:16px;          /* kích thước chữ */
    font-weight:700;
}

/* hover để tạm dừng */
.cv-banner:hover .marquee {
    animation-play-state: paused;
}

@keyframes scroll-left {
    0%   { transform: translateX(100%); }
    100% { transform: translateX(-100%); }
}
/* thêm class cho tiêu đề của section phía dưới để có thể điều chỉnh khoảng cách riêng nếu cần */
.section-title {
  margin-top: 20px;   /* khoảng cách trên so với element trên (nếu bạn muốn thêm nữa tăng giá trị) */
  margin-bottom: 12px;
  font-weight:700;
  font-size:26px;
  color:#0f172a;
  text-align:center;
}
.gridWrapper, .gridInner {
  margin-bottom: 32px;
}
body.has-fixed-footer .cv, body.has-fixed-footer .page {
  padding-bottom: 110px; /* tăng lên nếu footer overlay nội dung */
}
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cv">
        <div class="cv-head">QUẢN LÝ NHÓM</div>

     <div class="cv-banner">
  <div class="marquee-container">
    <div class="marquee">Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</div>
  </div>
</div>


    <center>
      <h3 class="section-title"><b>QUẢN LÝ NHÓM</b></h3>

        <asp:HiddenField ID="hdfID" runat="server" />

        <!-- Nút mở popup -->
        <div class="mb-3 text-end" style="width:48%">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                <i class="fa fa-plus"></i> Thêm nhóm
            </button>
        </div>

        <!-- GridView hiển thị danh sách -->
<asp:GridView ID="gvQLNhom" runat="server" AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped table-hover"
    Width="48%" CellPadding="4" ForeColor="#333333"
    DataKeyNames="MaNhom"
    OnRowDeleting="rowDeleting"
    OnRowCancelingEdit="rowCancelingEdit"
    OnRowEditing="rowEditing"
    OnRowUpdating="rowUpdating"
    OnRowCommand="rowCommand"
    AllowPaging="True" PageSize="5"
    OnPageIndexChanging="gvQLNhom_PageIndexChanging">

    <%-- Phân trang số: ra giữa + style giống Trang chủ (.pager) --%>
    <PagerSettings Mode="Numeric" Position="Bottom" PageButtonCount="5" />
    <PagerStyle CssClass="pager" HorizontalAlign="Center" />

    <Columns>
        <asp:TemplateField HeaderText="Mã Nhóm" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("MaNhom") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Tên Nhóm">
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Eval("MoTa") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtTenNhom" runat="server" CssClass="form-control"
                    Text='<%# Eval("MoTa") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Thao tác" ItemStyle-HorizontalAlign="Center">
            <EditItemTemplate>
                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm">
                    <i class="fa fa-check"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm">
                    <i class="fa fa-times"></i>
                </asp:LinkButton>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("MaNhom") %>'
                    CommandName="Edit" CssClass="btn btn-warning btn-sm">
                    <i class="fa fa-edit"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                    CssClass="btn btn-danger btn-sm"
                    OnClientClick="return confirm('Bạn có chắc muốn xóa không?');">
                    <i class="fa fa-trash"></i>
                </asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

    </center>

    <!-- Modal thêm nhóm -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Thêm nhóm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="txtTenNhomMoi" runat="server" CssClass="form-control" placeholder="Nhập tên nhóm..."></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Lưu" OnClick="btnSave_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
