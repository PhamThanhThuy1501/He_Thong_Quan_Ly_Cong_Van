<%@ Page Title="Phân quyền động" Language="C#" MasterPageFile="~/QLCV.master" AutoEventWireup="true" CodeBehind="PhanQuyen.aspx.cs" Inherits="QLCVan.PhanQuyen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Phân quyền động</h2>

    <asp:DropDownList ID="ddlNguoiDung" runat="server" AutoPostBack="true" 
        OnSelectedIndexChanged="ddlNguoiDung_SelectedIndexChanged">
    </asp:DropDownList>

    <br /><br />

    <asp:GridView ID="gvQuyen" runat="server" AutoGenerateColumns="False" DataKeyNames="MaQuyen">
        <Columns>
            <asp:BoundField DataField="TenQuyen" HeaderText="Tên quyền" />
            <asp:TemplateField HeaderText="Được cấp">
                <ItemTemplate>
                    <asp:CheckBox ID="chkQuyen" runat="server" Checked='<%# Eval("DuocCap") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <br />
    <asp:Button ID="btnLuu" runat="server" Text="Lưu thay đổi" OnClick="btnLuu_Click" />
</asp:Content>
