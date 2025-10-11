<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="NhapNDCV.aspx.cs" Inherits="QLCVan.NhapNDCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        /* Reset cơ bản và font */
        body {
            font-family: Arial, sans-serif;
            color: #333;
            background-color: #f0f2f5;
        }

        /* Container chính của form */
        .form-container {
            margin: 40px auto;
            padding: 30px;
            max-width: 900px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .form-title {
            text-align: center;
            font-weight: 700;
            font-size: 24px;
            margin-bottom: 25px;
            color: #222;
        }

        /* Bố cục form sử dụng Grid */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px 30px;
        }

        /* Các trường nhập liệu */
        .form-field {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* Trường chiếm toàn bộ chiều rộng */
        .form-field-full-width {
            grid-column: 1 / -1;
        }

            /* Container cho các trường full-width */
            .form-field-full-width .form-field-inner {
                display: flex;
                align-items: center;
                width: 100%;
                gap: 15px;
            }

            .form-field-full-width .form-label {
                width: 120px;
                flex-shrink: 0;
                text-align: right;
            }

        /* Label */
        .form-label {
            font-weight: 600;
            color: #555;
            flex-shrink: 0;
            width: 120px;
            text-align: right;
        }

        /* Input và Select */
        .form-input-control {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            box-sizing: border-box;
            background: #f9f9f9;
            transition: all 0.2s ease-in-out;
        }

            .form-input:focus,
            .form-select:focus,
            .form-textarea:focus {
                outline: none;
                border-color: #0b57d0;
                box-shadow: 0 0 0 2px rgba(11, 87, 208, 0.2);
                background: #fff;
            }

        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }

        /* DropDownList mặc định */
        .form-select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="%23333" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 14px center;
        }

        /* Radio buttons */
        .radio-group {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .radio-list td {
            padding: 0;
            white-space: nowrap;
        }

        .radio-list label {
            margin-right: 20px;
        }

        /* File upload */
        .file-upload-row {
            display: flex;
            align-items: center;
            width: 100%;
            gap: 15px;
        }

        .file-upload-main-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .file-upload-custom {
            display: flex;
            align-items: center;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

            .file-upload-custom input[type="file"] {
                display: none;
            }

            .file-upload-custom label {
                background-color: #e8e8e8;
                color: #202124;
                border-right: 1px solid #dcdcdc;
                padding: 8px 16px;
                border-radius: 8px 0 0 8px;
                cursor: pointer;
                font-weight: 600;
            }

                .file-upload-custom label:hover {
                    background-color: #d4d4d4;
                }

        .file-chosen-text {
            padding: 0 12px;
            color: #777;
        }

        /* Tệp đính kèm */
        .file-list-full-width {
            grid-column: 1 / -1;
        }

        /* Nút */
        .btn {
            display: inline-block;
            padding: 10px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease-in-out;
            border: none;
        }

        .btn-primary {
            background-color: #0b57d0;
            color: #fff;
        }

            .btn-primary:hover {
                background-color: #0949ae;
            }

        .btn-quaylai {
            background-color: #dadce0;
            color: #202124;
        }

            .btn-quaylai:hover {
                background-color: #c0c4c8;
            }

        /* Hàng nút form chính */
        .form-buttons {
            grid-column: 1 / -1;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 25px;
        }

        .note-red {
            color: #d32f2f;
            font-size: 12px;
            margin-top: 5px;
        }

        .content-header {
            width: 90%;
            margin: 0 auto 10px auto;
            background-color: #ffffff;
            padding: 10px 20px;
            box-sizing: border-box;
            border-bottom: 1px solid #eee;
        }

        .content-header-title {
            color: #007bff;
            font-size: 18px;
            font-weight: bold;
            margin: 0;
        }

        .welcome-bar {
            width: 90%;
            margin: 0 auto 25px auto;
            background-color: #c00000;
            color: white;
            padding: 8px;
            box-sizing: border-box;
            font-size: 14px;
        }
        /* Tệp đính kèm */
        .file-list-full-width {
            grid-column: 1 / -1;
        }

        .file-list-row {
            display: flex;
            align-items: flex-start;
            width: 100%;
            gap: 15px;
        }

        .file-list-control-container {
            display: flex;
            flex-grow: 1;
            align-items: flex-end;
            gap: 10px;
        }

        .form-listbox {
            width: 100%;
            height: 100px;
        }



        /* Styles cho phần TẤT CẢ CÁC CÔNG VĂN (giữ nguyên) */
        /* ... Các style của grid cũ ... */
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
            $('#<%= txtngaybanhanh.ClientID %>').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
            $('#<%= txtngaygui.ClientID %>').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
        });
    </script>

    <div class="content-header">
        <h2 class="content-header-title">NHẬP NỘI DUNG CÔNG VĂN </h2>
    </div>
    <div class="welcome-bar">
        <marquee behavior="scroll" direction="left">Chào mừng bạn đến với hệ thống Quản lý Công văn điện tử.</marquee>
    </div>


    <div class="form-container">
        <h3 class="form-title">THÊM MỚI CÔNG VĂN</h3>

        <div class="form-grid">
            <div class="form-field-full-width">
                <div class="form-field-inner">
                    <asp:Label ID="lblTieuDe" runat="server" Text="Tiêu đề:" CssClass="form-label"></asp:Label>
                    <div class="form-input-control">
                        <asp:TextBox ID="txttieude" CssClass="form-input" runat="server" placeholder="Nhập vào tiêu đề" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txttieude" ErrorMessage="* Nhập tiêu đề" CssClass="note-red" />
                    </div>
                </div>
            </div>

            <div class="form-field">
                <asp:Label ID="lblSoCV" runat="server" Text="Số CV:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:TextBox ID="txtsocv" CssClass="form-input" runat="server" placeholder="Nhập vào số công văn" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtsocv" ErrorMessage="* Nhập số công văn" CssClass="note-red" />
                </div>
            </div>
            <div class="form-field">
                <asp:Label ID="lblLoaiCV" runat="server" Text="Loại công văn:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:DropDownList ID="ddlLoaiCV" runat="server" AutoPostBack="True" CssClass="form-select">
                        <asp:ListItem Text="-- Chọn loại công văn  --" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlLoaiCV" InitialValue="" ErrorMessage="* Chọn công văn" CssClass="note-red" />
                </div>
            </div>

            <div class="form-field">
                <asp:Label ID="lblNgayBanHanh" runat="server" Text="Ngày ban hành:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:TextBox ID="txtngaybanhanh" runat="server" CssClass="form-input" placeholder="dd/mm/yyyy" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtngaybanhanh" ErrorMessage="* Nhập ngày ban hành" CssClass="note-red" />
                </div>
            </div>
            <div class="form-field">
                <asp:Label ID="lblNgayGui" runat="server" Text="Ngày gửi:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:TextBox ID="txtngaygui" runat="server" CssClass="form-input" placeholder="dd/mm/yyyy" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtngaygui" ErrorMessage="* Nhập ngày gửi" CssClass="note-red" />
                </div>
            </div>

            <div class="form-field">
                <asp:Label ID="lblCoQuanBanHanh" runat="server" Text="Cơ quan ban hành:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:TextBox ID="txtcqbh" CssClass="form-input" runat="server" placeholder="Chọn cơ quan ban hành" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtcqbh" ErrorMessage="* Nhập cơ quan ban hành" CssClass="note-red" />
                </div>
            </div>
            <div class="form-field">
                <asp:Label ID="lblDonViNhan" runat="server" Text="Đơn vị nhận:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:DropDownList ID="ddlDonViNhan" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Chọn đơn vị nhận --" Value="" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-field">
                <asp:Label ID="lblNguoiKy" runat="server" Text="Người ký:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:TextBox ID="txtNguoiKy" CssClass="form-input" runat="server" placeholder="Nhập người ký" />
                </div>
            </div>
            <div class="form-field">
                <asp:Label ID="lblBaoMat" runat="server" Text="Bảo mật:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <div class="radio-group">
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" CssClass="radio-list" CellSpacing="20">
                            <asp:ListItem Selected="True" Value="Có">Có</asp:ListItem>
                            <asp:ListItem Value="Không">Không</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
            </div>

            <div class="form-field">
                <asp:Label ID="lblNguoiDuyet" runat="server" Text="Người duyệt:" CssClass="form-label"></asp:Label>
                <div class="form-input-control">
                    <asp:TextBox ID="txtNguoiDuyet" CssClass="form-input" runat="server" placeholder="Chọn người duyệt" />
                </div>
            </div>
            <div class="form-field">
            </div>

            <div class="form-field-full-width">
                <div class="form-field-inner">
                    <asp:Label ID="lblTrichYeu" runat="server" Text="Trích yếu:" CssClass="form-label"></asp:Label>
                    <div class="form-input-control">
                        <asp:TextBox ID="txttrichyeu" CssClass="form-textarea" runat="server" TextMode="MultiLine" Rows="4" placeholder="Nhập nội dung trích yếu"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txttrichyeu" ErrorMessage="* Nhập trích yếu" CssClass="note-red" />
                    </div>
                </div>
            </div>

            <div class="form-field-full-width">
                <div class="form-field-inner">
                    <asp:Label ID="lblGhiChu" runat="server" Text="Ghi chú:" CssClass="form-label"></asp:Label>
                    <div class="form-input-control">
                        <asp:TextBox ID="txtGhiChu" CssClass="form-textarea" runat="server" TextMode="MultiLine" Rows="4" placeholder="Nhập ghi chú"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-field-full-width">
                <div class="file-upload-row">
                    <asp:Label ID="lblFile" runat="server" Text="File (nếu có):" CssClass="form-label"></asp:Label>
                    <div class="file-upload-main-container">
                        <div class="file-upload-custom">
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                            <label for="<%= FileUpload1.ClientID %>" class="file-upload-label">Choose File</label>
                            <span class="file-chosen-text">No file chosen</span>
                        </div>
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Upload" OnClick="btnUp_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>
            <div class="form-field-full-width">
                <div class="file-list-row">
                    <asp:Label ID="lblTapDinhKem" runat="server" Text="Tệp đính kèm:" CssClass="form-label"></asp:Label>
                    <div class="file-list-control-container">
                        <asp:ListBox ID="ListBox1" runat="server" Width="100%" Height="100px" CssClass="form-listbox" />
                        <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-primary" Text="Xóa" OnClick="btnRemove_Click" CausesValidation="False" />
                    </div>
                </div>
                <asp:Label ID="lblloi" runat="server" Text="" CssClass="note-red" Style="display: block; margin-left: 135px; margin-top: 6px;"></asp:Label>
            </div>

            <div class="form-buttons">
                <asp:Button ID="btnsua" runat="server" CssClass="btn btn-quaylai" Text="Quay lại" OnClick="btnlammoi_Click" CausesValidation="False" />
                <asp:Button ID="btnthem" runat="server" CssClass="btn btn-primary" Text="Thêm" OnClick="btnthem_Click" CausesValidation="True" />
            </div>
        </div>
    </div>

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
