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
                <asp:Label ID="lblxxx" runat="server" Text="xxx"></asp:Label>
            </h3>
        </div>
        <div id="bang">
            <div id="bang1">
                <table>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lbltieude" runat="server" Text="Tiêu đề :"></asp:Label>
                        </td>
                        <td style="height: 10px; text-align: right;">
                            <asp:TextBox ID="txttieude" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblsocv" runat="server" Text="Số công văn :"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:TextBox ID="txtsosv" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblcqbh" runat="server" Text="Cơ quan ban hành :"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:TextBox ID="txtcqbh" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="Label3" runat="server" Text="Gửi hay nhận :"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Nhận</asp:ListItem>
                                <asp:ListItem>Gửi</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblloaicv" runat="server" Text="Loại CV :"></asp:Label>
                        </td>
                        <td>
                            <asp:ComboBox ID="cboLoaiCongvan" runat="server" AutoCompleteMode="SuggestAppend"
                                CaseSensitive="True" CssClass="" ItemInsertLocation="Append" AppendDataBoundItems="False"
                                OnItemInserting="cboLoaiCongvan_ItemInserting" Width="131px">
                            </asp:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblngayracv" runat="server" Text="Ngày ra CV:"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:TextBox ID="txtngayracv" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblngaynhancv" runat="server" Text="Ngày nhận CV:"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:TextBox ID="txtngaynhancv" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblnguoiky" runat="server" Text="Người ký ban hành CV:"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:ComboBox ID="cboNguoiKy" runat="server" AutoCompleteMode="SuggestAppend" CaseSensitive="True"
                                CssClass="" ItemInsertLocation="Append" AppendDataBoundItems="False" Width="131px"
                                OnItemInserted="cboNguoiKy_ItemInserted">
                            </asp:ComboBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="bang2">
                <table>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lbltrichyeund" runat="server" Text="Trích yếu NDCV:"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <textarea id="txttrichyeu" runat="server" style="width: 400px; height: 50px;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblnoinhan" runat="server" Text="Nơi nhận :"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <textarea id="txtnoinhan" runat="server" rows="2" style="width: 400px;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblbutphe" runat="server" Text="Bút phê LĐ:"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <textarea id="txtbutphe" runat="server" style="width: 400px;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblghichu" runat="server" Text="Ghi chú :"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <textarea id="txtghichu" runat="server" style="width: 400px;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="lblloi" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblchuachonfile" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            <asp:Label ID="txt" runat="server" Text="Tệp đính kèm:"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:ListBox ID="ListBox1" runat="server" Height="50px" Width="400px"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="btnUp" runat="server" Text="Tải lên" OnClick="btnUp_Click" />
                            <asp:Button ID="btnRemove" runat="server" Text="Xóa" OnClick="btnRemove_Click" />
                            <asp:Button ID="btnReAll" runat="server" Text="Xóa hết" OnClick="btnReAll_Click" />
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="btn">
            <center>
                <asp:Button ID="btnthem" runat="server" Text="Thêm" Height="30px" Width="100px" OnClick="btnthem_Click" />
                <asp:Button ID="btnlammoi" runat="server" Text="Làm mới" Height="30px" Width="100px"
                    OnClick="btnlammoi_Click" />
                <asp:Button ID="btnsua" runat="server" Text="Sửa" Height="30px" Width="100px" OnClick="btnsua_Click" />
            </center>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>
                <div id="gv">
                    <asp:GridView ID="gvnhapcnden" runat="server" ShowFooter="True" AutoGenerateColumns="False"
                        CellPadding="4" Width="100%" AllowPaging="True" OnPageIndexChanging="gvnhapcnden_PageIndexChanging"
                        PageSize="3" ForeColor="#333333" OnSelectedIndexChanged="gvnhapcnden_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="SoCV" HeaderText="Số CV" SortExpression="SoCV">
                                <ItemStyle Width="90px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TieudeCV" HeaderText="Tiêu đề" SortExpression="TieuDeCV">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TenLoaiCV" HeaderText="Loại công văn" SortExpression="TenLoaiCV">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NgayGui" HeaderText="Ngày gửi" SortExpression="Ngaygui"
                                DataFormatString="{0:dd-MM-yyyy}">
                                <ItemStyle Width="90px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TrichYeuND" HeaderText="Trích yếu ND" SortExpression="TrichYeuND">
                                <ItemStyle Width="360px" />
                            </asp:BoundField>
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
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <EditRowStyle BackColor="#999999" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="Silver" Font-Bold="True" ForeColor="SteelBlue" />
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="gvnhapcnden" />
            </Triggers>
        </asp:UpdatePanel>
    </center>
</asp:Content>
