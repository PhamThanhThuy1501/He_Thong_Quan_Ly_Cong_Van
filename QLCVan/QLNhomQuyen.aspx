<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLNhomQuyen.aspx.cs" Inherits="QLCVan.QLNhomQuyen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        .section-title {
            font-size: 26px;
            font-weight: bold;
            color: #0f172a;
            text-align: center;
            margin-bottom: 20px;
        }
        .btn-danger {
            background-color: #c00;
            border-color: #c00;
        }
        .btn-danger:hover {
            background-color: #a00;
            border-color: #a00;
        }
        .grid-header-red th {
            background-color: #c00 !important;
            color: white !important;
            text-align: center;
        }
        .marquee {
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
            font-size: 18px;
            font-weight: 600;
            color: white;
            background-color: #c00;
            padding: 8px 0;
            text-align: center;
        }
        .nowrap-header {
            white-space: nowrap;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cv">
        <div class="cv-head">QUẢN LÝ NGƯỜI DÙNG</div>

        <div class="marquee">
            <marquee behavior="scroll" direction="left" scrollamount="5">
                Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.
            </marquee>
        </div>

        <center>
<div class="mt-4">
    <h4 class="fw-bold text-uppercase text-dark">DANH SÁCH NHÓM QUYỀN</h4>
    <!-- Các phần tìm kiếm và bảng nằm bên dưới -->
</div>

<!-- Khối tìm kiếm -->
<div class="card p-3 border-0 mb-4" style="width: 60%;">
    <div class="d-flex flex-wrap align-items-center gap-2">
        <span class="fw-bold">Tìm kiếm</span>

        <asp:TextBox ID="txtSearchMa" runat="server" CssClass="form-control" placeholder="Nhập mã nhóm quyền..." style="width: 28%;" />
        <asp:TextBox ID="txtSearchTen" runat="server" CssClass="form-control" placeholder="Nhập tên nhóm quyền..." style="width: 28%;" />

        <!-- Nút tìm kiếm -->
        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-danger d-flex justify-content-center align-items-center" Style="height: 38px; width: 38px;" OnClick="btnSearch_Click">
            <i class="fa fa-search"></i>
        </asp:LinkButton>

        <!-- Nút thêm nhóm quyền -->
        <button type="button" class="btn btn-primary ms-auto d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#addQuyenModal">
             Thêm nhóm quyền
        </button>
    </div>
</div>

<!-- Bảng danh sách nhóm quyền -->
<asp:GridView ID="gvQuyen" runat="server" AutoGenerateColumns="False"
    CssClass="table table-bordered table-hover"
    HeaderStyle-CssClass="bg-danger text-white text-center"
    RowStyle-CssClass="text-center"
    Width="60%" CellPadding="4" ForeColor="#333333"
    DataKeyNames="MaQuyen"
    AllowPaging="True" PageSize="5"
    OnPageIndexChanging="gvQuyen_PageIndexChanging"
    OnRowDeleting="gvQuyen_RowDeleting"
    OnRowEditing="gvQuyen_RowEditing"
    OnRowUpdating="gvQuyen_RowUpdating"
    OnRowCancelingEdit="gvQuyen_RowCancelingEdit">

    <Columns>

    <asp:TemplateField HeaderText="Mã nhóm quyền">
        <HeaderStyle Width="11%" CssClass="bg-danger text-white text-center nowrap" />
        <ItemStyle Width="11%" CssClass="text-center nowrap" />
        <ItemTemplate>
            <asp:Label ID="lblMaQuyen" runat="server" Text='<%# Eval("MaQuyen") %>' />
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Tên nhóm quyền">
        <HeaderStyle Width="30%" CssClass="bg-danger text-white text-center nowrap" />
        <ItemStyle Width="30%" CssClass="text-center nowrap" />
        <ItemTemplate>
            <asp:Label ID="lblTenQuyen" runat="server" Text='<%# Eval("TenQuyen") %>' />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Thao tác">
        <HeaderStyle Width="21%" CssClass="bg-danger text-white text-center nowrap" />
        <ItemStyle Width="21%" CssClass="text-center nowrap" />
        <ItemTemplate>
            <asp:LinkButton ID="btnGanQuyen" runat="server" CssClass="btn btn-primary btn-sm me-1">
                Gán quyền
            </asp:LinkButton>
            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-outline-primary btn-sm me-1">
                <i class="fa fa-pencil-alt"></i>
            </asp:LinkButton>
            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                CssClass="btn btn-outline-danger btn-sm"
                OnClientClick="return confirm('Bạn có chắc muốn xóa nhóm quyền này không?');">
                <i class="fa fa-trash"></i>
            </asp:LinkButton>
        </ItemTemplate>
    </asp:TemplateField>
    </Columns>
</asp:GridView>

        </center>

        <!-- Modal thêm quyền -->
        <div class="modal fade" id="addQuyenModal" tabindex="-1" aria-labelledby="addQuyenModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addQuyenModalLabel">Thêm quyền mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <asp:TextBox ID="txtTenQuyenMoi" runat="server" CssClass="form-control" placeholder="tên quyền..." />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSaveQuyen" runat="server" CssClass="btn btn-success" Text="Lưu" OnClick="btnSaveQuyen_Click" />
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </div>
</asp:Content>
