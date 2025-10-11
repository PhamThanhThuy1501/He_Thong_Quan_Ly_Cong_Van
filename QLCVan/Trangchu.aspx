<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="Trangchu.aspx.cs" Inherits="QLCVan.Trangchu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root{
            --red:#c00; --red-600:#a60d0d; --ink:#222; --muted:#6b7280;
            --line:#e5e7eb; --bg:#f7f7f7; --white:#fff;
            --content-w:1100px; /* Đổi 1 chỗ này để tăng/giảm bề rộng Search + Bảng */
        }
        body{background:var(--bg); color:var(--ink); font-family:Arial, sans-serif}
        .cv{max-width:1800px; margin:0 auto; padding:12px}
        .cv-head{font-size:20px; font-weight:bold; color:#003366; margin:6px 0 10px;}
        .cv-headbar{height:12px; background:var(--red); margin:8px 0 14px; border-radius:2px}
        /* ===== ĐỒNG BỘ CHIỀU RỘNG SEARCH + BẢNG + TIÊU ĐỀ ===== */
        .cv-box,
.gridwrap,
.cv-list-title{
  width:100%;
  max-width:var(--content-w);
  margin-left:auto;
  margin-right:auto;
  box-sizing:border-box;
  padding:16px 18px;            /* giống nhau để mép trong thẳng hàng */
}
.cv-list-title{
  text-align:center; font-weight:700; font-size:20px; color:#0f172a; 
  margin:12px 0 8px; letter-spacing:.6px;
}

        /* banner chữ chạy */
        .cv-banner{
            background:var(--red); color:#fff; font-weight:700; padding:8px 12px;
            border-radius:3px; margin-bottom:12px; overflow:hidden; position:relative;
            height:15px; display:flex; align-items:center;
        }
        .cv-banner .marquee{display:inline-block; white-space:nowrap; will-change:transform;
            animation:scroll-left 12s linear infinite; font-size:16px;}
        .cv-banner:hover .marquee{animation-play-state:paused}
        @keyframes scroll-left{0%{transform:translateX(100%);}100%{transform:translateX(-100%);}}

        /* TÌM KIẾM – đồng bộ chiều rộng với bảng */
.cv-box{
  background:#f3f4f6!important;
  border:1px solid #e5e7eb;
  border-radius:10px;
}
        .cv-box-title{font-weight:bold; font-size:18px; color:#003366; text-align:center; margin-bottom:16px; letter-spacing:1px;}
        .cv-box .cv-form{display:grid!important; grid-template-columns:1fr 1fr 1fr!important;
            grid-template-areas:"socv tieude loai" "from to actions"; gap:14px 24px!important;}
        .cv-box .cv-form>.field:nth-child(1){grid-area:socv;}
        .cv-box .cv-form>.field:nth-child(2){grid-area:tieude;}
        .cv-box .cv-form>.field:nth-child(3){grid-area:loai;}
        .cv-box .cv-form>.field:nth-child(4){grid-area:from;}
        .cv-box .cv-form>.field:nth-child(5){grid-area:to;}
        .cv-box .cv-form>.field:nth-child(6){grid-area:actions;}
        .cv-box .cv-form .field{display:flex!important; flex-direction:column!important; gap:6px!important;}
        .cv-box .cv-form label{margin:0!important; font-weight:200!important; font-size:13px!important; color:#1f2937!important;}
        .cv-box .cv-form .input,.cv-box .cv-form .select{
            background:#fff!important; border:1px solid #d1d5db!important; border-radius:8px!important;
            padding:8px 12px!important; min-height:10px; font-size:14px;}
        .cv-box .cv-form .btn,.cv-box .cv-form input.btn{
            background:var(--red)!important; color:#fff!important; border:none!important; border-radius:6px!important;
            padding:6px 12px!important; font-size:13px!important; font-weight:500!important; justify-self:start;
            cursor:pointer; transition:all .2s ease-in-out;}
        .cv-box .cv-form .btn:hover,.cv-box .cv-form input.btn:hover{transform:scale(1.03);}
        @media (max-width:700px){
            .cv-box .cv-form{grid-template-columns:1fr 1fr!important;
                grid-template-areas:"socv socv" "tieude loai" "from to" "actions actions";}
        }
        @media (max-width:500px){
            .cv-box .cv-form{grid-template-columns:1fr!important;
                grid-template-areas:"socv" "tieude" "loai" "from" "to" "actions";}
        }

        .cv-note{color:#ef4444; font-size:13px; margin:6px 0}
        .cv-list-title{text-align:center; font-weight:700; font-size:20px; color:#0f172a; margin:12px 0 8px; letter-spacing:.6px;}
        @media (max-width:640px){.cv-list-title{font-size:18px;}}

        /* Bảng danh sách – cùng chiều rộng với khối tìm kiếm */
 .gridview{
  width:100%;
  border-collapse:collapse;
  font-family:Tahoma, sans-serif; font-size:13px;
  table-layout:fixed;
}
 .gridview{
  width:100%;
  border-collapse:collapse;
  font-family:Tahoma, sans-serif; font-size:13px;
  table-layout:fixed;
}
        .gridview th{background:var(--red); color:#fff; font-weight:bold; padding:8px; border:1px solid #ddd; text-align:left;}
        .gridview td{border:1px solid #ddd; padding:10px 12px; color:#000; vertical-align:middle;}
        .gridview tr:nth-child(even){background:#f9f9f9}
        .gridview a{color:#0066cc; text-decoration:none}
        .gridview a:hover{text-decoration:underline}

        /* Trích yếu: tối đa 2 dòng, dư "..." */
        .cell-trichyeu a{
            display:-webkit-box; -webkit-box-orient:vertical; -webkit-line-clamp:2;
            overflow:hidden; line-height:1.35;
        }

        /* Badge trạng thái (cột cố định) */
        .status-cell{text-align:center; white-space:nowrap;}
        .badge{display:inline-block; padding:6px 12px; border-radius:999px; font-size:12px; font-weight:700; line-height:1;
               border:1px solid transparent;}
        .badge--success{background:#22c55e; color:#fff; border-color:#22c55e;}   /* Đã gửi */
        .badge--danger{background:#fff; color:#ef4444; border-color:#ef4444;}   /* Không duyệt */
        .badge--warning{background:#fff; color:#d97706; border-color:#f59e0b;}  /* Đang trình */

        /* Thao tác: gọn để vừa cột 200px */
        .actions{display:flex; gap:8px; justify-content:center; align-items:center; white-space:nowrap;}
        .action-pill{display:inline-flex; align-items:center; justify-content:center; padding:6px 10px; font-size:12px;
            font-weight:600; border-radius:8px; min-width:auto; text-decoration:none; border:1px solid rgba(0,0,0,.06);
            box-shadow:0 1px 2px rgba(0,0,0,.06);}
        .action-view{background:#28a745; color:#fff;}
        .action-edit{background:#ffc107; color:#111;}
        .action-del{background:#dc3545; color:#fff;}

        /* Phân trang */
        .pager{text-align:center; padding:10px; background:#f1f1f1}
        .pager a,.pager span{display:inline-block; margin:0 4px; padding:4px 8px; border-radius:3px;
            color:#0066cc; text-decoration:none; border:1px solid transparent;}
        .pager a:hover{border:1px solid var(--red); color:var(--red)}
        .pager span{border:1px solid var(--red); background:var(--red); color:#fff; font-weight:bold}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cv">
        <div class="cv-head">XEM CÔNG VĂN</div>

        <div class="cv-banner"><div class="marquee">Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</div></div>

        <!-- TÌM KIẾM VĂN BẢN -->
        <div class="cv-box">
            <div class="cv-box-title">TÌM KIẾM VĂN BẢN</div>
            <div class="cv-form">
                <div class="field">
                    <label for="TextBox1">Số công văn:</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="input" placeholder="Nhập số công văn" />
                </div>
                <div class="field">
                    <label for="txtTieuDe">Tiêu đề:</label>
                    <asp:TextBox ID="txtTieuDe" runat="server" CssClass="input" placeholder="Nhập tiêu đề" />
                </div>
                <div class="field">
                    <label for="ddlLoai">Loại công văn:</label>
                    <asp:DropDownList ID="ddlLoai" runat="server" CssClass="select">
                        <asp:ListItem Value="">-- Tất cả --</asp:ListItem>
                        <asp:ListItem Value="1">Công văn đến</asp:ListItem>
                        <asp:ListItem Value="0">Công văn đi</asp:ListItem>
                        <asp:ListItem Value="2">Dự thảo</asp:ListItem>
                        <asp:ListItem Value="3">Nội bộ</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="field">
                    <label for="txtFromDate">Từ ngày:</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="input" TextMode="Date" placeholder="mm/dd/yyyy" />
                </div>
                <div class="field">
                    <label for="txtToDate">Đến ngày:</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="input" TextMode="Date" placeholder="mm/dd/yyyy" />
                </div>
                <div class="field">
                    <label></label>
                    <asp:Button ID="Button1" runat="server" Text="Tìm kiếm" CssClass="btn" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>

        
        <div class="cv-list-title">DANH SÁCH CÔNG VĂN</div>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>
                <div class="gridwrap">
                    <asp:GridView ID="GridView1" runat="server" CssClass="gridview" AutoGenerateColumns="False"
                        Width="100%" AllowPaging="True" PageSize="5"
                        OnPageIndexChanging="GridView1_PageIndexChanging1"
                        ShowFooter="False" GridLines="None">
                        <Columns>
                            <%-- Số công văn (190px) --%>
                            <asp:TemplateField SortExpression="SoCV" HeaderText="Số công văn">
                                <ItemTemplate>
                                    <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'><%#Eval("SoCV") %></a>
                                </ItemTemplate>
                                <HeaderStyle Width="190px" />
                                <ItemStyle Width="190px" />
                            </asp:TemplateField>

                            <%-- Ngày gửi (110px) --%>
                            <asp:BoundField DataField="NgayGui" HeaderText="Ngày gửi" SortExpression="Ngaygui" DataFormatString="{0:dd/MM/yyyy}">
                                <HeaderStyle Width="110px" />
                                <ItemStyle Width="110px" />
                            </asp:BoundField>

                            <%-- Trích yếu: tự giãn + ellipsis 2 dòng --%>
                            <asp:TemplateField SortExpression="TrichYeuND" HeaderText="Trích yếu nội dung">
                                <ItemTemplate>
                                    <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'><%#Eval("TrichYeuND") %></a>
                                </ItemTemplate>
                                <ItemStyle CssClass="cell-trichyeu" />
                            </asp:TemplateField>

                            <%-- TRẠNG THÁI (120px – cố định) --%>
                            <asp:TemplateField HeaderText="Trạng thái">
                                <ItemTemplate>
                                    <asp:Literal ID="litTrangThai" runat="server"
                                        Text='<%# GetTrangThai(Eval("TrangThai"), Eval("GuiHayNhan")) %>' />
                                </ItemTemplate>
                                <HeaderStyle Width="120px" />
                                <ItemStyle CssClass="status-cell" Width="120px" HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <%-- Thao tác (200px) --%>
                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <div class="actions">
                                        <a href='CTCV.aspx?id=<%# Eval("MaCV") %>' class="action-pill action-view">Xem</a>
                                        <a href='SuaCV.aspx?id=<%# Eval("MaCV") %>' class="action-pill action-edit">Sửa</a>
                                        <asp:LinkButton ID="lnk_Xoa" runat="server"
                                            CssClass="action-pill action-del"
                                            OnClick="lnk_Xoa_Click"
                                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa công văn này không?')"
                                            CommandArgument='<%# Eval("MaCV") %>'>Xóa</asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                                <ItemStyle Width="200px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pager" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
