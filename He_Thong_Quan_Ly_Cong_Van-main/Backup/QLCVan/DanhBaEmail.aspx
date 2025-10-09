<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="DanhBaEmail.aspx.cs" Inherits="QLCVan.DanhBaEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h3>
            <b>QUẢN LÝ DANH BẠ EMAIL</b></h3>
        <p>
            <asp:HiddenField ID="hdfID" runat="server" />
        </p>
        <%--       <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>--%>
        <asp:GridView ID="gvQLEmail" runat="server" ShowFooter="True" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" DataKeyNames="Email">
            <FooterStyle BackColor="Azure" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Email" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Số lần gửi">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%#Eval("SoLanGui") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <EditRowStyle BackColor="#999999" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="Silver" Font-Bold="True" ForeColor="SteelBlue" />
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        </asp:GridView>
    </center>
</asp:Content>
