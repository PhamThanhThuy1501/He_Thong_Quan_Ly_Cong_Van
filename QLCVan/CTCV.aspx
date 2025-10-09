<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="CTCV.aspx.cs" Inherits="QLCVan.CTCV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        :root {
          --red: #c00;
          --blue: #0b5ed7;
          --muted: #6b7280;
          --bg: #fff;
          --border: #e9edf3;
          --label-w: 160px;
        }

        /* ========== LAYOUT CHUNG ========== */
        .ctcv-container {
            max-width: 1100px;
            margin: 20px auto 60px;
            padding: 0 16px;
        }

        .card {
            background: var(--bg);
            border-radius: 10px;
            border: 1px solid #e7e9eb;
            padding: 28px;
            box-shadow: 0 8px 24px rgba(15,23,42,0.04);
        }

        .card-header {
            text-align: center;
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 18px;
            letter-spacing: .6px;
        }

        .banner {
            background: var(--red);
            color: #fff;
            padding: 8px 12px;
            border-radius: 4px;
            text-align: center;
            margin-bottom: 18px;
            font-weight: 600;
        }

        /* ========== FORM: 4-COLUMN GRID (label/input | label/input) ========== */
        .detail-grid {
            display: grid;
            grid-template-columns: var(--label-w) 1fr var(--label-w) 1fr; /* label | input | label | input */
            gap: 14px 26px;
            align-items: center;
        }

        /* label */
        .field-label {
            font-weight: 700;
            color: #111827;
            text-align: right;
            padding-right: 12px;
            line-height: 1.4;
            font-size: 14px;
        }

        /* style cho ô tiêu đề (full-row) */
        .full-row { grid-column: 1 / -1; display:flex; gap:12px; align-items:center; }
        .full-row .label-title {
            width: var(--label-w);
            text-align: right;
            font-weight: 800;
            color: #0b3556;
            padding-right: 12px;
            font-size: 15px;
        }
        .full-row .input-title { flex:1; }

        /* ô chứa input */
        .cell { display:block; }

        /* input chung */
        .input, .select, textarea, .asp-select {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 14px;
            color: #111827;
            background: #fbfdfe;
            box-sizing: border-box;
            outline: none;
            transition: border-color .12s ease, box-shadow .12s ease;
        }
        .input::placeholder, textarea::placeholder { color: #c7cdd3; }

        .input:focus, .select:focus, textarea:focus {
            border-color: #c6dcfb;
            box-shadow: 0 6px 18px rgba(11,94,215,0.06);
        }

        /* small input variant for date/short fields */
        .input.small {
            padding: 9px 12px;
            border-radius: 6px;
            max-width: 220px;
        }

        /* textarea */
        textarea[runat="server"], .multiline {
            min-height: 120px;
            resize: vertical;
            border-radius: 8px;
            background: #fbfdfe;
            padding: 12px;
        }

        /* căn label Trích yếu lên top để khớp textarea */
        .label-top { align-self: start; padding-top: 8px; }

        /* file list */
        .file-list { margin-top: 6px; font-style: italic; color: #0b3556; }
        .file-item { margin-bottom: 6px; display:flex; gap:12px; align-items:center; flex-wrap:wrap; }
        .file-item a.filename { text-decoration: underline; color: #0b5ed7; font-style: italic; }
        .file-size { color: var(--muted); font-size: 13px; margin-left: 6px; }

        /* email + button */
        .row-right { display:flex; gap:12px; align-items:center; }
        .btn-mail { padding:8px 16px; border-radius:8px; font-weight:700; background:var(--blue); color:#fff; border:none; cursor:pointer; }

        /* center edit button */
        .center-btn { grid-column: 1 / -1; display:flex; justify-content:center; margin-top:18px; }
        .btn-primary { background: var(--blue); color: #fff; border-radius: 8px; padding: 10px 18px; font-weight:700; text-decoration:none; display:inline-block; }

        /* responsive */
        @media (max-width: 980px) {
            .detail-grid { grid-template-columns: 140px 1fr 140px 1fr; gap:12px 18px; }
            .ctcv-container { padding: 0 12px; }
            .input.small { max-width: 180px; }
        }
        @media (max-width: 760px) {
            .detail-grid { grid-template-columns: 1fr; }
            .field-label { text-align: left; padding-right: 0; }
            .full-row { flex-direction: column; align-items:stretch; gap:8px; }
            .full-row .label-title { width: auto; text-align:left; padding-right:0; }
            .input.small { max-width: 100%; }
            .center-btn { justify-content:flex-start; }
        }

        /* small helper */
        .muted { color: var(--muted); font-size: 13px; }
   /* Đẩy label "Email" xuống dưới phần Tệp đính kèm */
/* Sửa lại phần input và nút gửi mail nằm cạnh nhau */
.field-label.email {
    grid-column: 1 / 2; /* Để label nằm ở cột đầu tiên */
    grid-row: 7; /* Đặt label email vào hàng thứ 7 */
}

.row-right.email {
    grid-column: 2 / -1; /* Để input và nút gửi mail chiếm các cột còn lại */
    grid-row: 7; /* Đặt input và nút gửi mail vào hàng thứ 7 */
    display: flex; /* Để input và nút gửi mail nằm cạnh nhau */
    gap: 6px; /* Khoảng cách giữa chúng */
}

                .cv{max-width:1340px; margin:0 auto; padding:12px}

        /* tiêu đề + gạch đỏ ngang */
        .cv-head{
            font-size:20px; font-weight:bold; color:#003366; margin:6px 0 10px;
        }.cv-headbar{height:12px; background:var(--red); margin:8px 0 14px; border-radius:2px}
       

/* banner chữ chạy căn giữa vùng (vùng chạy được thu gọn và căn giữa) */
.cv-banner{
    background:var(--red);
    color:#fff;
     display:flex;
  align-items:center;
  justify-content:center;
  padding: 12px 16px;   /* 12px trên + 12px dưới => chia đều */
  height: 30px;         /* để padding quyết định khoảng trên/dưới */
  box-sizing: border-box;
}

/* khu vực chứa vùng chạy, width điều chỉnh để vùng chạy nằm chính giữa ô */
.cv-banner .marquee-container{
     width:100%;        /* <-- thay 70% thành 600px nếu muốn cố định */
  max-width:1340px;
  overflow:hidden;
  margin:0 auto;
  position:relative;
     
}

/* chữ chạy bên trong vùng chạy */
.cv-banner .marquee {
    display:inline-block;
    white-space:nowrap;
    will-change:transform;
    animation: scroll-left 12s linear infinite; /* đổi 12s để nhanh/chậm */
    font-size:16px;          /* kích thước chữ */
    font-weight:700;
}

/* hover để tạm dừng */
.cv-banner:hover .marquee {
    animation-play-state: paused;
}

@keyframes scroll-left {
    0%   { transform: translateX(100%); }
    100% { transform: translateX(-100%); }
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="cv">
        <div class="cv-head">QUẢN LÝ CHI TIẾT CÔNG VĂN</div>

        <div class="cv-banner">
            <div class="marquee-container">
                <div class="marquee">Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</div>
            </div>
        </div>

        <div class="ctcv-container">
            <div class="card">
                <div class="card-header">CHI TIẾT CÔNG VĂN</div>

                <div class="detail-grid">
                    <!-- TIÊU ĐỀ (full width) - dùng full-row để căn đẹp -->
                    <div class="full-row">
                        <div class="label-title">Tiêu đề:</div>
                        <div class="input-title">
                            <asp:TextBox ID="txtTieuDe" runat="server" CssClass="input" Width="100%" Enabled="False" placeholder="Tiêu đề văn bản"></asp:TextBox>
                        </div>
                        <div></div>
                        <div></div>
                    </div>

                    <!-- Row: Số CV (left) | Tên loại CV (right) -->
                    <div class="field-label">Số CV:</div>
                    <div>
                        <asp:TextBox ID="txtSoCV" runat="server" CssClass="input small" Enabled="False" placeholder="Số công văn"></asp:TextBox>
                    </div>

                    <div class="field-label">Tên loại CV:</div>
                    <div>
                        <asp:TextBox ID="txtTenloaiCV" runat="server" CssClass="input small" Enabled="False" placeholder="Tên loại"></asp:TextBox>
                    </div>

                    <!-- Row: Cơ quan ban hành (left) | Loại công văn (right) -->
                    <div class="field-label">Cơ quan ban hành:</div>
                    <div>
                        <asp:TextBox ID="txtCQBH" runat="server" CssClass="input" Width="100%" Enabled="False" placeholder="Cơ quan ban hành"></asp:TextBox>
                    </div>

                    <div class="field-label">Loại công văn:</div>
                    <div>
                        <asp:TextBox ID="txtLoaiCV" runat="server" CssClass="input small" Enabled="False" placeholder="Loại công văn"></asp:TextBox>
                    </div>

                    <!-- Row: Ngày ban hành (left) | Ngày nhận (right) -->
                    <div class="field-label">Ngày ban hành:</div>
                    <div>
                        <asp:TextBox ID="txtNgayBH" runat="server" CssClass="input small" Enabled="False"></asp:TextBox>
                    </div>

                    <div class="field-label">Ngày nhận:</div>
                    <div>
                        <asp:TextBox ID="txtNgaynhan" runat="server" CssClass="input small" Enabled="False"></asp:TextBox>
                    </div>

                    <!-- TRÍCH YẾU: label căn top -->
                    <div class="field-label label-top">Trích yếu:</div>
                    <div style="grid-column: 2 / 5;">
                        <asp:TextBox ID="txtaTrichyeu" runat="server" CssClass="input multiline" TextMode="MultiLine" ReadOnly="true" Rows="6"></asp:TextBox>
                    </div>

                    <!-- Tệp đính kèm (label left + file list right) -->
                    <div class="field-label">Tệp đính kèm:</div>
                    <div>
                        <div class="file-list">
                            <asp:Repeater ID="rptfilecv" runat="server">
                                <ItemTemplate>
                                    <div class="file-item">
                                        <a class="filename" runat="server" href='<%# Eval("Url") %>' target="_blank"><%# Eval("TenFile") %></a>
                                        <span class="file-size"><%# Eval("Size") %></span>
                                        <asp:HyperLink runat="server" NavigateUrl='<%# Eval("Url") %>' Text="Tải xuống" Target="_blank" />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Literal ID="litNoFiles" runat="server" EnableViewState="false"></asp:Literal>
                        </div>
                    </div>

                    <!-- Email: label left, input + button right (dưới tệp đính kèm) -->
  <div class="field-label email">Email:</div>
<div class="row-right email">
    <asp:TextBox ID="txtNguoiNhan" runat="server" CssClass="input" placeholder="Email người nhận"></asp:TextBox>
    <asp:Button ID="btnGui" runat="server" CssClass="btn-mail" Text="Gửi mail" OnClick="btnGui_Click" />
    <asp:Literal ID="lblThongBao" runat="server"></asp:Literal>
</div>

                    <!-- Nút chỉnh sửa ở giữa -->
                    <div class="center-btn">
                        <a class="btn-primary" href='<%= "SuaCV.aspx?id=" + Request.QueryString["id"] %>'>Chỉnh sửa</a>
                    </div>

                </div> <!-- end detail-grid -->
            </div> <!-- end card -->
        </div> <!-- end ctcv-container -->
    </div> <!-- end cv -->

</asp:Content>
