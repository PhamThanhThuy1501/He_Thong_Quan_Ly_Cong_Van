<%@ Page Title="Thêm tài khoản người dùng" Language="C#" MasterPageFile="~/QLCV.Master"
    AutoEventWireup="true" CodeBehind="ThemNguoiDung.aspx.cs" Inherits="QLCVan.ThemNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body { background:#f3f4f6; }

    .main-title {
      text-transform: uppercase;
      font-weight: 700;
      font-size: 20px;
      color: #444;
      margin-bottom: 8px;
    }

    .marquee {
      background: #c00;
      color: #fff;
      border-radius: 3px;
      padding: 4px 8px;
      margin-bottom: 20px;
      font-weight: 600;
    }

    .marquee marquee {
      font-size: 15px;
      font-weight: 600;
    }

    .page {
      max-width: 1100px;
      margin: 35px auto;
      background: #f8f9fa;
      border: 1px solid #e5e7eb;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.08);
      padding: 45px 50px;
    }

    h3.page-title {
      text-align: center;
      font-weight: 700;
      font-size: 20px;
      margin-bottom: 30px;
      text-transform: uppercase;
      color:#111827;
    }

    /* Dòng form */
    .form-row {
      display: flex;
      align-items: center;
      margin-bottom: 18px;
      min-height: 40px;
    }

    .form-row label {
      width: 160px;
      text-align: right;
      font-weight: 700;
      color: #333;
      font-size: 15px;
      margin: 0 10px 0 0;
      white-space: nowrap;
    }

    .form-row .form-control,
    .form-row .form-select {
      flex: 1;
      font-size: 14px;
      height: 38px;
      padding: 6px 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      background: #fff;
    }

    /* --- Fix trạng thái cho chuẩn hàng --- */
    .status-group {
      flex: 1;
      display: flex;
      align-items: center; /* căn giữa theo chiều dọc */
      /*gap: 10px;*/
      height: 38px; /* 🔹 cao bằng ô input */
    }

    .status-group label {
      margin: 0;
      font-weight: 500;
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .status-group input[type="radio"] {
      transform: scale(1.1);
      margin: 0;
    }

    .btn-primary {
      background: #0d6efd;
      border: none;
      padding: 10px 22px;
      font-weight: 600;
      border-radius: 6px;
    }

    .btn-primary:hover { background:#0948a0; }

    .form-control:focus, .form-select:focus {
      border-color: #66afe9;
      box-shadow: 0 0 3px rgba(102,175,233,0.5);
      outline: none;
    }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <div class="main-title">QUẢN LÝ NGƯỜI DÙNG</div>
  <div class="marquee">
    <marquee behavior="scroll" direction="left" scrollamount="6">
      Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.
    </marquee>
  </div>

  <div class="page">
    <h3 class="page-title">THÊM TÀI KHOẢN NGƯỜI DÙNG</h3>

    <div class="row">
      <div class="col-md-6">
        <div class="form-row">
          <label>Mã người dùng:</label>
          <asp:TextBox ID="txtMaNguoiDung" runat="server" CssClass="form-control" placeholder="Nhập mã người dùng" />
        </div>

        <div class="form-row">
          <label>Họ và tên:</label>
          <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nhập họ và tên" />
        </div>

        <div class="form-row">
          <label>Email:</label>
          <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Nhập email" />
        </div>

        <div class="form-row">
          <label>Đơn vị:</label>
          <asp:DropDownList ID="ddlDonVi" runat="server" CssClass="form-select">
            <asp:ListItem Text="Đơn vị" />
            <asp:ListItem Text="Khoa Binh chủng hợp thành" />
            <asp:ListItem Text="Khoa Chiến thuật" />
          </asp:DropDownList>
        </div>

        <div class="form-row">
          <label>Trạng thái:</label>
          <div class="status-group">
            <label><asp:RadioButton ID="rbKichHoat" runat="server" GroupName="TrangThai" Text="Kích hoạt" Checked="true" /></label>
            <label><asp:RadioButton ID="rbChuaKichHoat" runat="server" GroupName="TrangThai" Text="Chưa kích hoạt" /></label>
          </div>
        </div>
      </div>

      <div class="col-md-6">
        <div class="form-row">
          <label>Tên đăng nhập:</label>
          <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" placeholder="Nhập tên đăng nhập" />
        </div>

        <div class="form-row">
          <label>Mật khẩu:</label>
          <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập mật khẩu" />
        </div>

        <div class="form-row">
          <label>Xác nhận mật khẩu:</label>
          <asp:TextBox ID="txtXacNhanMK" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập lại mật khẩu" />
        </div>

        <div class="form-row">
          <label>Chức vụ:</label>
          <asp:DropDownList ID="ddlChucVu" runat="server" CssClass="form-select">
            <asp:ListItem Text="Chức vụ" />
            <asp:ListItem Text="Giáo viên" />
            <asp:ListItem Text="Trợ giảng" />
          </asp:DropDownList>
        </div>
      </div>
    </div>
      <div class="text-end mt-4">
  <a href="QLNguoiDung.aspx" class="btn btn-secondary me-2">Quay lại</a>
  <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Thêm người dùng" OnClick="btnThem_Click" />
</div>

    
  </div>
</asp:Content>
