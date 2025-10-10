<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLNguoiDung.aspx.cs" Inherits="QLCVan.QLNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    body { background:#f3f4f6; }

    .page { background:transparent; padding:0; margin:0; }

    /* Tiêu đề chính */
    .main-title{
      text-transform:uppercase;
      font-weight:700;
      font-size:20px;
      color:#444;
      margin:0 0 6px 0;
    }

    /* Thanh chạy chữ */
    .marquee {
      background:#c00;
      color:#fff;
      border-radius:3px;
      padding:4px 8px;
      margin:0 0 18px 0;
      font-weight:600;
    }
    .marquee marquee { font-size:15px; font-weight:600; }

    /* Tiêu đề danh sách */
    .page-title {
      font-weight:700;
      font-size:22px;
      text-align:center;
      color:#111827;
      margin:18px 0 12px 0;
    }

    /* Nút thêm người dùng */
    .btn-add {
      background:#0d6efd;
      color:#fff;
      border:none;
      padding:8px 18px;
      font-weight:600;
      border-radius:6px;
    }
    .btn-add:hover { background:#0948a0; }

.search-bar, .table-wrapper {
  max-width: 1200px;
  margin: 0 auto 40px auto; /* tạo thêm khoảng cách phía dưới */
}

/* Riêng table-wrapper: thêm padding hoặc khoảng cách cho rõ ràng hơn */
.table-wrapper {
  padding-bottom: 500px; /* đẩy footer xuống thêm */
}


/* Thanh tìm kiếm */
.search-bar {
  background: #f8f9fa;
  border: 1px solid #ddd; /* viền mảnh hơn */
  border-radius: 5px;     /* bo nhẹ góc */
  padding: 15px 18px;     /* thu nhỏ phần đệm */
  box-shadow: 0 1px 3px rgba(0,0,0,0.05); /* bóng nhẹ để nổi bật */
}

    .search-label {
      font-weight:400;
      font-size:15px;
      margin-bottom:15px;
    }

    /* Căn đều các cột trong tìm kiếm */
   .search-group {
  display:grid;
  grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  gap:12px 18px;
  align-items:end;
  max-width:1050px; /* Giới hạn độ rộng tổng */
  margin:auto; /* Căn giữa khối tìm kiếm */
}

   .action-bar {
  max-width: 1200px;      /* bằng khung tìm kiếm & bảng */
  margin: 0 auto 20px auto;
}

    .field {
      display:flex;
      flex-direction:column;
    }

   .field label {
  font-size:15px;       /* to hơn một chút */
  font-weight:700;      /* đậm hơn */
  color:#333;           /* màu đậm hơn nhẹ */
  margin-bottom:6px;    /* giãn thêm khoảng cách dưới */
  text-transform:none;  /* giữ nguyên chữ thường */
}

   .form-control, .form-select {
  height:36px;
  font-size:13.5px;
  max-width:190px; /* Giới hạn chiều rộng từng ô */
}
.btn-search {
  height:36px;
  font-size:13.5px;
}


    /* Bảng */
    .table thead {
      background:#c00;
      color:#fff;
      text-align:center;
    }
    .table td, .table th {
      vertical-align:middle;
      text-align:center;
    }

    /* Trạng thái */
    .badge-status {
      display:inline-flex;
      justify-content:center;
      align-items:center;
      width:140px;
      padding:8px 12px;
      border-radius:12px;
      color:#fff;
      font-weight:600;
      font-size:14px;
    }
    .badge-active { background:#28a745; }
    .badge-locked { background:#dc3545; }

    /* Hành động */
    .btn-action { border:none; background:none; color:#0d6efd; margin:0 3px; }
    .btn-action:hover { color:#063b8f; }
    .btn-delete { color:#dc3545; }
    .btn-delete:hover { color:#a61c1c; }

    /* Pager */
    .grid-pager {
      text-align:center;
      padding:10px 0;
    }
    .grid-pager a, .grid-pager span {
      display:inline-block;
      margin:0 4px;
      padding:6px 10px;
      border:1px solid #e5e7eb;
      border-radius:6px;
      background:#fff;
      text-decoration:none;
    }
    .grid-pager span {
      background:#0d6efd;
      color:#fff;
      border-color:#0d6efd;
    }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="page">

    <!-- Tiêu đề -->
    <div class="main-title">QUẢN LÝ NGƯỜI DÙNG</div>

    <!-- Chạy chữ -->
    <div class="marquee">
      <marquee behavior="scroll" direction="left" scrollamount="6">
        Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.
      </marquee>
    </div>

    <!-- Tiêu đề danh sách -->
    <h3 class="page-title">DANH SÁCH NGƯỜI DÙNG</h3>

    <!-- Nút thêm người dùng -->
<div class="action-bar text-end mb-3">
  <a href="ThemNguoiDung.aspx" class="btn btn-add">
    <i class="fa fa-user-plus"></i> Thêm người dùng
  </a>
</div>


    <!-- Thanh tìm kiếm -->
    <div class="search-bar">
      <div class="search-label">Tìm kiếm</div>

      <div class="search-group">
        <div class="field">
          <label for="txtSearchTenDN">Tên đăng nhập:</label>
          <asp:TextBox ID="txtSearchTenDN" runat="server" CssClass="form-control" placeholder="Nhập tên đăng nhập" />
        </div>

        <div class="field">
          <label for="txtSearchEmail">Email:</label>
          <asp:TextBox ID="txtSearchEmail" runat="server" CssClass="form-control" placeholder="Nhập email" />
        </div>

        <div class="field">
          <label for="ddlDonVi">Đơn vị:</label>
          <asp:DropDownList ID="ddlDonVi" runat="server" CssClass="form-select">
            <asp:ListItem Text="Đơn vị" />
            <asp:ListItem Text="Khoa Binh chủng hợp thành" />
            <asp:ListItem Text="Khoa Chiến thuật" />
          </asp:DropDownList>
        </div>

        <div class="field">
          <label for="ddlChucVu">Chức vụ:</label>
          <asp:DropDownList ID="ddlChucVu" runat="server" CssClass="form-select">
            <asp:ListItem Text="Chức vụ" />
            <asp:ListItem Text="Giáo viên" />
            <asp:ListItem Text="Trợ giảng" />
          </asp:DropDownList>
        </div>

        <div class="field">
          <label>&nbsp;</label>
          <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-danger btn-search" Text="Tìm kiếm" OnClick="btnSearch_Click" />
        </div>
      </div>
    </div>
<!-- Bảng -->
<div class="table-wrapper">
  <asp:GridView ID="gvNguoiDung" runat="server" AutoGenerateColumns="False"
    CssClass="table table-bordered table-hover"
    HeaderStyle-CssClass="table-danger"
    DataKeyNames="TenDangNhap"
    OnRowDeleting="rowDeleting"
    OnRowEditing="rowEditing"
    OnRowUpdating="rowUpdating"
    OnRowCancelingEdit="rowCancelingEdit"
    AllowPaging="True" PageSize="5"
    OnPageIndexChanging="gvNguoiDung_PageIndexChanging"
    PagerStyle-CssClass="grid-pager">

    <PagerSettings Mode="Numeric" Position="Bottom" PageButtonCount="5" />

    <Columns>
      <asp:BoundField DataField="TenDangNhap" HeaderText="Tên đăng nhập" ReadOnly="true" />
      <asp:BoundField DataField="Email" HeaderText="Email" />
      <asp:BoundField DataField="DonVi" HeaderText="Đơn vị" />
      <asp:BoundField DataField="ChucVu" HeaderText="Chức vụ" />
      <asp:TemplateField HeaderText="Trạng thái">
        <ItemTemplate>
          <%# (bool)Eval("DangKichHoat")
              ? "<span class='badge-status badge-active'>Đang kích hoạt</span>"
              : "<span class='badge-status badge-locked'>Đã khóa</span>" %>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="Thao tác">
            <ItemTemplate>
              <a href='<%# "SuaNguoiDung.aspx?TenDangNhap=" + Eval("TenDangNhap") %>' class="btn-action" title="Sửa">
                <i class="fa fa-pen"></i>
              </a>
              <button type="button" class="btn btn-delete" data-bs-toggle="modal"
                      data-bs-target="#confirmDeleteModal"
                      onclick="setDeleteUser('<%# Eval("TenDangNhap") %>')">
                <i class="fa fa-trash"></i>
              </button>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>

    <!-- Modal xác nhận xoá -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Xác nhận xóa người dùng</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <p>Bạn có chắc muốn xóa người dùng này không?</p>
            <asp:HiddenField ID="hdnDeleteUser" runat="server" />
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            <asp:Button ID="btnConfirmDelete" runat="server" CssClass="btn btn-danger"
                        Text="Xóa" OnClick="btnConfirmDelete_Click" />
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    function setDeleteUser(username) {
        document.getElementById('<%= hdnDeleteUser.ClientID %>').value = username;
      }
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
   
