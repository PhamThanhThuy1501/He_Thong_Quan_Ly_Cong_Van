<%@ Page Title="Quản lý Loại Công văn" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />


    <style>
        /* ====== GIAO DIỆN CHUNG ====== */
        .page-title {
            text-align: center;
            font-size: 26px;
            letter-spacing: .6px;
            margin: 2px 0 22px;
            color: #111;
        }
        .content-wrapper { width: 85%; margin: 0 auto; }

        /* ====== THANH HÀNH ĐỘNG (tìm kiếm + thêm mới) ====== */
        .action-bar{
            display:flex; align-items:center; justify-content:space-between;
            gap:12px; margin-bottom:14px;
        }
        .search-bar{
            display:flex; align-items:center; gap:10px; flex-wrap:wrap;
        }
        .search-bar label{ font-weight:700; color:#111; }
        .form-control{
            padding:8px 12px; border:1px solid #ccc; border-radius:6px; font-size:14px;
            width:210px;
        }
        .btn-search{
            background-color:#c62828; border:none; color:#fff; padding:9px 13px;
            border-radius:6px; cursor:pointer;
        }
        .btn-search:hover{ background-color:#a92323; }

        /* Nút thêm mới */
        .btn-add{
            background:#0b57d0; color:#fff; padding:9px 16px; border:none; border-radius:6px;
            display:inline-flex; align-items:center; gap:8px; cursor:pointer; text-decoration:none;
        }
        .btn-add:hover{ filter:brightness(.96); }

        /* ====== BẢNG ====== */
        .table{ width:100%; border-collapse:collapse; background:#fff; }
        .table th, .table td{ border:1px solid #ddd; padding:10px; text-align:center; font-size:14px; }
        .table th{ background:#990000; color:#fff; font-weight:600; }
        .table tr:nth-child(even){ background:#fafafa; }

        /* ====== PHÂN TRANG (căn giữa) ====== */
        .pagination{ background:#fff !important; text-align:center; padding:16px 0; }
        .pagination table{ margin:0 auto; }
        .pagination a, .pagination span{
            display:inline-block; padding:6px 12px; margin:0 3px; border:1px solid #ddd; border-radius:4px;
            color:#333; background:#fff; text-decoration:none; font-size:14px;
        }
        .pagination span{ background:#e74c3c; color:#fff; border-color:#e74c3c; }

        /* ====== POPUP ====== */
        .modalBackground{ background:rgba(0,0,0,.6); position:fixed; inset:0; z-index:9999; }
        .modalPopup{
            width:520px; max-width:92vw; background:#fff; border-radius:12px; box-shadow:0 14px 40px rgba(0,0,0,.28);
            font-family:Segoe UI,system-ui,Arial,sans-serif; overflow:hidden; animation:fadeInScale .22s ease-out;
        }
        .modal-header{ display:flex; align-items:center; justify-content:space-between; padding:16px 20px 10px; }
        .modal-title{ font-size:18px; font-weight:700; color:#222; width:100%; position:relative; padding-bottom:10px; }
        .modal-title::after{ content:""; display:block; height:2px; width:100%; background:#1e90ff; border-radius:1px; position:absolute; bottom:0; left:0; }
        .modal-close{ border:none; background:transparent; cursor:pointer; font-size:22px; line-height:1; color:#6b7280; }
        .modal-body{ padding:18px 20px 6px; }
        .modal-body .form-control{ width:100%; height:44px; border:1px solid #D0D5DD; border-radius:8px; padding:10px 12px; font-size:14px; color:#111; margin-bottom:12px; }
        .modal-footer{ display:flex; justify-content:flex-end; gap:10px; padding:12px 20px 20px; }
        .btn-success{ background:#22c55e; color:#fff; border:none; border-radius:8px; padding:9px 18px; cursor:pointer; }
        .btn-secondary{ background:#6b7280; color:#fff; border:none; border-radius:8px; padding:9px 18px; cursor:pointer; }

        /* RBL inline cùng nhãn Phê duyệt */
        .field-inline{ display:flex; align-items:center; gap:10px; margin-top:6px; }
        .rbl-inline{ display:inline-flex; align-items:center; gap:14px; }
        .rbl-inline input{ margin-right:6px; }

        @keyframes fadeInScale{ from{opacity:0; transform:scale(.95)} to{opacity:1; transform:scale(1)} }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <h3 class="page-title"><b>DANH SÁCH LOẠI CÔNG VĂN</b></h3>

        <!-- THANH HÀNH ĐỘNG: TÌM KIẾM + THÊM MỚI -->
        <div class="action-bar">
            <div class="search-bar">
                <label for="txtSearchMaLoai">Tìm kiếm:</label>
                <asp:TextBox ID="txtSearchMaLoai" runat="server" CssClass="form-control" placeholder="Nhập mã loại công văn" />
                <asp:TextBox ID="txtSearchTenLoai" runat="server" CssClass="form-control" placeholder="Nhập tên loại công văn" />
                <asp:Button ID="btnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click" Text="🔎" UseSubmitBehavior="true" />
            </div>

            <asp:LinkButton ID="btnOpenAdd" runat="server" CssClass="btn-add"
                OnClientClick="openAddModal(); return false;" CausesValidation="false">
                <i class="fa fa-plus-circle"></i> Thêm loại công văn
            </asp:LinkButton>
        </div>

        <!-- trigger modal -->
        <asp:Button ID="btnShowPopupTarget" runat="server" Style="display:none" />
        <ajaxToolkit:ModalPopupExtender ID="mpeAdd" runat="server"
            TargetControlID="btnShowPopupTarget"
            PopupControlID="pnlPopup"
            BackgroundCssClass="modalBackground"
            CancelControlID="btnHuy"
            DropShadow="true" />

        <!-- BẢNG -->
       <asp:GridView ID="grvLoaiCV" runat="server" AutoGenerateColumns="False"
    CssClass="table" DataKeyNames="MaLoaiCV"
    AllowPaging="True" PageSize="5"
    PagerStyle-HorizontalAlign="Center"
    PagerStyle-BackColor="#fff"
    OnPageIndexChanging="grvLoaiCV_PageIndexChanging"
    OnRowDeleting="rowDeleting"
    OnRowCancelingEdit="rowCancelingEdit"
    OnRowEditing="rowEditing"
    OnRowUpdating="rowUpdating">

    <Columns>
        <asp:TemplateField HeaderText="Mã loại công văn">
            <ItemTemplate>
                <asp:Label ID="lblMaLoai" runat="server" Text='<%# Eval("MaLoaiCV") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Tên loại công văn">
            <ItemTemplate>
                <asp:Label ID="lblTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>' CssClass="form-control"></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Phê duyệt">
            <ItemTemplate>
                <asp:Label ID="lblPheDuyet" runat="server" Text="Có"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Thao tác">
            <ItemTemplate>
                <!-- Biểu Tượng Sửa (Font Awesome) -->
                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Sửa" CausesValidation="False">
                    <i class="fa fa-pen icon-edit" style="color:var(--primary);"></i>
                </asp:LinkButton>
                <!-- Biểu Tượng Xóa (Font Awesome) -->
                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Xóa" CausesValidation="False"
                    OnClientClick="return confirm('Bạn có chắc chắn muốn xóa loại công văn này không?');">
                    <i class="fa fa-trash icon-del" style="color:#dc2626;"></i>
                </asp:LinkButton>
            </ItemTemplate>
            <EditItemTemplate>
                <!-- Biểu Tượng Cập Nhật (Font Awesome) -->
                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Cập nhật" CausesValidation="False">
                    <i class="fa fa-check" style="color:green;"></i>
                </asp:LinkButton>
                <!-- Biểu Tượng Hủy (Font Awesome) -->
                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Hủy" CausesValidation="False">
                    <i class="fa fa-times" style="color:gray;"></i>
                </asp:LinkButton>
            </EditItemTemplate>
        </asp:TemplateField>
    </Columns>

    <PagerStyle CssClass="pagination" HorizontalAlign="Center" />
</asp:GridView>

    </div>

    <!-- POPUP THÊM LOẠI CÔNG VĂN -->
    <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display:none;">
        <div class="modal-header">
            <div class="modal-title">Thêm mới loại công văn</div>
            <button type="button" class="modal-close" onclick="closeAddModal()" aria-label="Đóng">×</button>
        </div>

        <div class="modal-body">
            <asp:TextBox ID="txtMaLoaiCV" runat="server" CssClass="form-control" placeholder="Thêm mã loại công văn" />
            <asp:TextBox ID="txtTenLoaiCV" runat="server" CssClass="form-control" placeholder="Thêm tên loại công văn" />

            <div class="field-inline">
                <label>Phê duyệt:</label>
                <asp:RadioButtonList ID="rblPheDuyet" runat="server" RepeatDirection="Horizontal" CssClass="rbl-inline">
                    <asp:ListItem Text="Có" Value="True" Selected="True" />
                    <asp:ListItem Text="Không" Value="False" />
                </asp:RadioButtonList>
            </div>
        </div>

        <div class="modal-footer">
            <asp:Button ID="btnLuu" runat="server" Text="Thêm" CssClass="btn-success" OnClick="btnAdd_Click" UseSubmitBehavior="true" />
            <asp:Button ID="btnHuy" runat="server" Text="Đóng" CssClass="btn-secondary" />
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function openAddModal(){ var mpe = $find('<%= mpeAdd.ClientID %>'); if(mpe){ mpe.show(); } }
        function closeAddModal(){ var mpe = $find('<%= mpeAdd.ClientID %>'); if (mpe) { mpe.hide(); } }
    </script>
</asp:Content>
