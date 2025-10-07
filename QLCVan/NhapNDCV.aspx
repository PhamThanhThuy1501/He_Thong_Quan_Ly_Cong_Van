<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="NhapNDCV.aspx.cs" Inherits="QLCVan.NhapNDCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        body {
            color: #000;
            font-family: Arial, sans-serif;
        }

        /* ========== FORM NHẬP ========= */
        .form-container {
            margin: 28px auto 10px;
            padding: 16px 18px;
            max-width: 940px;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            background: #fafafa;
        }

            .form-container h3 {
                text-align: center;
                margin: 2px 0 14px;
                color: #222;
                letter-spacing: .5px;
            }

        .tbSend {
            width: 100%;
            border-collapse: collapse;
        }

            .tbSend tr {
                border-bottom: 1px solid #eee;
            }

            .tbSend td {
                padding: 8px;
                vertical-align: middle;
            }

                .tbSend td.label {
                    width: 180px;
                    text-align: right;
                    padding-right: 12px;
                    color: #222;
                    white-space: nowrap;
                    font-weight: 600;
                }

            .tbSend .inputCell {
                width: calc(100% - 180px);
            }

            .tbSend input[type="text"],
            .tbSend textarea,
            .tbSend select {
                width: 100%;
                box-sizing: border-box;
                padding: 8px 10px;
                border: 1px solid #bdbdbd;
                border-radius: 6px;
                background: #fff;
            }

            .tbSend textarea {
                resize: vertical;
                min-height: 76px;
            }

        .note-red {
            color: #d32f2f;
        }

        /* ========== BUTTON ========= */
        .btnRe,
        .btnRe:link,
        .btnRe:visited {
            display: inline-block;
            padding: 7px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            border: 1px solid #0b57d0;
            background: #0b57d0 !important;
            color: #fff !important;
            text-decoration: none !important;
        }

            .btnRe:hover {
                filter: brightness(1.06);
            }

            .btnRe:active {
                background: #0949ae !important;
                border-color: #0949ae;
            }

            .btnRe:disabled {
                opacity: .6;
                cursor: not-allowed;
            }

        .btnRe-sm {
            padding: 5px 10px;
            font-size: 12px;
        }

        .filebar,
        .file-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .file-buttons,
        .form-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        /* ========== GRIDVIEW ========= */
        .grid-wrap {
            width: 100%;
            margin: 18px auto 32px;
        }

        .grid-title {
            text-align: center;
            font-weight: 700;
            font-size: 22px;
            margin: 6px 0 12px;
            letter-spacing: .8px;
        }

        #gvnhapcnden {
            width: 100% !important;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
        }

            #gvnhapcnden th {
                background: #f4f6f8 !important;
                font-weight: 700 !important;
                text-transform: uppercase;
                padding: 12px;
                text-align: left;
                font-size: 14px;
                border-bottom: 2px solid #dcdcdc;
                color: #333 !important;
            }

            #gvnhapcnden td {
                padding: 16px 12px;
                font-size: 14px;
                vertical-align: top;
                border-bottom: 1px solid #ececec;
                color: #333;
            }

            /* Hover */
            #gvnhapcnden tr:hover {
                background: #f8f9fa;
            }

    /* Cột 1 và 2 */
    #gvnhapcnden td:first-child {
        width: 18%;
        font-weight: 600;
    }

    #gvnhapcnden td:nth-child(2) {
        width: 15%;
    }

    /* Cột trích yếu */
    #gvnhapcnden td:nth-child(3) {
        width: 67%;
    }

    .vb-summary {
        margin-bottom: 6px;
        line-height: 1.5;
    }

    .vb-attach {
        font-size: 13px;
        color: #0073e6;
    }

        .vb-attach i {
            margin-right: 6px;
            color: #d9534f;
        }

        .vb-attach a {
            text-decoration: none;
        }

            .vb-attach a:hover {
                text-decoration: underline;
            }

    /* ========== RESPONSIVE ========= */
    @media (max-width:720px) {
        .tbSend td.label {
            display: block;
            width: 100%;
            text-align: left;
            padding-bottom: 4px;
        }

        .tbSend td.inputCell {
            display: block;
            width: 100%;
        }

        .tbSend tr {
            display: block;
            margin-bottom: 10px;
        }

        .file-buttons,
        .form-buttons {
            flex-direction: column;
            gap: 8px;
        }

        .file-actions {
            justify-content: stretch;
        }
    }
