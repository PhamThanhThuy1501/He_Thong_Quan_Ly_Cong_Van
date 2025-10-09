<%@ Page Language="C#" AutoEventWireup="true" Codefile="UserCreate.aspx.cs" Inherits="QLCVan.UserCreate" MasterPageFile="~/QLCV.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-wrapper {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px 25px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background: #fafafa;
        }
        h3 {
            text-align: center;
            margin-bottom: 20px;
            color: #0f172a;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px 28px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            font-weight: bold;
            margin-bottom: 6px;
            color: #374151;
        }
        .input-lg {
            height: 40px;
            padding: 8px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
        }
        .actions {
            margin-top: 25px;
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }
        .btn-primary {
            background: #0b57d0;
            color: white;
        }
        .btn-primary:hover {
            background: #0949ae;
        }
        .status-group {
            display: flex;
            gap: 16px;
            margin-top: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-wrapper">
        <h3>THÊM TÀI KHOẢN NGƯỜI DÙNG</h3>
        <div class="form-grid">
            <!-- Cột trái -->
            <div class="form-group">
                <label for="txtMaND">Mã người dùng:</label>
                <asp:TextBox ID="txtMaND" runat="server" CssClass="input-lg" Placeholder="Nhập mã người dùng" />
            </div>

            <div class="form-group">
                <label for="txtTenDN">Tên đăng nhập:</label>
                <asp:TextBox ID="txtTenDN" runat="server" CssClass="input-lg" Placeholder="Nhập tên đăng nhập" />
            </div>

            <div class="form-group">
                <label for="txtHoTen">Họ và tên:</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="input-lg" Placeholder="Nhập vào tên đầy đủ" />
            </div>

            <div class="form-group">
                <label for="txtMatKhau">Mật khẩu:</label>
                <asp:TextBox ID="txtMatKhau" runat="server" CssClass="input-lg" TextMode="Password" Placeholder="Nhập mật khẩu" />
            </div>

            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-lg" Placeholder="Nhập email" />
            </div>

            <div class="form-group">
                <label for="txtMatKhau2">Xác nhận mật khẩu:</label>
                <asp:TextBox ID="txtMatKhau2" runat="server" CssClass="input-lg" TextMode="Password" Placeholder="Nhập lại mật khẩu" />
            </div>

            <div class="form-group">
                <label for="ddlDonVi">Đơn vị:</label>
                <asp:DropDownList ID="ddlDonVi" runat="server" CssClass="input-lg"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="ddlChucVu">Chức vụ:</label>
                <asp:DropDownList ID="ddlChucVu" runat="server" CssClass="input-lg">
                    <asp:ListItem>Giáo viên</asp:ListItem>
                    <asp:ListItem>Trưởng bộ môn</asp:ListItem>
                    <asp:ListItem>Trưởng khoa</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- Trạng thái -->
        <div class="form-group">
            <label>Trạng thái:</label>
            <div class="status-group">
                <asp:RadioButton ID="rdbActive" runat="server" GroupName="status" Text="Kích hoạt" Checked="true" />
                <asp:RadioButton ID="rdbInactive" runat="server" GroupName="status" Text="Chưa kích hoạt" />
            </div>
        </div>

        <!-- Nút -->
        <div class="actions">
            <asp:Button ID="btnSave" runat="server" Text="Thêm người dùng" CssClass="btn btn-primary" OnClick="btnSave_Click" />
        </div>
    </div>
</asp:Content>
