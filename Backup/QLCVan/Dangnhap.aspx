<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="Dangnhap.aspx.cs" Inherits="QLCVan.Dangnhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="Main.css" rel="stylesheet" type="text/css" />
    <center>
        <br />
        <span><b>
            <h3>
                ĐĂNG NHẬP HỆ THỐNG</h3>
        </b></span>
        <div id="contentLg">
            <div style="height: 100px; width: 150px; padding-top: 30px;">
                <img src="Images/avatar.jpg" />
            </div>
            <div style="width: 250px; height: 38px; margin-top: 30px;">
                <asp:TextBox ID="Username" runat="server" Width="250px" Height="33px" placeholder="Tài khoản"></asp:TextBox>
            </div>
            <div style="width: 250px; height: 38px;">
                <asp:TextBox ID="Password" runat="server" Width="250px" Height="33px" TextMode="Password"
                    placeholder="Mật khẩu"></asp:TextBox>
            </div>
            <div style="width: 254px; height: 38px; margin-top: 15px;">
                <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btnLogin" OnClick="btnLogin_Click" />
            </div>
            <div style="color: Red; width: 254px; margin-top: 15px; margin-left: 2px">
                <asp:Label ID="lbThongbaoLoi" runat="server"></asp:Label>
            </div>
        </div>
    </center>
</asp:Content>
