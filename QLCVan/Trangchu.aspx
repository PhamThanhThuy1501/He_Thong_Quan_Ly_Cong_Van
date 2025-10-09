﻿<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="Trangchu.aspx.cs" Inherits="QLCVan.Trangchu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        :root{
            --red:#c00;
            --red-600:#a60d0d;
            --ink:#222;
            --muted:#6b7280;
            --line:#e5e7eb;
            --bg:#f7f7f7;
            --white:#fff;
        }
        body{background:var(--bg); color:var(--ink); font-family:Arial, sans-serif}

        /* khung trang */
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

@keyframes scroll-left {
    0%   { transform: translateX(100%); }
    100% { transform: translateX(-100%); }
}

        /* box tìm kiếm */
       /* CHỈ khối tìm kiếm nhỏ lại và nằm giữa */
.cv-box{
  background:#f3f4f6 !important;    /* xám nhạt */
  border:1px solid #e5e7eb;
  border-radius:10px;
  padding:16px 18px;
  max-width:1000px;                   /* chỉ search box nhỏ lại */
  margin-left:auto; margin-right:auto;
}

/* --- Thêm style cho tiêu đề tìm kiếm --- */
.cv-box-title {
  font-weight: bold;
  font-size: 18px;
  color: #003366;
  text-align: center;
  margin-bottom: 16px; /* tạo khoảng cách dưới dòng chữ */
  letter-spacing: 1px; /* giãn chữ ra nhẹ */
}

/* Lưới 3 cột: hàng 1 = Số CV | Tiêu đề | Loại ; hàng 2 = Từ | Đến | Nút */
.cv-box .cv-form{
  display: grid !important;
  grid-template-columns: 1fr 1fr 1fr !important;
  grid-template-areas:
    "socv   tieude loai"
    "from   to     actions";
  gap: 14px 24px !important;
}

/* Map theo THỨ TỰ các .field hiện có (không cần đổi HTML) */
.cv-box .cv-form > .field:nth-child(1){ grid-area: socv; }
.cv-box .cv-form > .field:nth-child(2){ grid-area: tieude; }
.cv-box .cv-form > .field:nth-child(3){ grid-area: loai; }
.cv-box .cv-form > .field:nth-child(4){ grid-area: from; }
.cv-box .cv-form > .field:nth-child(5){ grid-area: to; }
.cv-box .cv-form > .field:nth-child(6){ grid-area: actions; }
/* Nếu đã có .field--actions thì vẫn ép về đúng vị trí */
.cv-box .cv-form .field--actions{ grid-area: actions !important; }

/* Nhãn TRÊN – ô DƯỚI */
.cv-box .cv-form .field{
  display: flex !important;
  flex-direction: column !important;
  gap: 6px !important;
}
.cv-box .cv-form label{
  margin: 0 !important;
  font-weight: 200 !important;
  font-size: 13px !important;
  color: #1f2937 !important;
}

/* Ô nhập trắng, bo nhẹ */
.cv-box .cv-form .input,
.cv-box .cv-form .select{
  background: #fff !important;
  border: 1px solid #d1d5db !important;
  border-radius: 8px !important;
  padding: 8px 12px !important;
  min-height: 10px;
  font-size: 14px;
}

/* --- Nút "Tìm kiếm" nhỏ gọn hơn --- */
.cv-box .cv-form .btn,
.cv-box .cv-form input.btn {
  background: var(--red) !important;
  color: #fff !important;
  border: none !important;
  border-radius: 6px !important;
  padding: 6px 12px !important;  /* nhỏ lại */
  font-size: 13px !important;    /* chữ nhỏ */
  font-weight: 500 !important;
  justify-self: start;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
}

.cv-box .cv-form .btn:hover,
.cv-box .cv-form input.btn:hover {
  background: var(--red-200) !important;
  transform: scale(1.03);
}


