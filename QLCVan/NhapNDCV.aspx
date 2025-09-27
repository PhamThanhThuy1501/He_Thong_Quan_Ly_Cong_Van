<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="NhapNDCV.aspx.cs" Inherits="QLCVan.NhapNDCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <style type="text/css">
            .ajax__combobox_itemlist
            {
                left: 152px !important;
                width: 155px !important;
                top: 225px !important;
            }
            body
            {
                color: black;
            }
            #bang
            {
            }
            #bang1
            {
                float: left;
                height: 300px;
            }
            #bang2
            {
                margin-top: 0px;
                margin-left: 20px;
                float: left;
                height: 300px;
            }
            #btn
            {
                margin-top: 20px;
                padding-right: 10px;
                height: 100px;
                position: absolute;
                top: 360px;
                left: 220px;
            }
            #gv
            {
                position: absolute;
                top: 440px;
            }
        </style>
        <script src="Scripts/datepicker/jquery-1.10.2.js" type="text/javascript"></script>
        <script src="Scripts/datepicker/jquery-ui.js" type="text/javascript"></script>
        <link href="Scripts/datepicker/jquery-ui.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
            jQuery(function ($) {
                $.datepicker.regional['vi'] = {
                    closeText: 'Đóng',
                    prevText: '&#x3c;Trước',
                    nextText: 'Tiếp&#x3e;',
                    currentText: 'Hôm nay',
                    monthNames: ['Tháng Một', 'Tháng Hai', 'Tháng Ba', 'Tháng Tư', 'Tháng Năm', 'Tháng Sáu',
            'Tháng Bảy', 'Tháng Tám', 'Tháng Chín', 'Tháng Mười', 'Th.Mười Một', 'Th.Mười Hai'],
                    monthNamesShort: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
            'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                    dayNames: ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'],
                    dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                    dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                    weekHeader: 'Tu',
                    dateFormat: 'dd/mm/yy',
                    firstDay: 0,
                    isRTL: false,
                    showMonthAfterYear: false,
                    yearSuffix: ''
                };
                $.datepicker.setDefaults($.datepicker.regional['vi']);
            });

            $(document).ready(function () {
                $('#ContentPlaceHolder1_txtngayracv').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
                $('#ContentPlaceHolder1_txtngaynhancv').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
            });
        </script>
        <div style="color: Black; height: 50px; margin-top: 20px; text-align: center;">
            <h3>
                <asp:Label ID="lbl1" runat="server" Text="NHẬP NỘI DUNG CÔNG VĂN"></asp:Label>
            </h3>
        </div>
        <table id="tableSoan" class="tbSend" runat="server" border="0" cellpadding="0" cellspacing="5">
            <tr>
                <td style="border: none; text-align: left">
                    Tiêu đề :
                </td>
                <td colspan="3">
                    <asp:TextBox ID="txttieude" CssClass="txtSoanCV" runat="server" Height="18px" Width="550px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Số công văn :
                </td>
                <td>
                    <asp:TextBox ID="txtsocv" CssClass="txtSoanCV" Height="18px" Width="160px" runat="server"></asp:TextBox>
                </td>
                <td>
                    Cơ quan ban hành :
                </td>
                <td>
                    <asp:TextBox ID="txtcqbh" CssClass="txtSoanCV" Height="18px" Width="170px" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Loại công văn :
                </td>
                <td>
                    <asp:DropDownList Width="165px" Height="25px" ID="ddlLoaiCV" runat="server" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
                <td class="style1">
                    Gửi hay nhận :
                </td>
                <td class="style2">
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem>Nhận</asp:ListItem>
                        <asp:ListItem>Gửi</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    Ngày ban hành :
                </td>
                <td class="style2">
                    <asp:TextBox ID="txtngayracv" Height="18px" Width="160px" runat="server"></asp:TextBox>
                </td>
                <td class="style1">
                    Ngày hết hạn :
                </td>
                <td class="style2">
                    <asp:TextBox ID="txtngaynhancv" Height="18px" Width="170px" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    Trích yếu :
                </td>
                <td colspan="3" style="text-align: left">
                    <textarea id="txttrichyeu" runat="server" rows="4" style="width: 550px"></textarea>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    File (nếu có) :
                </td>
                <td style="text-align: left">
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </td>
                <td>
                    <asp:Button ID="btnUp" runat="server" CssClass="btnRe" Text="Upload" OnClick="btnUp_Click" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td rowspan="2" style="text-align: left">
                    <asp:ListBox ID="ListBox1" runat="server" Width="220px" Height="90px"></asp:ListBox>
                </td>
                <td>
                    <asp:Button ID="btnRemove" runat="server" CssClass="btnRe" Text="Xóa file" OnClick="btnRemove_Click" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="btnReAll" runat="server" CssClass="btnRe" Text="Xóa tất cả files"
                        OnClick="btnReAll_Click" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:Label ID="lblloi" runat="server" Text=""></asp:Label>
                    <asp:Label ID="lblchuachonfile" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td colspan="3">
                    <asp:Button ID="btnthem" runat="server" CssClass="btnRe" Text="Thêm" OnClick="btnthem_Click" />
                    <asp:Button ID="btnlammoi" runat="server" CssClass="btnRe" Text="Làm mới" OnClick="btnlammoi_Click" />
                    <span>
                        <asp:Button ID="btnsua" runat="server" CssClass="btnRe" Text="Sủa" OnClick="btnsua_Click" />
                    </span>
                </td>
            </tr>
        </table>
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>
                <div id="gv">
                    <asp:GridView ID="gvnhapcnden" runat="server" ShowFooter="True" AutoGenerateColumns="False"
                        CellPadding="4" Width="100%" AllowPaging="True" OnPageIndexChanging="gvnhapcnden_PageIndexChanging"
                        PageSize="4" ForeColor="#333333" OnSelectedIndexChanged="gvnhapcnden_SelectedIndexChanged" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="SOCV" HeaderText="Số công văn" SortExpression="SoCV">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TieudeCV" HeaderText="Tiêu đề" SortExpression="TieuDeCV">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TenLoaiCV" HeaderText="Loại công văn" SortExpression="TenLoaiCV">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NgayGui" HeaderText="Ngày ban hành" SortExpression="Ngaygui"
                                DataFormatString="{0:dd-MM-yyyy}">
                                <ItemStyle Width="90px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TrichYeuND" HeaderText="Trích yếu ND" SortExpression="TrichYeuND">
                                <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <%--<asp:TemplateField HeaderText="Trạng Thái">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# kttrangthai(Eval("TrangThai")) %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="80px" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Sửa" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnk_Sua" runat="server" OnClick="lnk_Sua_Click" CommandArgument='<%# Eval("MaCV") %>'>Sửa</asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xóa" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnk_Xoa" runat="server" OnClick="lnk_Xoa_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa thông tin nhóm đã tạo không?')"
                                        CommandArgument='<%# Eval("Macv") %>'>Xóa</asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="30px" />
                            </asp:TemplateField>
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
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="gvnhapcnden" />
            </Triggers>
        </asp:UpdatePanel>
    </center>
</asp:Content>
