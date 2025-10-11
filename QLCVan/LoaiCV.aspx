<%@ Page Title="Quản lý Loại Công văn" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        :root{
            --ink:#0f172a; --red:#c00000; --blue:#0d6efd; --line:#e5e7eb;
        }

        /* Header + banner */
        .content-header{
          background: transparent;
          padding: 0;
          border-bottom: none;
          margin: 0 auto 6px auto; 
        }
        .content-header-title{
          text-transform: uppercase;
          font-weight: 700;
          font-size: 20px;
          color: #444;
          margin: 0 0 6px 0;
          letter-spacing: 0;
        }

        /* Thanh chạy chữ */
        .welcome-bar{
          background: #c00;         
          color: #fff;
          border-radius: 3px;
          padding: 4px 8px;
          margin: 0 auto 26px auto; 
          font-weight: 600;
        }
        .welcome-bar marquee{
          font-size: 15px;
          font-weight: 600;
        }

        /* Tiêu đề trang */
        .page-title { 
          text-align: center; 
          font-size: 26px; 
          letter-spacing: .6px; 
          margin: 8px 0 18px;    
          color: var(--ink); 
          font-weight:800; 
        }

        /* Thanh tìm kiếm + nút thêm */
        .action-bar-container { width: 70%; margin: 0 auto 15px auto; display: flex; justify-content: space-between; align-items: center; }
        .search-container { display: flex; align-items: center; gap: 8px; }
        .search-container .search-label { 
          font-weight: 500;
          font-size: 15px;
          color:#111; 
        }
        .search-container .search-input { 
          height:20px;
          padding: 8px 12px;  
          font-size: 15px;    
          border-radius: 6px; 
          border: 1px solid #ccc; 
          width: 250px; 
          outline:none; 
        }
        .search-container .search-input:focus{ border-color:#89b4ff; box-shadow:0 0 0 2px rgba(13,110,253,.12); }

        .btn-search {
            width: 42px; height: 42px;
            display: inline-flex; align-items: center; justify-content: center;
            background-color: var(--red); color: white; border: none; border-radius: 12px; /* bo to hơn */
            cursor: pointer; font-size: 15px;
            transition: filter .15s;
        }
        .btn-search:hover { filter: brightness(.95); }

        .btn-add {
            background-color: #0d6efd; color: #fff; 
            padding: 10px 16px;
            font-size: 15px;            
            border: none; border-radius: 12px;  /* bo to hơn */
            cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; line-height: 1.4;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08); transition: filter .15s;
        }
        .btn-add:hover { filter: brightness(.95); }

        /* Bảng danh sách */
        .table { border-collapse: collapse; width: 70%; margin: 0 auto; background: #fff; table-layout: fixed; }
        .table th, .table td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        .table th { background-color: #990000; color: #fff; font-weight: 800; }
        .table tr:nth-child(even) { background:#fafafa; }

        /* Định độ rộng cột */
        .table th:nth-child(1), .table td:nth-child(1){ width: 140px; }
        .table th:nth-child(2), .table td:nth-child(2){ text-align: left; }
        .table th:nth-child(3), .table td:nth-child(3){ width: 120px; }
        .table th:nth-child(4), .table td:nth-child(4){ width: 120px; }

        /* Icon thao tác */
        .icon-btn{
            width:28px; height:28px; display:inline-flex; align-items:center; justify-content:center;
            background:#fff; border:1px solid #ddd; border-radius:4px; margin:0 4px;
            transition: background .15s, transform .05s;
        }
        .icon-btn:hover{ background:#f5f5f5; transform: translateY(-1px); }
        .icon-btn i{ font-size:12px; line-height:1; }

        /* Ẩn pager mặc định trong GridView (vẫn dùng để clone ra ngoài) */
        .pagination-source { display: none !important; }

       /* === Pager ngoài bảng: to hơn, vuông, bo ít góc === */
.pager-out { 
  width: 70%;
  margin: 16px auto 0 auto;           /* cách bảng rõ hơn một chút */
  text-align: center;
}

.pager-out a, .pager-out span {
  /* Kích thước vuông */
  min-width: 48px;                    /* đủ cho 1 chữ số; 2 chữ số sẽ rộng hơn 1 chút để không cắt chữ */
  height: 48px;
  display: inline-flex;
  align-items: center;
  justify-content: center;

  /* Hình dáng & chữ */
  padding: 0 10px;                    /* vẫn cho phép 2 chữ số không bị chật */
  border: 1px solid #ddd;
  border-radius: 6px;                 /* bo ít góc */
  background: #fff;
  color: #333;
  text-decoration: none;
  font-size: 16px;                    /* to hơn */
  font-weight: 700;                   /* đậm hơn để rõ số trang */
  line-height: 1;
  margin: 0 3px;                      /* khoảng cách vừa phải giữa các nút */
  transition: background .2s, border-color .2s, transform .02s;
}

.pager-out a:hover {
  background: #f5f5f5;
  border-color: #cfcfcf;
}

.pager-out span {                      /* trang hiện tại */
  background: #e74c3c;
  color: #fff;
  border-color: #e74c3c;
}

.pager-out a:active {
  transform: translateY(1px);
}

/* Hỗ trợ bàn phím */
.pager-out a:focus-visible {
  outline: 2px solid rgba(13,110,253,.35);
  outline-offset: 2px;
}


        /* Modal */
        .modalBackground { background-color: rgba(0,0,0,0.5); position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 10000; }
        .modalPopup { width: 520px; max-width: 92vw; background: #fff; border-radius: 12px; box-shadow: 0 14px 40px rgba(0,0,0,.28); font-family: Segoe UI,system-ui,-apple-system,Arial,sans-serif; overflow: hidden; padding: 0; animation: fadeInScale .22s ease-out; }
        .modal-header { display: flex; align-items: center; justify-content: space-between; padding: 16px 20px 10px 20px; }
        .modal-title { font-size: 18px; font-weight: 700; color: #222; width: 100%; text-align: left; position: relative; padding-bottom: 10px; }
        .modal-title::after { 
          content: ""; display: block; height: 2px; width: 100%; 
          background: var(--line);
          border-radius: 1px; position: absolute; left: 0; bottom: 0; 
        }
        .modal-close { border: none; background: transparent; cursor: pointer; font-size: 22px; line-height: 1; color: #6b7280; margin-left: 12px; }
        .modal-close:hover { color: #111; }
        .modal-body { padding: 18px 20px 6px 20px; }
        .modal-body .form-control { width: 100%; height: 44px; box-sizing: border-box; border: 1px solid #D0D5DD; border-radius: 8px; padding: 10px 12px; font-size: 14px; color: #111; outline: none; transition: border-color .15s; margin-bottom: 12px; }
        .modal-body .form-control:focus { border-color: #1e90ff; }
        .modal-body .form-control::placeholder { color: #9aa0a6; }
        .modal-body .form-control[disabled] { background-color: #f2f2f2; }
        .form-group-radio { display: flex; align-items: center; gap: 15px; margin-bottom: 12px; padding: 10px 0; }
        .form-group-radio .radio-label { font-size: 14px; font-weight: 600; color: #333; }

        /* Popup Xoá – căn trái nội dung cho gọn */
        .modal-body-delete { 
          text-align: left;
          font-size: 16px; 
          padding: 24px 20px; 
          line-height: 1.6;
        }

        .modal-footer { display: flex; justify-content: flex-end; gap: 10px; padding: 12px 20px 20px 20px; }
        .modal-footer .btn { padding: 9px 18px; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: filter .15s; }
        .modal-footer .btn-success { background: #22c55e; color: #fff; }
        .modal-footer .btn-success:hover { filter: brightness(.95); }
        .modal-footer .btn-secondary { background: #6b7280; color: #fff; }
        .modal-footer .btn-secondary:hover { filter: brightness(.95); }
        .modal-footer .btn-danger { background: #dc3545; color: #fff; }
        .modal-footer .btn-danger:hover { filter: brightness(.95); }
        @keyframes fadeInScale { from { opacity: 0; transform: scale(.95) } to { opacity: 1; transform: scale(1) } }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfEditID" runat="server" />
    <asp:HiddenField ID="hfDeleteID" runat="server" />

    <ajaxToolkit:ModalPopupExtender ID="mpeEdit" runat="server" TargetControlID="hfEditID" PopupControlID="pnlEditPopup" BackgroundCssClass="modalBackground" CancelControlID="btnCancelEdit" DropShadow="true" />
    <ajaxToolkit:ModalPopupExtender ID="mpeDelete" runat="server" TargetControlID="hfDeleteID" PopupControlID="pnlDeletePopup" BackgroundCssClass="modalBackground" CancelControlID="btnCancelDelete" DropShadow="true" />

    <div class="content-header">
        <h2 class="content-header-title">QUẢN LÝ LOẠI CÔNG VĂN</h2>
    </div>

    <div class="welcome-bar">
      <marquee behavior="scroll" direction="left" scrollamount="6">
        Chào mừng bạn đến với hệ thống Quản lý Công văn điện tử.
      </marquee>
    </div>

    <h3 class="page-title"><b>DANH SÁCH LOẠI CÔNG VĂN</b></h3>

    <div class="action-bar-container">
        <div class="search-container">
            <asp:Label runat="server" Text="Tìm kiếm:" CssClass="search-label"></asp:Label>
            <asp:TextBox ID="txtSearchMaLoai" runat="server" CssClass="search-input" placeholder="Nhập mã loại công văn"></asp:TextBox>
            <asp:TextBox ID="txtSearchTenLoai" runat="server" CssClass="search-input" placeholder="Nhập tên loại công văn"></asp:TextBox>
            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click" ToolTip="Tìm kiếm">
                <i class="fa fa-search"></i>
            </asp:LinkButton>
        </div>
        <div>
            <asp:LinkButton ID="btnOpenAdd" runat="server" CssClass="btn-add"
                OnClientClick="openAddModal(); return false;" CausesValidation="false">
                <i class="fa fa-plus-circle"></i> Thêm loại công văn
            </asp:LinkButton>
        </div>
    </div>

    <asp:Button ID="btnShowPopupTarget" runat="server" Style="display: none" />
    <ajaxToolkit:ModalPopupExtender ID="mpeAdd" runat="server" TargetControlID="btnShowPopupTarget" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground" CancelControlID="btnHuy" DropShadow="true" />

    <center>
        <asp:GridView ID="grvLoaiCV" runat="server" ShowFooter="False" AutoGenerateColumns="False"
            CssClass="table" DataKeyNames="MaLoaiCV"
            AllowPaging="True" PageSize="5"
            OnPageIndexChanging="grvLoaiCV_PageIndexChanging"
            OnRowCommand="grvLoaiCV_RowCommand"
            PagerStyle-CssClass="pagination pagination-source">
            <Columns>
                <asp:TemplateField HeaderText="Mã loại công văn">
                    <ItemTemplate><asp:Label ID="lblMaLoai" runat="server" Text='<%# Eval("MaLoaiCV") %>'></asp:Label></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Tên loại công văn">
                    <ItemTemplate><asp:Label ID="lblTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>'></asp:Label></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Phê duyệt">
                    <ItemTemplate><asp:Label ID="lblPheDuyet" runat="server" Text='<%# ((GridViewRow)Container).RowIndex % 2 == 0 ? "Có" : "Không" %>'></asp:Label></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thao tác">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="icon-btn" CommandName="ShowEditPopup" CommandArgument='<%# Eval("MaLoaiCV") %>' ToolTip="Sửa" CausesValidation="False">
                            <i class="fa fa-pen" style="color:#0d6efd;"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="icon-btn" CommandName="ShowDeletePopup" CommandArgument='<%# Eval("MaLoaiCV") %>' ToolTip="Xóa" CausesValidation="False">
                            <i class="fa fa-trash" style="color:#dc3545;"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </center>

    <!-- Phân trang bên ngoài bảng -->
    <div id="pagerOutside" class="pager-out"></div>

    <!-- Popup Thêm -->
    <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none;">
        <div class="modal-header">
            <div class="modal-title">Thêm mới loại công văn</div>
            <button type="button" class="modal-close" onclick="closeAddModal()" aria-label="Đóng">×</button>
        </div>
        <div class="modal-body">
            <asp:TextBox ID="txtMaLoaiCV" runat="server" CssClass="form-control" placeholder="Nhập mã loại công văn" />
            <asp:TextBox ID="txtTenLoaiCV" runat="server" CssClass="form-control" placeholder="Nhập tên loại công văn" />
            <div class="form-group-radio">
                 <span class="radio-label">Phê duyệt:</span>
                 <asp:RadioButton ID="rbPheDuyetCo" runat="server" Text="Có" GroupName="pheduyet_add" Checked="true" />
                 <asp:RadioButton ID="rbPheDuyetKhong" runat="server" Text="Không" GroupName="pheduyet_add" />
            </div>
        </div>
        <div class="modal-footer">
            <asp:Button ID="btnLuu" runat="server" Text="Thêm" CssClass="btn btn-success" OnClick="btnAdd_Click" UseSubmitBehavior="true" />
            <asp:Button ID="btnHuy" runat="server" Text="Đóng" CssClass="btn btn-secondary" />
        </div>
    </asp:Panel>

    <!-- Popup Sửa -->
    <asp:Panel ID="pnlEditPopup" runat="server" CssClass="modalPopup" Style="display: none;">
        <div class="modal-header">
            <div class="modal-title">Chỉnh sửa loại công văn</div>
            <asp:LinkButton ID="lnkCloseEdit" runat="server" CssClass="modal-close" OnClientClick="$find('mpeEdit').hide(); return false;">×</asp:LinkButton>
        </div>
        <div class="modal-body">
            <asp:TextBox ID="txtEditMaLoai" runat="server" CssClass="form-control" Enabled="false" />
            <asp:TextBox ID="txtEditTenLoaiCV" runat="server" CssClass="form-control" />
            <div class="form-group-radio">
                 <span class="radio-label">Phê duyệt:</span>
                 <asp:RadioButton ID="rbEditPheDuyetCo" runat="server" Text="Có" GroupName="pheduyet_edit" />
                 <asp:RadioButton ID="rbEditPheDuyetKhong" runat="server" Text="Không" GroupName="pheduyet_edit" />
            </div>
        </div>
        <div class="modal-footer">
            <asp:Button ID="btnUpdate" runat="server" Text="Sửa" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancelEdit" runat="server" Text="Đóng" CssClass="btn btn-secondary" />
        </div>
    </asp:Panel>

    <!-- Popup Xóa -->
    <asp:Panel ID="pnlDeletePopup" runat="server" CssClass="modalPopup" Style="display: none;">
        <div class="modal-header">
            <div class="modal-title">Xác nhận xóa loại công văn</div>
             <asp:LinkButton ID="LinkButton1" runat="server" CssClass="modal-close" OnClientClick="$find('mpeDelete').hide(); return false;">×</asp:LinkButton>
        </div>
        <div class="modal-body modal-body-delete">
            Bạn có chắc chắn muốn xóa loại công văn này không?
        </div>
        <div class="modal-footer">
            <asp:Button ID="btnConfirmDelete" runat="server" Text="Xóa" CssClass="btn btn-danger" OnClick="btnConfirmDelete_Click" />
            <asp:Button ID="btnCancelDelete" runat="server" Text="Đóng" CssClass="btn btn-secondary" />
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function openAddModal() {
            var mpe = $find('<%= mpeAdd.ClientID %>');
            if (mpe) { mpe.show(); }
        }
        function closeAddModal() {
            var mpe = $find('<%= mpeAdd.ClientID %>');
            if (mpe) { mpe.hide(); }
        }

        // Clone pager mặc định của GridView ra ngoài bảng
        (function () {
            function clonePager() {
                // tìm pager nằm trong GridView
                var grid = document.getElementById('<%= grvLoaiCV.ClientID %>');
                if (!grid) return;
                var src = grid.querySelector('.pagination'); // pager mặc định
                var out = document.getElementById('pagerOutside');
                if (!src || !out) return;

                out.innerHTML = '';
                // clone tất cả a, span (trang hiện tại render là <span>)
                var items = src.querySelectorAll('a, span');
                items.forEach(function (el) {
                    out.appendChild(el.cloneNode(true));
                });

                // Ẩn nguồn (phòng trường hợp CSS chưa áp)
                src.style.display = 'none';
            }

            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', clonePager);
            } else {
                clonePager();
            }

            // Nếu có partial postback (MS AJAX), sau khi cập nhật lại grid thì clone lại pager
            if (typeof (Sys) !== 'undefined' &&
                Sys.WebForms && Sys.WebForms.PageRequestManager) {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(clonePager);
            }
        })();
    </script>
</asp:Content>
