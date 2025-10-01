<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLnguoidung.aspx.cs" Inherits="QLCVan.QLnguoidung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Thêm Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        .style4 { height: 30px; }
        .style7 { height: 30px; }
        .iconBtn {
            border: none;
            background: none;
            cursor: pointer;
            padding: 0 5px;
            font-size: 16px;
        }
        .formTable td { padding: 5px; vertical-align: middle; }
        .formTable input, .formTable select { width: 170px; height: 21px; }
        .gridWrapper { margin-top: 20px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <div style="width: 960px; background-color: White;">
            <h3><b><asp:Label ID="Label1" runat="server" Text="QUẢN LÝ NGƯỜI DÙNG"></asp:Label></b></h3>

            <!-- Form nhập liệu -->
            <div style="float: left; width: 470px; clear: both;">
                <table class="formTable" style="margin-left: 49px;">
                    <tr>
                        <td style="text-align:right;">Mã ND<span style="color:Red">*</span>:</td>
                        <td><asp:TextBox ID="txtMaNguoiDung" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">Họ tên<span style="color:Red">*</span>:</td>
                        <td><asp:TextBox ID="txtHoTen" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">Email:</td>
                        <td><asp:TextBox ID="txtEmail" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">Quyền:</td>
                        <td>
                            <asp:DropDownList ID="ddlQuyen" runat="server">
                                <asp:ListItem>User</asp:ListItem>
                                <asp:ListItem>Admin</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">Nhóm:</td>
                        <td>
                            <asp:CheckBoxList ID="cbl1" runat="server" AutoPostBack="True"></asp:CheckBoxList>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="float: left; width: 355px;">
                <table class="formTable" style="margin-left:24px;">
                    <tr>
                        <td style="text-align:right;">Tên đăng nhập:</td>
                        <td><asp:TextBox ID="txtTenDN" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">Mật khẩu<span style="color:Red">*</span>:</td>
                        <td><asp:TextBox ID="txtMatkhau" runat="server" TextMode="Password"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">Xác nhận mật khẩu<span style="color:Red">*</span>:</td>
                        <td><asp:TextBox ID="txtMatkhau1" runat="server" TextMode="Password"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">Trạng thái:</td>
                        <td>
                            <asp:RadioButtonList ID="rblTrangThai" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Hiệu lực</asp:ListItem>
                                <asp:ListItem>Chưa hiệu lực</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>

                <asp:Button ID="btnThem" runat="server" Text="Thêm" OnClick="btnThem_Click" Width="70px" />
                <asp:Button ID="btnTaoMoi" runat="server" Text="Tạo mới" OnClick="btnTaoMoi_Click" />
                <br /><br />
                <span style="color:red;"><asp:Literal ID="lblAlert" runat="server"></asp:Literal></span>
            </div>

            <div class="gridWrapper" style="clear:both;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                    <ContentTemplate>
                        <asp:GridView ID="GridView2" runat="server" ShowFooter="True" AllowPaging="True"
                            AutoGenerateColumns="False" BorderWidth="1px" CellPadding="2"
                            DataKeyNames="MaNguoiDung"
                            DataSourceID="LinqDataSource2" ForeColor="Black" Width="780px">
                            
                            <AlternatingRowStyle BackColor="PaleGoldenrod" />

                            <Columns>
                                <asp:BoundField DataField="TenDN" HeaderText="Tên đăng nhập" SortExpression="TenDN" />
                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                <asp:BoundField DataField="MaNhom" HeaderText="Nhóm" SortExpression="MaNhom" />
                                
                                <asp:TemplateField HeaderText="Trạng thái">
                                    <ItemTemplate>
                                        <%# (Eval("TrangThai").ToString() == "0") ? "Hiệu lực" : "Chưa hiệu lực" %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Thao tác">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit"
                                            CommandArgument='<%# Eval("MaNguoiDung") %>'
                                            CssClass="iconBtn" ToolTip="Sửa">
                                            <i class="fa fa-edit" style="color:blue;"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                            CommandArgument='<%# Eval("MaNguoiDung") %>'
                                            OnClientClick="return confirm('Bạn có chắc muốn xoá?');"
                                            CssClass="iconBtn" ToolTip="Xóa">
                                            <i class="fa fa-trash" style="color:red;"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>

                        <asp:LinqDataSource ID="LinqDataSource2" runat="server"
                            ContextTypeName="QLCVan.InfoDataContext"
                            EnableDelete="True" EnableInsert="True" EnableUpdate="True"
                            TableName="tblNguoiDungs">
                        </asp:LinqDataSource>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="GridView2" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </center>
</asp:Content>
