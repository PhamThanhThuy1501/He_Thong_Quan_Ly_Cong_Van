<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLNhom1.aspx.cs" Inherits="QLCVan.QLNhom1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CSS + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h3><b>QUẢN LÝ NHÓM</b></h3>
        <asp:HiddenField ID="hdfID" runat="server" />

        <!-- Nút mở popup -->
        <div class="mb-3 text-end" style="width:48%">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                <i class="fa fa-plus"></i> Thêm nhóm
            </button>
        </div>

        <!-- GridView hiển thị danh sách -->
        <asp:GridView ID="gvQLNhom" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" Width="48%"
            DataKeyNames="MaNhom"
            OnRowDeleting="rowDeleting"
            OnRowCancelingEdit="rowCancelingEdit"
            OnRowEditing="rowEditing"
            OnRowUpdating="rowUpdating"
            OnRowCommand="rowCommand"
            CssClass="table table-bordered table-striped table-hover">

            <Columns>
                <asp:TemplateField HeaderText="Mã Nhóm" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("MaNhom") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Tên Nhóm">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%#Eval("MoTa") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTenNhom" runat="server" CssClass="form-control"
                            Text='<%#Eval("MoTa") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thao tác" ItemStyle-HorizontalAlign="Center">
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm">
                            <i class="fa fa-check"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm">
                            <i class="fa fa-times"></i>
                        </asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%#Eval("MaNhom") %>'
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

    <!-- Modal thêm nhóm -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Thêm nhóm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="txtTenNhomMoi" runat="server" CssClass="form-control" placeholder="Nhập tên nhóm..."></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Lưu" OnClick="btnSave_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
