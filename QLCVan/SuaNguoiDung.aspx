<%@ Page Title="Chỉnh sửa tài khoản người dùng" Language="C#" MasterPageFile="~/QLCV.Master"
    AutoEventWireup="true" CodeBehind="SuaNguoiDung.aspx.cs" Inherits="QLCVan.SuaNguoiDung" %>

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

    .status-group {
      flex: 1;
      display: flex;
      align-items: center;
      gap: 25px;
      height: 38px;
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

    .btn-secondary {
      background: #6c757d;
      border: none;
      padding: 10px 22px;
      font-weight: 600;
      border-radius: 6px;
      color: #fff;
      margin-right: 10px;
    }

    .btn-secondary:hover { background:#555; }

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
    <h3 class="page-title">CHỈNH SỬA TÀI KHOẢN NGƯỜI DÙNG</h3>

    <div class="row">
      <!-- Cột trái -->
      <div class="col-md-6">
        <div class="form-row">
          <label>Mã người dùng:</label>
          <asp:TextBox ID="txtMaNguoiDung" runat="server" CssClass="form-control" ReadOnly="true" />
        </div>

        <div class="form-row">
          <label>Họ và tên:</label>
          <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" />
        </div>

        <div class="form-row">
          <label>Email:</label>
          <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
        </div>

        <div class="form-row">
          <label>Đơn vị:</label>
          <asp:DropDownList ID="ddlDonVi" runat="server" CssClass="form-select">
            <asp:ListItem Text="Khoa Binh chủng hợp thành" />
            <asp:ListItem Text="Khoa Chiến thuật" />
          </asp:DropDownList>
        </div>

        <div class="form-row">
          <label>Trạng thái:</label>
          <div class="status-group">
            <label><asp:RadioButton ID="rbKichHoat" runat="server" GroupName="TrangThai" Text="Kích hoạt" /></label>
            <label><asp:RadioButton ID="rbChuaKichHoat" runat="server" GroupName="TrangThai" Text="Chưa kích hoạt" /></label>
          </div>
        </div>
      </div>

      <!-- Cột phải -->
      <div class="col-md-6">
        <div class="form-row">
          <label>Tên đăng nhập:</label>
          <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" ReadOnly="true" />
        </div>

        <div class="form-row">
          <label>Mật khẩu mới:</label>
          <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập mật khẩu mới (nếu có)" />
        </div>

        <div class="form-row">
          <label>Xác nhận mật khẩu:</label>
          <asp:TextBox ID="txtXacNhanMK" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập lại mật khẩu" />
        </div>

        <div class="form-row">
          <label>Chức vụ:</label>
          <asp:DropDownList ID="ddlChucVu" runat="server" CssClass="form-select">
            <asp:ListItem Text="Giáo viên" />
            <asp:ListItem Text="Trợ giảng" />
          </asp:DropDownList>
        </div>
      </div>
    </div>

    <div class="text-end mt-4">
      <a href="QLNguoiDung.aspx" class="btn btn-secondary">Quay lại</a>
      <asp:Button ID="btnSua" runat="server" CssClass="btn btn-primary" Text="Lưu chỉnh sửa" OnClick="btnSua_Click" />
    </div>
  </div>
</asp:Content>
