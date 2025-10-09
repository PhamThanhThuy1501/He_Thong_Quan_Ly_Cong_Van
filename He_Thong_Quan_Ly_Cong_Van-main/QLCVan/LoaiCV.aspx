<%@ Page Title="Quản lý Loại Công văn" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        .table { border-collapse: collapse; width: 70%; margin: 0 auto; background: #fff; }
        .table th, .table td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        .table th { background-color: #990000; color: #fff; }
        .action-btn { margin: 0 5px; font-size: 16px; cursor: pointer; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h3><b>QUẢN LÝ LOẠI CÔNG VĂN</b></h3>

        <asp:GridView ID="grvLoaiCV" runat="server" ShowFooter="True" AutoGenerateColumns="False"
            CssClass="table" DataKeyNames="MaLoaiCV"
            AllowPaging="True" PageSize="10"
            OnPageIndexChanging="grvLoaiCV_PageIndexChanging"
            OnRowDeleting="rowDeleting" OnRowCancelingEdit="rowCancelingEdit"
            OnRowEditing="rowEditing" OnRowUpdating="rowUpdating">

            <Columns>
                <%-- STT (index) --%>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# (grvLoaiCV.PageIndex * grvLoaiCV.PageSize) + ((GridViewRow)Container).RowIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- Mã Loại (ID thực từ DB) --%>
                <asp:TemplateField HeaderText="Mã Loại">
                    <ItemTemplate>
                        <asp:Label ID="lblMaLoai" runat="server" Text='<%# Eval("MaLoaiCV") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- Tên Loại --%>
                <asp:TemplateField HeaderText="Tên Loại">
                    <ItemTemplate>
                        <asp:Label ID="lblTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtTenLoaiNew" runat="server" CssClass="form-control"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>

                <%-- Thao tác --%>
                <asp:TemplateField HeaderText="Thao tác">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Sửa" CausesValidation="False">
                            <i class="fa fa-edit" style="color:blue;"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Xóa" CausesValidation="False"
                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa loại công văn này không?');">
                            <i class="fa fa-trash" style="color:red;"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Cập nhật" CausesValidation="False">
                            <i class="fa fa-check" style="color:green;"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Hủy" CausesValidation="False">
                            <i class="fa fa-times" style="color:gray;"></i>
                        </asp:LinkButton>
                    </EditItemTemplate>

                    <FooterTemplate>
                        <asp:LinkButton ID="btnAdd" runat="server" ToolTip="Thêm mới"
                            OnClick="btnAdd_Click" CausesValidation="False">
                            <i class="fa fa-plus-circle" style="color:green;"></i>
                        </asp:LinkButton>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </center>
</asp:Content>