</style>

    <script src="Scripts/datepicker/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Scripts/datepicker/jquery-ui.js" type="text/javascript"></script>
    <link href="Scripts/datepicker/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script type="text/javascript">
        jQuery(function ($) {
            $.datepicker.regional['vi'] = {
                closeText: 'Đóng', prevText: '&#x3c;Trước', nextText: 'Tiếp&#x3e;', currentText: 'Hôm nay',
                monthNames: ['Tháng Một', 'Tháng Hai', 'Tháng Ba', 'Tháng Tư', 'Tháng Năm', 'Tháng Sáu', 'Tháng Bảy', 'Tháng Tám', 'Tháng Chín', 'Tháng Mười', 'Th.Mười Một', 'Th.Mười Hai'],
                monthNamesShort: ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12'],
                dayNames: ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'],
                dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                weekHeader: 'Tu', dateFormat: 'dd/mm/yy', firstDay: 0, isRTL: false, showMonthAfterYear: false, yearSuffix: ''
            };
            $.datepicker.setDefaults($.datepicker.regional['vi']);
            $('#<%= txtngayracv.ClientID %>').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
        $('#<%= txtngaynhancv.ClientID %>').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
        });
    </script>

    <!-- FORM -->
    <div class="form-container">
        <h3>
            <asp:Label ID="lbl1" runat="server" Text="NHẬP NỘI DUNG CÔNG VĂN"></asp:Label></h3>
        <table id="tableSoan" class="tbSend" runat="server" border="0" cellpadding="0" cellspacing="5">
            <tr>
                <td class="label">Tiêu đề :</td>
                <td class="inputCell" colspan="3">
                    <asp:TextBox ID="txttieude" CssClass="txtSoanCV" runat="server" placeholder="Nhập tiêu đề văn bản..." />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txttieude" ErrorMessage="* Nhập tiêu đề" CssClass="note-red" />
                </td>
            </tr>
            <tr>
                <td class="label">Số công văn :</td>
                <td class="inputCell">
                    <asp:TextBox ID="txtsocv" CssClass="txtSoanCV" runat="server" placeholder="VD: 334/TB-ĐHSPKTHY" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtsocv" ErrorMessage="* Nhập số công văn" CssClass="note-red" />
                </td>
                <td class="label">Cơ quan ban hành :</td>
                <td class="inputCell">
                    <asp:TextBox ID="txtcqbh" CssClass="txtSoanCV" runat="server" placeholder="Tên cơ quan ban hành" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtcqbh" ErrorMessage="* Nhập cơ quan ban hành" CssClass="note-red" />
                </td>
            </tr>
            <tr>
                <td class="label">Loại công văn :</td>
                <td class="inputCell">
                    <asp:DropDownList ID="ddlLoaiCV" runat="server" AutoPostBack="True">
                        <asp:ListItem Text="-- Chọn loại --" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlLoaiCV" InitialValue="" ErrorMessage="* Chọn loại công văn" CssClass="note-red" />
                </td>
                <td class="label">Gửi hay nhận :</td>
                <td class="inputCell">
                    <div class="inline-flex">
                        <div class="rbl">
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Selected="True" Value="Nhận">Nhận</asp:ListItem>
                                <asp:ListItem Value="Gửi">Gửi</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">Ngày ban hành :</td>
                <td class="inputCell">
                    <asp:TextBox ID="txtngayracv" runat="server" placeholder="dd/mm/yyyy" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtngayracv" ErrorMessage="* Nhập ngày ban hành" CssClass="note-red" />
                </td>
                <td class="label">Ngày hết hạn :</td>
                <td class="inputCell">
                    <asp:TextBox ID="txtngaynhancv" runat="server" placeholder="dd/mm/yyyy" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtngaynhancv" ErrorMessage="* Nhập ngày hết hạn" CssClass="note-red" />
                </td>
            </tr>
            <tr>
                <td class="label">Trích yếu :</td>
                <td class="inputCell" colspan="3">
                    <textarea id="txttrichyeu" runat="server" rows="4" placeholder="Tóm tắt nội dung văn bản..."></textarea>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txttrichyeu" ErrorMessage="* Nhập trích yếu" CssClass="note-red" />
                </td>
            </tr>
            <!-- Hàng 1: File (nếu có) -->
            <tr>
                <td class="label">File (nếu có) :</td>
                <td class="inputCell" colspan="3">
                    <div class="filebar">
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:Button ID="Button1" runat="server" CssClass="btnRe" Text="Upload" OnClick="btnUp_Click" CausesValidation="False" />
                        <asp:Label ID="lblchuachonfile" runat="server" Text="" CssClass="note-gray"></asp:Label>
                    </div>
                </td>
            </tr>
            <!-- Hàng 2: Danh sách file (gọn, canh phải nút) -->
            <tr>
                <td class="label">Danh sách file :</td>
                <td class="inputCell" colspan="3">
                    <div class="filelist">
                        <asp:ListBox ID="ListBox1" runat="server" Width="100%" Height="140px" />
                        <div class="file-actions">
                            <asp:Button ID="btnRemove" runat="server" CssClass="btnRe btnRe-sm" Text="Xóa file" OnClick="btnRemove_Click" CausesValidation="False" />
                            <asp:Button ID="btnReAll" runat="server" CssClass="btnRe btnRe-sm" Text="Xóa tất cả file" OnClick="btnReAll_Click" CausesValidation="False" />
                        </div>
                    </div>
                    <asp:Label ID="lblloi" runat="server" Text="" CssClass="note-red" Style="display: block; margin-top: 6px;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: center; padding-top: 14px;">
                    <div class="form-buttons" style="justify-content: center;">
                        <asp:Button ID="btnthem" runat="server" CssClass="btnRe" Text="Thêm" OnClick="btnthem_Click" CausesValidation="True" />
                        <asp:Button ID="btnlammoi" runat="server" CssClass="btnRe" Text="Làm mới" OnClick="btnlammoi_Click" CausesValidation="False" />
                        <asp:Button ID="btnsua" runat="server" CssClass="btnRe" Text="Lưu" OnClick="btnsua_Click" CausesValidation="True" />
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <!-- GRID -->
    <div class="grid-wrap">
        <div class="grid-title">TẤT CẢ CÁC CÔNG VĂN</div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:GridView ID="gvnhapcnden" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="vb-table"
                    CellPadding="4"
                    Width="100%"
                    AllowPaging="True"
                    PageSize="4"
                    OnPageIndexChanging="gvnhapcnden_PageIndexChanging"
                    OnSelectedIndexChanged="gvnhapcnden_SelectedIndexChanged"
                    GridLines="None">

                    <AlternatingRowStyle BackColor="White" />

                    <Columns>
                        <asp:TemplateField HeaderText="Số công văn">
                            <ItemTemplate>
                                <%# Eval("SOCV") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tiêu đề">
                            <ItemTemplate>
                                <%# Eval("TieudeCV") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Loại công văn">
                            <ItemTemplate>
                                <%# Eval("TenLoaiCV") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Ngày ban hành">
                            <ItemTemplate>
                                <%# Eval("NgayGui", "{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Trích yếu ND">
                            <ItemTemplate>
                                <div class="vb-summary"><%# Eval("TrichYeuND") %></div>
                                <div class="vb-attach">
                                    <i class="fa fa-file-pdf-o"></i>
                                    <a href="#">Tài liệu đính kèm</a>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sửa" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_Sua" runat="server"
                                    CausesValidation="False"
                                    OnClick="lnk_Sua_Click"
                                    CommandArgument='<%# Eval("MaCV") %>'>
                                Sửa
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Xóa" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_Xoa" runat="server"
                                    CausesValidation="False"
                                    OnClick="lnk_Xoa_Click"
                                    OnClientClick="return confirm('Bạn có chắc chắn muốn xóa công văn này không?')"
                                    CommandArgument='<%# Eval("MaCV") %>'>
                                Xóa
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                </asp:GridView>
            </ContentTemplate>

            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="gvnhapcnden" EventName="PageIndexChanging" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
