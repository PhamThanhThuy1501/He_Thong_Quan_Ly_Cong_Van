<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLnguoidung.aspx.cs" Inherits="QLCVan.QLnguoidung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .style4 {
            height: 30px;
        }

        .style7 {
            height: 30px;
        }

        .style8 {
            width: 793px;
        }
    </style>
    <center>
        <div style="width: 960px; background-color: White;">
            <h3>
                <b>
                    <asp:Label ID="Label1" runat="server" Text="QUẢN LÝ NGƯỜI DÙNG"></asp:Label></b></h3>
            <div style="float: left; width: 470px; clear: both;">
                <table style="width: 311px; margin-left: 49px;">
                    <tr>
                        <td style="text-align: right;" class="style4">
                            Mã ND<span style="color: Red">*</span> :
                        </td>
                        <td class="style4">
                            <asp:TextBox ID="txtMaNguoiDung" runat="server" Height="21px" Width="170px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style4">
                            Họ tên <span style="color: Red">*</span>:
                        </td>
                        <td class="style4">
                            <asp:TextBox ID="txtHoTen" runat="server" Width="170px" Height="21px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style4">
                            Email :
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" Width="170px" Height="21px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style4">
                            Quyền :
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlQuyen" runat="server" Width="170px" Height="21px">
                                <asp:ListItem>User</asp:ListItem>
                                <asp:ListItem>Admin</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;">
                            Nhóm :
                        </td>
                        <td>
                            <asp:CheckBoxList ID="cbl1" runat="server" AutoPostBack="True">
                            </asp:CheckBoxList>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="float: left; width: 355px;">
                <table style="width: 351px; margin-left: 24px;">
                    <tr>
                        <td style="text-align: right" class="style4">
                            Tên đăng nhập :
                        </td>
                        <td>
                            <asp:TextBox ID="txtTenDN" runat="server" Width="170px" Height="21px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style7">
                            Mật khẩu <span style="color: Red">*</span> :
                        </td>
                        <td class="style7">
                            <asp:TextBox ID="txtMatkhau" runat="server" Width="170px" TextMode="Password" Height="21px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style4">
                            Xác nhận mật khẩu <span style="color: Red">*</span>:
                        </td>
                        <td class="style4">
                            <asp:TextBox ID="txtMatkhau1" runat="server" Width="170px" TextMode="Password" Height="20px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style4">
                            Trạng thái :
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rblTrangThai" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Hiệu lực</asp:ListItem>
                                <asp:ListItem>Chưa hiệu lực</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
                <asp:Button ID="btnThem" runat="server" Text="Thêm" OnClick="btnThem_Click" Width="70px" />
                <asp:Button ID="btnTaoMoi" runat="server" OnClick="btnTaoMoi_Click" Text="Tạo mới" />
                <br />
                <br />
                <span style="color: Red;">
                    <asp:Literal ID="lblAlert" runat="server"></asp:Literal>
                </span>
                <br />
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <table style="width: 837px">
                        <div style="margin-top: 20px;">
                            <center>
                                <asp:GridView ID="GridView2" runat="server" ShowFooter="True" AllowPaging="True"
                                    AutoGenerateColumns="False" BorderWidth="1px" CellPadding="2" DataKeyNames="MaNguoiDung"
                                    DataSourceID="LinqDataSource2" ForeColor="Black" Width="780px">
                                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                    <Columns>
                                        <asp:BoundField DataField="HoTen" HeaderText="Họ Tên" SortExpression="HoTen" />
                                        <asp:BoundField DataField="TenDN" HeaderText="Tên đăng nhập" SortExpression="TenDN" />
                                        <%-- <asp:BoundField DataField="MatKhau" HeaderText="Mật khẩu" SortExpression="MatKhau"/>--%>
                                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                        <%-- <asp:BoundField DataField="MaNhom" HeaderText="Mã nhóm" SortExpression="MaNhom" />--%>
                                        <%-- <asp:BoundField DataField="TrangThai" HeaderText="Trạng thái" SortExpression="TrangThai" />--%>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                    </Columns>
                                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <SortedAscendingCellStyle BackColor="#FDF5AC" />
                        <SortedAscendingHeaderStyle BackColor="#4D0000" />
                        <SortedDescendingCellStyle BackColor="#FCF6C0" />
                        <SortedDescendingHeaderStyle BackColor="#820000" />
                                </asp:GridView>
                                <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="QLCVan.InfoDataContext"
                                    EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName=""
                                    TableName="tblNguoiDungs">
                                </asp:LinqDataSource>
                                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="QLCVan.InfoDataContext"
                                    EntityTypeName="" Select="new (TenDN, HoTen, Email, TrangThai)" TableName="tblNguoiDungs">
                                </asp:LinqDataSource>
                            </center>
                        </div>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView2" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </center>
</asp:Content>
