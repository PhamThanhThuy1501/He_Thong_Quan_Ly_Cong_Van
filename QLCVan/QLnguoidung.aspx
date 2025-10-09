<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLnguoidung.aspx.cs" Inherits="QLCVan.QLnguoidung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        .page { max-width:1100px; margin:24px auto; padding:0 14px; }
        .page-title { text-align:center; font-size:26px; font-weight:700; margin:12px 0 20px; color:#0f172a; }

        .filters { display:flex; gap:12px; margin-bottom:20px; }
        .filters input, .filters select {
            height:40px; padding:0 10px; border:1px solid #ccc; border-radius:6px;
        }
        .filters .btn { height:40px; padding:0 18px; border:none; border-radius:6px; cursor:pointer; }
        .btn-danger { background:#c62828; color:#fff; }
        .btn-primary { background:#0b57d0; color:#fff; }

        .grid { width:100%; border-collapse:collapse; }
        .grid th { background:#c62828; color:#fff; padding:10px; text-align:left; }
        .grid td { border:1px solid #e6e6e6; padding:10px; }
        .status-active { background:#4caf50; color:#fff; padding:4px 10px; border-radius:6px; }
        .status-inactive { background:#d32f2f; color:#fff; padding:4px 10px; border-radius:6px; }

        .iconBtn { border:none; background:none; cursor:pointer; margin:0 4px; }
        .iconBtn i { font-size:16px; }
        .icon-edit { color:#0b57d0; }
        .icon-del { color:#d32f2f; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page">
        <h3 class="page-title">DANH SÁCH NGƯỜI DÙNG</h3>

        <!-- Thanh tìm kiếm -->
        <div class="filters">
            <asp:TextBox ID="txtTenDN" runat="server" Placeholder="Tên đăng nhập"></asp:TextBox>
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email"></asp:TextBox>
            <asp:DropDownList ID="ddlDonVi" runat="server"></asp:DropDownList>
            <asp:DropDownList ID="ddlChucVuFilter" runat="server">
                <asp:ListItem Text="Chức vụ" Value="" />
                <asp:ListItem Text="Giáo viên" Value="Giáo viên" />
                <asp:ListItem Text="Trưởng bộ môn" Value="Trưởng bộ môn" />
                <asp:ListItem Text="Trưởng khoa" Value="Trưởng khoa" />
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-danger" OnClick="btnSearch_Click" />
            <asp:Button ID="btnAdd" runat="server" Text="Thêm người dùng" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
        </div>

        <!-- Grid -->
        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="grid"
                      DataKeyNames="MaNguoiDung"
                      OnRowEditing="gvUsers_RowEditing" OnRowDeleting="gvUsers_RowDeleting">
            <Columns>
                <asp:BoundField DataField="TenDN" HeaderText="Tên đăng nhập" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="DonVi" HeaderText="Đơn vị" />
                <asp:BoundField DataField="ChucVu" HeaderText="Chức vụ" />
                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <%# (Eval("TrangThai")+"")=="0" ? "<span class='status-active'>Đang kích hoạt</span>" : "<span class='status-inactive'>Đã khóa</span>" %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thao tác" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("MaNguoiDung") %>' CssClass="iconBtn">
                            <i class="fa fa-pen icon-edit"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("MaNguoiDung") %>'
                                        OnClientClick="return confirm('Bạn có chắc muốn xoá người dùng này không?');"
                                        CssClass="iconBtn">
                            <i class="fa fa-trash icon-del"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
