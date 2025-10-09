<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HitCount.ascx.cs" Inherits="QLCVan.UserControl.HitCount" %>
<div>
    <div style="float: left;">
        <img src="Images/counters.gif" style="width: 15px; height: 15px; float: left;" />&nbsp;
        <asp:Label ID="lblHitCount" runat="server" Text="0" ForeColor="#000066">
        </asp:Label></div>
    <div style="float: left; margin-left: 20px;">
        <img src="Images/online.gif" style="width: 15px; height: 15px; float: left;" />&nbsp;
        <asp:Label ID="lblHitOnline" runat="server" Text="0" ForeColor="#000066"></asp:Label></div>
</div>
