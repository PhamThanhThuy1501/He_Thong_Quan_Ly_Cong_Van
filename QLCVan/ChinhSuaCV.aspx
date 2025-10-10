<%@ Page Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="ChinhSuaCV.aspx.cs" Inherits="QLCVan.ChinhSuaCV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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

        :root{
            --red: #c00;
            --red-dark: #9b0000;
            --muted: #6b7280;
            --card-bg: #ffffff;
            --page-bg: #f6f7f9;
            --accent: #0b57d0;
        }

        /* container */
        .edit-wrap { max-width: 1100px; margin: 22px auto; padding: 12px; }

        .edit-card {
            background: var(--card-bg);
            border-radius: 10px;
            border: 1px solid #e6e9ee;
            padding: 22px;
            box-shadow: 0 8px 20px rgba(11,35,66,0.04);
        }

        .edit-header {
            display:flex;
            align-items:center;
            justify-content:space-between;
            margin-bottom: 18px;
        }
        .edit-title { font-size:20px; color:#08324a; font-weight:700; letter-spacing:.4px; }
        .edit-sub { font-size:13px; color:var(--muted); }

        /* form grid */
        .edit-grid {
            display:grid;
            grid-template-columns: 160px 1fr 160px 1fr;
            gap: 12px 20px;
            align-items: center;
        }
        .label { text-align:right; padding-right:10px; font-weight:700; color:#16324a; }
        .input, .select, textarea {
            width:100%; padding:10px 12px; border-radius:8px; border:1px solid #d7dbe1;
            background:#fcfeff; box-sizing:border-box; font-size:14px;
        }
        textarea { min-height:120px; resize:vertical; }

        /* full-row (title / trich yeu) */
        .full-row { grid-column: 1 / -1; display:flex; gap:12px; align-items:center; }
        .full-row .label { text-align:left; width:140px; padding-right:0; }
        .full-row .field { flex:1; }

        /* file list */
        .file-list { margin-top:6px; display:flex; flex-direction:column; gap:8px; }
        .file-item { display:flex; gap:12px; align-items:center; }
        .file-item a { color:var(--accent); text-decoration:underline; }
        .file-meta { color:var(--muted); font-size:13px; }

        /* actions */
        .actions { grid-column: 1 / -1; display:flex; justify-content:center; gap:12px; margin-top:12px; }
        .btn { padding:10px 18px; border-radius:8px; border:none; cursor:pointer; font-weight:700; }
        .btn-primary { background: var(--accent); color:#fff; }
        .btn-ghost { background:transparent; border:1px solid #cfcfcf; color:#111; }

        /* message */
        .msg { text-align:center; margin-bottom:12px; font-weight:600; }

        @media (max-width:900px){
            .edit-grid { grid-template-columns: 1fr; }
            .label { text-align:left; padding-right:0; }
            .full-row .label { display:block; width:auto; }
            .actions { flex-direction:column; }
        }
        .cv{max-width:1240px; margin:0 auto; padding:12px}

        /* tiêu đề + gạch đỏ ngang */
        .cv-head{
            font-size:20px; font-weight:bold; color:#003366; margin:6px 0 10px;
        }
        .cv-headbar{height:12px; background:var(--red); margin:8px 0 14px; border-radius:2px}

              /* banner đỏ -> chữ chạy (CSS animation, không dùng <marquee>) */
.cv-banner{
    background:var(--red);
    color:#fff;
    font-weight:700;
    padding:8px 12px;
    border-radius:3px;
    margin-bottom:12px;
    overflow:hidden;              /* ẩn phần tràn */
    position:relative;
    height:15px;                  /* chỉnh cao nếu cần */
    display:flex;
    align-items:center;
}

/* phần chứa chữ chạy */
.cv-banner .marquee {
    display:inline-block;
    white-space:nowrap;
    will-change:transform;
    animation: scroll-left 12s linear infinite; /* sửa 12s để nhanh/chậm */
    font-size:16px;
}

/* khi rê chuột vào sẽ tạm dừng chạy */
.cv-banner:hover .marquee { 
    animation-play-state: paused;
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

    <div class="cv">
        <div class="cv-head">CHỈNH SỬA CÔNG VĂN</div>
     <div class="cv-banner">
    <div class="marquee">Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</div>
</div>

    <!-- FORM -->
    <div class="form-container">
        <h3><asp:Label ID="lbl1" runat="server" Text="Chỉnh Sửa CÔNG VĂN"></asp:Label></h3>
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
                    <asp:TextBox ID="txttrichyeu" runat="server"
                        TextMode="MultiLine" Rows="4"
                        CssClass="input"
                        placeholder="Tóm tắt nội dung văn bản...">
                    </asp:TextBox>
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
                        </div>
                    </div>
                    <asp:Label ID="lblloi" runat="server" Text="" CssClass="note-red" Style="display: block; margin-top: 6px;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: center; padding-top: 14px;">
                    <div class="form-buttons" style="justify-content: center;">
                        <asp:Button ID="btnsua" runat="server" CssClass="btnRe" Text="Lưu" OnClick="btnSave_Click" CausesValidation="True" />
                    </div>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
