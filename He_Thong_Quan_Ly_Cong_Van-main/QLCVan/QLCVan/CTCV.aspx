<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="CTCV.aspx.cs" Inherits="QLCVan.CTCV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #txtaTrichyeu
        {
            width: 595px;
            height: 80px;
        }
        #txtaButphe
        {
            width: 595px;
            height: 70px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h3>
           
            <b>CHI TIẾT CÔNG VĂN</b></h3>
        <div style="width: 750px; border-radius: 5px;">
            <table style="width: 750px; background-color: #F7F6F3;">
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Tiêu đề :"></asp:Label>
                    </td>
                    <td colspan="6">
                        <asp:TextBox ID="txtTieuDe" runat="server" Width="568px" Height="22px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Số CV :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSoCV" runat="server" Enabled="False"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Tên loại CV :"></asp:Label>
                    </td>
                    <td class="style4">
                        <asp:TextBox ID="txtTenloaiCV" runat="server" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Cơ quan ban hành :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCQBH" runat="server" Width="226px" Enabled="False"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="Người kí :"></asp:Label>
                    </td>
                    <td class="style4">
                        <asp:TextBox ID="txtNguoiki" runat="server" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text="Ngày ban hành :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtNgayBH" runat="server" Enabled="False"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="Ngày nhận :"></asp:Label>
                    </td>
                    <td class="style4">
                        <asp:TextBox ID="txtNgaynhan" runat="server" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text="Bút phê :"></asp:Label>
                    </td>
                    <td colspan="6">
                        <textarea id="txtaButphe" runat="server" 
                            style="width: 568px; min-height: 50px;" enableviewstate="False" visible="True"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="Trích yếu :"></asp:Label>
                    </td>
                    <td colspan="6">
                        <textarea id="txtaTrichyeu" runat="server" style="width: 568px; min-height: 100px;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="txt" runat="server" Text="Tệp đính kèm:"></asp:Label>
                    </td>
                    <td colspan="4">
                        <%#Eval("TenFile")%>
                        </br>
                        <asp:Repeater ID="rptfilecv" runat="server">
                            <ItemTemplate>
                                <a style="text-align: left">
                                    <%#Eval("TenFile")%></a>
                                <asp:Label ID="lblsize" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                <asp:HyperLink runat="server" NavigateUrl='<%# Eval("Url") %>' ID="hpllinkdownload">Tải xuống</asp:HyperLink><br />
                            </ItemTemplate>
                        </asp:Repeater>
                    </td>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text=" Email :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtNguoiNhan" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Cc :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCC" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <a href="QLEmail.aspx" onclick="window.open('QLEmail.aspx', 'popupname','toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=yes,resizable=yes, copyhistory=no,width=300,height=280');return false">
                                Chọn Mail</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="btnGui" runat="server" Text="Gửi mail" OnClick="btnGui_Click" Height="30px"
                                Width="80px" />
                            <asp:Literal ID="lblThongBao" runat="server"></asp:Literal>
                        </td>
                        <td>
                        </td>
                    </tr>
            </table>
        </div>
    </center>
</asp:Content>