/* Responsive vẫn giữ bố cục hợp lý */
@media (max-width: 700px){
  .cv-box .cv-form{
    grid-template-columns: 1fr 1fr !important;
    grid-template-areas:
      "socv   socv"
      "tieude loai"
      "from   to"
      "actions actions";
  }
}
@media (max-width: 500px){
  .cv-box .cv-form{
    grid-template-columns: 1fr !important;
    grid-template-areas:
      "socv" "tieude" "loai" "from" "to" "actions";
  }
}

        /* ghi chú nhỏ */
        .cv-note{color:#ef4444; font-size:13px; margin:6px 0}

        /* tiêu đề danh sách */
      
.cv-list-title{
  text-align: center;
  font-weight: 700;     /* đậm hơn */
  font-size: 20px;      /* to hơn một chút */
  color: #0f172a;
  margin: 12px 0 8px;
  letter-spacing: .6px;
}
@media (max-width: 640px){
  .cv-list-title{ font-size: 18px; } /* mobile gọn hơn */
}

        /* gridview giống ảnh */
        .gridwrap{border:1px solid #ddd; border-radius:3px; background:#fff; overflow:auto}
        .gridview{width:100%; border-collapse:collapse; font-family:Tahoma, sans-serif; font-size:13px}
        .gridview th{
            background:var(--red); color:#fff; font-weight:bold; padding:8px; border:1px solid #ddd; text-align:left;
        }
        .gridview td{border:1px solid #ddd; padding:6px 8px; color:#000}
        .gridview tr:nth-child(even){background:#f9f9f9}
        .gridview a{color:#0066cc; text-decoration:none}
        .gridview a:hover{text-decoration:underline}

       /* Buttons Thao tác – luôn nằm 1 hàng, giữa ô */
.actions{
  display:flex;
  gap:12px;                 /* khoảng cách giữa các nút */
  justify-content:center;
  align-items:center;
  white-space:nowrap;       /* giữ 1 dòng */
}
.modal {
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,.4);
  display: none;
  z-index: 9999;
}
.modal-content {
  background: #fff;
  max-width: 600px;
  margin: 5% auto;
  padding: 20px 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,.2);
}
.modal-content h3 {text-align:center; color:#003366;}
.modal-content label{display:block; margin-top:10px; font-weight:bold;}
.modal-content .input, .modal-content .select{
  width:100%; padding:6px 10px; border:1px solid #ccc; border-radius:5px;
}
.modal-content .btns{margin-top:14px; text-align:center;}

.action-pill{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  padding:10px 18px;        /* TO HƠN */
  font-size:13px;           /* chữ to hơn chút */
  font-weight:100;
  border-radius:10px;     /* bo tròn hẳn */
  min-width:40px;           /* mỗi nút tối thiểu 78px */
  text-decoration:none;
  border:1px solid rgba(0,0,0,.06);
  box-shadow:0 1px 2px rgba(0,0,0,.06); /* nhẹ nhàng */
}


.action-view { background:#28a745; color:#fff; }  /* Xem: xanh */
.action-edit { background:#ffc107; color:#111; }  /* Sửa: vàng */
.action-del  { background:#dc3545; color:#fff; }  /* Xóa: đỏ */

/* tăng chiều cao hàng cho cân đối */
.gridview td{ padding:10px 12px; vertical-align:middle; }

        /* phân trang kiểu số như ảnh */
        .pager{text-align:center; padding:10px; background:#f1f1f1}
        .pager a, .pager span{
            display:inline-block; margin:0 4px; padding:4px 8px; border-radius:3px;
            color:#0066cc; text-decoration:none; border:1px solid transparent;
        }
        .pager a:hover{border:1px solid var(--red); color:var(--red)}
        .pager span{border:1px solid var(--red); background:var(--red); color:#fff; font-weight:bold}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cv">
        <div class="cv-head">XEM CÔNG VĂN</div>
      

     <div class="cv-banner">
    <div class="marquee">Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</div>
</div>


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

        <div class="cv-note">Click vào "Xem" để xem chi tiết</div>

        <div class="cv-list-title">DANH SÁCH CÔNG VĂN</div>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div class="gridwrap">
            <asp:GridView ID="GridView1" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered"
                AllowPaging="True"
                PageSize="10"
                OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Số CV">
                        <ItemTemplate>
                            <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'><%#Eval("SoCV") %></a>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="NgayGui" HeaderText="Ngày gửi"
                        DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle Width="120px" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="Trích yếu nội dung">
                        <ItemTemplate>
                            <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'><%#Eval("TrichYeuND") %></a>
                        </ItemTemplate>
                        <ItemStyle Width="100%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Thao tác">
                      <ItemTemplate>
                        <!-- Nếu muốn điều hướng trực tiếp sang trang chỉnh sửa -->
                        <a class="action-pill action-edit"
                           href='ChinhSuaCV.aspx?id=<%# Eval("MaCV") %>'>Sửa</a>
                        &nbsp;
                        <!-- Xóa bằng LinkButton server (đảm bảo handler lnk_Xoa_Click tồn tại) -->
                        <asp:LinkButton ID="lnk_Xoa" runat="server"
                            CssClass="action-pill action-del"
                            OnClick="lnk_Xoa_Click"
                            CommandArgument='<%# Eval("MaCV") %>'>Xóa</asp:LinkButton>
                      </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                <PagerStyle CssClass="pager" />
            </asp:GridView>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>


</asp:Content>

