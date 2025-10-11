<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLNhom.aspx.cs" Inherits="QLCVan.QLNhom" %>

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
    .marquee-banner {
  background-color: #c00;
  color: white;
  overflow: hidden;
  white-space: nowrap;
  padding: 8px 0;
  position: relative;
}

.marquee-banner span {
  display: inline-block;
  padding-left: 100%;
  animation: scroll-left 15s linear infinite;
}

@keyframes scroll-left {
  0% { transform: translateX(0); }
  100% { transform: translateX(-100%); }
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

  </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="cv">
    <div class="cv-head">QUẢN LÝ NHÓM

    </div>

   <div class="marquee">
  <marquee behavior="scroll" direction="left" scrollamount="5">
    Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.
  </marquee>
</div>


    <center>
      <h3 class="section-title"><b>DANH SÁCH ĐƠN VỊ</b></h3>


      <asp:HiddenField ID="hdfID" runat="server" />


      <!-- Khu vực tìm kiếm -->
<div class="mb-4" style="width:48%; margin: 0 auto;">
  <div class="card p-3 border-0">
    <h5 class="mb-3 text-danger fw-bold">Tìm kiếm</h5>
    <div class="row g-2">
      <div class="col-md-6">
        <asp:TextBox ID="txtSearchMa" runat="server" CssClass="form-control" placeholder="Nhập mã đơn vị..." />
      </div>
      <div class="col-md-6">
        <asp:TextBox ID="txtSearchTen" runat="server" CssClass="form-control" placeholder="Nhập tên đơn vị..." />
      </div>
      <div class="col-12 text-end mt-2">
        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-danger px-4" Text="Tìm kiếm" OnClick="btnSearch_Click" />
        <i class="fa fa-search text-white ms-2"></i>
      </div>
    </div>
  </div>
</div>


      <!-- Nút mở popup -->
      <div class="mb-3 text-end" style="width:48%">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
          <i class="fa fa-plus"></i> Thêm đơn vị
        </button>
      </div>

      <!-- GridView hiển thị danh sách đơn vị -->
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
      <ItemTemplate>
        <asp:Label ID="lblMaDonVi" runat="server" Text='<%# Eval("MaDonVi") %>'></asp:Label>
      </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Tên đơn vị">
      <HeaderStyle HorizontalAlign="Center" />
      <ItemTemplate>
        <asp:Label ID="lblTenDonVi" runat="server" Text='<%# Eval("TenDonVi") %>'></asp:Label>
      </ItemTemplate>
      <EditItemTemplate>
        <asp:TextBox ID="txtTenNhom" runat="server" CssClass="form-control"
            Text='<%# Eval("TenDonVi") %>'></asp:TextBox>
      </EditItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Thao tác">
      <HeaderStyle HorizontalAlign="Center" />
      <EditItemTemplate>
        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm">
          <i class="fa fa-check"></i>
        </asp:LinkButton>
        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm">
          <i class="fa fa-times"></i>
        </asp:LinkButton>
      </EditItemTemplate>
      <ItemTemplate>
        <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("MaDonVi") %>'
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

    <!-- Modal thêm đơn vị -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addModalLabel">Thêm đơn vị</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              
              <asp:TextBox ID="txtTenDonVi" runat="server" CssClass="form-control" placeholder="Nhập mã đơn vị..." />
            </div>
            <div class="mb-3">
             
              <asp:TextBox ID="txtMoTaDonVi" runat="server" CssClass="form-control" placeholder="Nhập tên đơn vị..." />
            </div>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Thêm" OnClick="btnSave_Click" />
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </div>
</asp:Content>
