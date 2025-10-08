<%@ Page Title="Quản lý Loại Công văn" Language="C#" MasterPageFile="~/QLCV.Master"
    AutoEventWireup="true" CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 + Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
        h3 {
            text-transform: uppercase;
            color: #990000;
            margin-top: 20px;
        }
        .table {
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .action-btn {
            font-size: 18px;
            margin: 0 6px;
            cursor: pointer;
        }
        .modal-header {
            background-color: #990000;
            color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3><b>QUẢN LÝ LOẠI CÔNG VĂN</b></h3>
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addModal">
                <i class="fa fa-plus-circle"></i> Thêm mới
            </button>
        </div>

        <asp:GridView ID="grvLoaiCV" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered text-center"
            ShowFooter="False" DataKeyNames="MaLoaiCV" AllowPaging="True" PageSize="10"
            OnPageIndexChanging="grvLoaiCV_PageIndexChanging"
            OnRowDeleting="rowDeleting" OnRowCancelingEdit="rowCancelingEdit"
            OnRowEditing="rowEditing" OnRowUpdating="rowUpdating">
            <Columns>
               
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# (grvLoaiCV.PageIndex * grvLoaiCV.PageSize) + ((GridViewRow)Container).RowIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>

              
                <asp:BoundField DataField="MaLoaiCV" HeaderText="Mã Loại" ReadOnly="True" />

              
                <asp:TemplateField HeaderText="Tên Loại">
                    <ItemTemplate>
                        <asp:Label ID="lblTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thao tác">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Sửa" CssClass="action-btn text-primary">
                            <i class="fa fa-edit"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Xóa" CssClass="action-btn text-danger"
                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa loại công văn này không?');">
                            <i class="fa fa-trash"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="action-btn text-success">
                            <i class="fa fa-check"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="action-btn text-secondary">
                            <i class="fa fa-times"></i>
                        </asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <!-- Modal thêm loại công văn -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Thêm Loại Công Văn Mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="txtMaLoaiNew" class="form-label">Mã loại công văn</label>
                        <asp:TextBox ID="txtMaLoaiNew" runat="server" CssClass="form-control" placeholder="Nhập mã loại công văn..."></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtTenLoaiNew" class="form-label">Tên loại công văn</label>
                        <asp:TextBox ID="txtTenLoaiNew" runat="server" CssClass="form-control" placeholder="Nhập tên loại công văn..."></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-success" Text="Thêm"
                        OnClick="btnAdd_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Script Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
