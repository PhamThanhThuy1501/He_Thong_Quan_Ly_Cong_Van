<%--<%@ Page MasterPageFile="~/QLCV.Master" Language="C#" AutoEventWireup="true"
    CodeBehind="WebView.aspx.cs" Inherits="QLCVan.WebView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <iframe id="fileFrame" runat="server" width="100%" height="700px"></iframe>
</asp:Content>--%>

<%@ Page Title="WebView" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true" CodeBehind="WebView.aspx.cs" Inherits="QLCVan.WebView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Literal ID="ltMsg" runat="server" />
    <iframe id="iframeDoc" runat="server" width="100%" height="800px" frameborder="0"></iframe>
</asp:Content>
