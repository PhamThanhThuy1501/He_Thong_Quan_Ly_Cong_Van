<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLNhom.aspx.cs" Inherits="QLCVan.QLNhom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    .section-title{font-size:26px;font-weight:700;color:#0f172a;text-align:center;margin-bottom:20px}
    .grid-header-red th{background-color:#c00!important;color:#fff!important;text-align:center}

    /* Thanh thông báo đỏ */
    .notice-bar{background:#c00;color:#fff;padding:8px 12px;margin:10px 0 16px}
/* form nhỏ gọn như ảnh 2 */
.toolbar { width:48%; margin:0 auto 14px auto; }
.toolbar .form-control{
  height:36px;                /* thấp hơn */
  border-radius:6px;          /* bo nhẹ */
  padding:6px 10px;
  font-size:14px;
  border-color:#dee2e6;       /* xám nhạt */
}
.search-caption{
  font-weight:600; color:#212529; font-size:16px;
  margin-right:12px; white-space:nowrap;
}

/* nút đỏ kính lúp: nhỏ, vuông */
/* trước: width:36px;height:36px;border-radius:6px;background-size:62% 62%; */
.btn-search-red{
  width:60px;        /* rộng hơn xíu */
  height:36px;       /* giữ cùng chiều cao với ô nhập */
  border-radius:6px; /* bo nhẹ như ảnh */
  background:#c00;
  border:1px solid #c00;
  display:inline-block; padding:0; cursor:pointer;
  background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath fill='%23ffffff' d='M500.3 443.7 382 325.4c28.4-34.9 45.5-79.4 45.5-127.4C427.5 88.1 339.4 0 231.8 0S36.1 88.1 36.1 197.9 124.2 395.7 231.8 395.7c48 0 92.5-17.1 127.4-45.5l118.3 118.3c7.5 7.5 19.8 7.5 27.3 0s7.5-19.8 0-27.3zM231.8 355.7c-87.1 0-157.9-70.8-157.9-157.9S144.7 39.9 231.8 39.9 389.7 110.7 389.7 197.8 318.9 355.7 231.8 355.7z'/%3E%3C/svg%3E");
  background-repeat:no-repeat;
  background-position:center;
  background-size:58% 58%;
  text-indent:-9999px; overflow:hidden;
}

.btn-search-red:hover{ background:#a00; border-color:#a00 }

/* nút Thêm đơn vị gọn, không quá to */
.btn-add{
  height:36px; border-radius:6px; padding:6px 14px;
  font-size:14px; font-weight:500;
}

    }
    .btn-search-red:hover{background:#a00;border-color:#a00}

    /* Pager */
    .pager a,.pager span{display:inline-block;padding:3px 10px;border:1px solid #ddd;margin:0 3px;border-radius:3px;text-decoration:none}
    .pager span{background:#c00;color:#fff;border-color:#c00}
    .pager a{color:#0f172a}
    .marquee-red{
  background:#c00; color:#fff; height:36px;
  display:flex; align-items:center; overflow:hidden; padding:0 8px;
}
.marquee-red span{
  display:inline-block; white-space:nowrap; padding-left:100%;
  animation:scroll-left 15s linear infinite;
}
@keyframes scroll-left{
  0%   { transform:translateX(0); }
  100% { transform:translateX(-100%); }
}
.cv-head{ font-weight:700; }

  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="cv">
    <div class="cv-head">QUẢN LÝ NHÓM</div>

    <div class="marquee-red">
  <span>Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</span>
</div>


    <center>
      <h3 class="section-title"><b>DANH SÁCH ĐƠN VỊ</b></h3>

      <asp:HiddenField ID="hdfID" runat="server" />

      <!-- "Tìm kiếm" + 2 ô + nút đỏ kính lúp + nút Thêm đơn vị -->
      <div class="toolbar d-flex align-items-center">
  <div class="d-flex align-items-center gap-2 flex-grow-1">
    <span class="search-caption">Tìm kiếm</span>
    <asp:TextBox ID="txtSearchMa" runat="server" CssClass="form-control" placeholder="Nhập mã đơn vị" />
    <asp:TextBox ID="txtSearchTen" runat="server" CssClass="form-control" placeholder="Nhập tên đơn vị" />
    <!-- giữ Button để không lỗi designer -->
    <asp:Button ID="btnSearch" runat="server" Text=" " CssClass="btn-search-red"
                ToolTip="Tìm kiếm" OnClick="btnSearch_Click" />
  </div>

  <!-- Nút thêm gọn, không icon + -->
  <button type="button" class="btn btn-primary btn-add ms-2" data-bs-toggle="modal" data-bs-target="#addModal">
    Thêm đơn vị
  </button>
</div>


      <!-- Bảng -->
      <asp:GridView ID="gvQLNhom" runat="server" AutoGenerateColumns="False"
        CssClass="table table-bordered table-striped table-hover"
        HeaderStyle-CssClass="grid-header-red"
        Width="48%" CellPadding="4" ForeColor="#333333"
        DataKeyNames="MaDonVi"
        OnRowDeleting="rowDeleting"
        OnRowCancelingEdit="rowCancelingEdit"
        OnRowEditing="rowEditing"
        OnRowUpdating="rowUpdating"
        OnRowCommand="rowCommand"
        AllowPaging="True" PageSize="5"
        OnPageIndexChanging="gvQLNhom_PageIndexChanging">
        <PagerSettings Mode="Numeric" Position="Bottom" PageButtonCount="5" />
        <PagerStyle CssClass="pager" HorizontalAlign="Center" />
        <Columns>
          <asp:TemplateField HeaderText="Mã đơn vị">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemTemplate><asp:Label ID="lblMaDonVi" runat="server" Text='<%# Eval("MaDonVi") %>'></asp:Label></ItemTemplate>
          </asp:TemplateField>

          <asp:TemplateField HeaderText="Tên đơn vị">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemTemplate><asp:Label ID="lblTenDonVi" runat="server" Text='<%# Eval("TenDonVi") %>'></asp:Label></ItemTemplate>
            <EditItemTemplate><asp:TextBox ID="txtTenNhom" runat="server" CssClass="form-control" Text='<%# Eval("TenDonVi") %>'></asp:TextBox></EditItemTemplate>
          </asp:TemplateField>

          <asp:TemplateField HeaderText="Thao tác">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemTemplate>
              <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("MaDonVi") %>'
                CssClass="btn btn-warning btn-sm me-1" ToolTip="Sửa"><i class="fa fa-edit"></i></asp:LinkButton>
              <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Bạn có chắc muốn xóa không?');" ToolTip="Xóa">
                <i class="fa fa-trash"></i>
              </asp:LinkButton>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm me-1" ToolTip="Lưu">
                <i class="fa fa-check"></i>
              </asp:LinkButton>
              <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm" ToolTip="Hủy">
                <i class="fa fa-times"></i>
              </asp:LinkButton>
            </EditItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </center>

    <!-- Modal thêm đơn vị -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addModalLabel">Thêm đơn vị</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3"><asp:TextBox ID="txtTenDonVi" runat="server" CssClass="form-control" placeholder="Nhập mã đơn vị..." /></div>
            <div class="mb-3"><asp:TextBox ID="txtMoTaDonVi" runat="server" CssClass="form-control" placeholder="Nhập tên đơn vị..." /></div>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Thêm" OnClick="btnSave_Click" />
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
          </div>
        </div>
      </div>
    </div>
      <!-- === MODAL SỬA ĐƠN VỊ (mới) === -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editModalLabel">Sửa đơn vị</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        <!-- Lưu khóa để update -->
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <div class="mb-3">
          <label for="txtEditMaDonVi" class="form-label">Mã đơn vị</label>
          <asp:TextBox ID="txtEditMaDonVi" runat="server" CssClass="form-control" ReadOnly="true" />
        </div>
        <div class="mb-3">
          <label for="txtEditTenDonVi" class="form-label">Tên đơn vị</label>
          <asp:TextBox ID="txtEditTenDonVi" runat="server" CssClass="form-control" />
        </div>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnEditSave" runat="server" CssClass="btn btn-success" Text="Sửa" OnClick="btnEditSave_Click" />
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<!-- Script gọi Bootstrap 5 Modal -->
<script>
  function showEditModal() {
    var m = new bootstrap.Modal(document.getElementById('editModal'));
    m.show();
  }
  function hideEditModal() {
    var el = document.getElementById('editModal');
    var m = bootstrap.Modal.getInstance(el);
    if (m) m.hide();
  }
</script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </div>
</asp:Content>
