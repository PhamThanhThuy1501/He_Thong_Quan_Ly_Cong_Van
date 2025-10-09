<%@ Page Title="Phân quyền nhóm" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="PhanQuyen.aspx.cs" Inherits="QLCVan.PhanQuyen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <style>
    body {
      background-color: #f7f7f7 !important;
      font-family: "Segoe UI", Arial, sans-serif;
    }

    :root { --red: #c00; }

    .cv {
      max-width: 1340px;
      margin: 0 auto;
      padding: 12px 16px;
      background: transparent;
    }

    .cv-head {
      font-size: 20px;
      font-weight: bold;
      color: #003366;
      margin: 6px 0 10px 16px;
    }

    .cv-banner {
      background: var(--red);
      color: #fff;
      height: 30px;
      margin: 0 16px;
      border-radius: 2px;
      display: flex;
      align-items: center;
      justify-content: flex-start;
      padding-left: 20px;
      overflow: hidden;
    }

    .cv-banner .marquee {
      display: inline-block;
      white-space: nowrap;
      animation: scroll-left 12s linear infinite;
      font-size: 15px;
      font-weight: 600;
      color: #fff;
      line-height: 30px;
    }

    .cv-banner:hover .marquee {
      animation-play-state: paused;
    }

    @keyframes scroll-left {
      0% { transform: translateX(100%); }
      100% { transform: translateX(-100%); }
    }

    .section-title {
      margin-top: 20px;
      margin-bottom: 12px;
      font-weight: 700;
      font-size: 26px;
      color: #0f172a;
      text-align: center;
    }

    /* === TÌM KIẾM === */
    .search-block {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 6px;
      margin-bottom: 18px;
    }

    .search-block label {
      font-weight: 700;
      font-size: 20px;
      margin-right: 4px;
      color: #111;
    }

    .search-block input {
      padding: 6px 10px;
      border-radius: 6px;
      border: 1px solid #ddd;
      width: 200px;
    }

    .btn-search {
      width: 36px;
      height: 36px;
      background: var(--red);
      border: none;
      color: #fff;
      border-radius: 4px;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 16px;
    }

    .btn-search:hover {
      background: #a00;
    }

    /* === BẢNG === */
    .table-wrap {
      width: 60%;
      margin: 0 auto 18px;
    }

    /* fix triệt để header đỏ + chữ trắng */
    .permissions-table th {
      background-color: var(--red) !important;
      color: #fff !important;
      text-align: center !important;
      font-weight: 700 !important;
      font-size: 16px !important;
      border-color: #fff !important;
    }

    .permissions-table tbody td {
      vertical-align: middle;
      text-align: center;
      font-size: 15px;
    }

    .btn-assign, .btn-assigned {
      display: inline-block;
      min-width: 68px;
      text-align: center;
      padding: 5px 12px;
      font-weight: 600;
      border: none;
      border-radius: 6px;
      color: #fff;
      cursor: pointer;
    }

    .btn-assign {
      background-color: #007bff;
    }

    .btn-assign:hover {
      background-color: #0069d9;
    }

    .btn-assigned {
      background-color: #adb5bd;
      cursor: default;
      opacity: 0.85;
    }

    /* === PHÂN TRANG NGOÀI BẢNG === */
    .pager-container {
      text-align: center;
      margin-top: 10px;
    }

    .page-link, .active-page {
      display: inline-block;
      margin: 0 4px;
      padding: 8px 14px;
      border: 1px solid #ddd;
      border-radius: 4px;
      text-decoration: none;
      color: #0066cc;
      cursor: pointer;
      font-weight: 600;
    }

    .page-link:hover {
      border-color: var(--red);
      color: var(--red);
    }

    .active-page {
      background: var(--red);
      color: #fff;
      border-color: var(--red);
      font-weight: bold;
    }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="cv">
    <div class="cv-head">QUẢN LÝ NGƯỜI DÙNG</div>

    <div class="cv-banner">
      <div class="marquee">Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</div>
    </div>

    <h3 class="section-title">GÁN QUYỀN CHO NHÓM QUYỀN NHÂN VIÊN</h3>

    <!-- Ô tìm kiếm -->
    <div class="search-block">
      <label>Tìm kiếm</label>
      <asp:TextBox ID="txtTenNhom" runat="server" placeholder="Nhập tên nhóm quyền"></asp:TextBox>
      <asp:TextBox ID="txtMaNhom" runat="server" placeholder="Nhập mã nhóm quyền"></asp:TextBox>
      <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click">
        <i class="fa fa-search"></i>
      </asp:LinkButton>
    </div>

    <asp:HiddenField ID="hdfMaNhom" runat="server" />

    <!-- Bảng dữ liệu -->
    <div class="table-wrap">
      <asp:GridView ID="gvPhanQuyen" runat="server" AutoGenerateColumns="False"
        CssClass="table table-bordered table-hover permissions-table"
        AllowPaging="False"
        OnRowCommand="gvPhanQuyen_RowCommand">
        <Columns>
          <asp:BoundField DataField="MaQuyen" HeaderText="Mã quyền" />
          <asp:BoundField DataField="TenQuyen" HeaderText="Tên quyền" />
          <asp:TemplateField HeaderText="Thao tác">
            <ItemTemplate>
              <asp:LinkButton ID="btnGan" runat="server"
                Text='<%# Convert.ToBoolean(Eval("DaGan")) ? "Đã gán" : "Gán" %>'
                CommandName="GanQuyen"
                CommandArgument='<%# Eval("MaQuyen") %>'
                CssClass='<%# Convert.ToBoolean(Eval("DaGan")) ? "btn-assigned" : "btn-assign" %>'>
              </asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>

    <!-- Phân trang ngoài bảng -->
    <div class="pager-container">
      <asp:Repeater ID="rptPager" runat="server" OnItemCommand="rptPager_ItemCommand">
        <ItemTemplate>
          <asp:LinkButton ID="lnkPage" runat="server" CommandName="Page"
            CommandArgument='<%# Eval("PageIndex") %>'
            Visible='<%# !(bool)Eval("IsCurrentPage") %>'
            CssClass="page-link"
            Text='<%# Eval("PageNumber") %>' />
          <asp:Label ID="lblPage" runat="server" CssClass="active-page"
            Visible='<%# (bool)Eval("IsCurrentPage") %>'
            Text='<%# Eval("PageNumber") %>' />
        </ItemTemplate>
      </asp:Repeater>
    </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
