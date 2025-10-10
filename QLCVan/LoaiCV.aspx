<%@ Page Title="Quản lý Loại Công văn" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        .content-header { width: 90%; margin: 0 auto 10px auto; background-color: #ffffff; padding: 10px 20px; box-sizing: border-box; border-bottom: 1px solid #eee; }
        .content-header-title { color: #007bff; font-size: 18px; font-weight: bold; margin: 0; }
        .welcome-bar { width: 90%; margin: 0 auto 25px auto; background-color: #c00000; color: white; padding: 8px; box-sizing: border-box; font-size: 14px; }
        .page-title { text-align: center; font-size: 26px; letter-spacing: .6px; margin: 2px 0 18px; color: var(--ink); }
        .table { border-collapse: collapse; width: 90%; margin: 0 auto; background: #fff; }
        .table th, .table td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        .table th { background-color: #990000; color: #fff; }
        .modalBackground { background-color: rgba(0,0,0,0.5); position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 10000; }
        .modalPopup { width: 520px; max-width: 92vw; background: #fff; border-radius: 12px; box-shadow: 0 14px 40px rgba(0,0,0,.28); font-family: Segoe UI,system-ui,-apple-system,Arial,sans-serif; overflow: hidden; padding: 0; animation: fadeInScale .22s ease-out; }
        .modal-header { display: flex; align-items: center; justify-content: space-between; padding: 16px 20px 10px 20px; }
        .modal-title { font-size: 18px; font-weight: 700; color: #222; width: 100%; text-align: left; position: relative; padding-bottom: 10px; }
        .modal-title::after { content: ""; display: block; height: 2px; width: 100%; background: #1e90ff; border-radius: 1px; position: absolute; left: 0; bottom: 0; }
        .modal-close { border: none; background: transparent; cursor: pointer; font-size: 22px; line-height: 1; color: #6b7280; margin-left: 12px; }
        .modal-close:hover { color: #111; }
        .modal-body { padding: 18px 20px 6px 20px; }
        .modal-body .form-control { width: 100%; height: 44px; box-sizing: border-box; border: 1px solid #D0D5DD; border-radius: 8px; padding: 10px 12px; font-size: 14px; color: #111; outline: none; transition: border-color .15s; margin-bottom: 12px; }
        .modal-body .form-control:focus { border-color: #1e90ff; }
        .modal-body .form-control::placeholder { color: #9aa0a6; }
        .modal-body .form-control[disabled] { background-color: #f2f2f2; }
        .modal-footer { display: flex; justify-content: flex-end; gap: 10px; padding: 12px 20px 20px 20px; }
        .modal-footer .btn { padding: 9px 18px; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: filter .15s; }
        .modal-footer .btn-success { background: #22c55e; color: #fff; }
        .modal-footer .btn-success:hover { filter: brightness(.95); }
        .modal-footer .btn-secondary { background: #6b7280; color: #fff; }
        .modal-footer .btn-secondary:hover { filter: brightness(.95); }
        @keyframes fadeInScale { from { opacity: 0; transform: scale(.95) } to { opacity: 1; transform: scale(1) } }
        .pagination { background-color: #fff !important; text-align: center; padding: 15px 0; }
        .pagination table { margin: 0 auto; }
        .pagination td { border: none !important; padding: 4px; }
        .pagination a, .pagination span { display: inline-block; padding: 6px 12px; margin: 0 3px; border: 1px solid #ddd; border-radius: 4px; color: #333; background-color: #fff; text-decoration: none; font-size: 14px; transition: all 0.2s ease; }
        .pagination a:hover { background-color: #f2f2f2; border-color: #bbb; }
        .pagination span { background-color: #e74c3c; color: #fff; border-color: #e74c3c; cursor: default; }
        .action-bar-container { width: 90%; margin: 0 auto 15px auto; display: flex; justify-content: space-between; align-items: center; }
        .search-container { display: flex; align-items: center; gap: 8px; }
        .search-container .search-label { font-weight: bold; font-size: 14px; }
        .search-container .search-input { padding: 6px 10px; font-size: 14px; border-radius: 4px; border: 1px solid #ccc; width: 200px; }
        .btn-search { background-color: #dc3545; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; }
        .btn-search:hover { background-color: #007bff; }
        .btn-add { background-color: #007bff; color: #fff; padding: 6px 14px; font-size: 14px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 5px; line-height: 1.5; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: background-color 0.3s ease; }
        .btn-add:hover { background-color: #c82333; }
        .form-group-radio { display: flex; align-items: center; gap: 15px; margin-bottom: 12px; padding: 10px 0; }
        .form-group-radio .radio-label { font-size: 14px; font-weight: 600; color: #333; }
        .form-group-radio label { margin-left: 4px; font-size: 14px; }
        .modal-footer .btn-danger { background: #dc3545; color: #fff; }
        .modal-footer .btn-danger:hover { filter: brightness(.95); }
        .modal-body-delete { text-align: center; font-size: 16px; padding: 30px 20px; }
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
        <marquee behavior="scroll" direction="left">Chào mừng bạn đến với hệ thống Quản lý Công văn điện tử.</marquee>
    </div>
    <h3 class="page-title"><b>DANH SÁCH LOẠI CÔNG VĂN</b></h3>
    <div class="action-bar-container">
        <div class="search-container">
            <asp:Label runat="server" Text="Tìm kiếm:" CssClass="search-label"></asp:Label>
            <asp:TextBox ID="txtSearchMaLoai" runat="server" CssClass="search-input" placeholder="Nhập mã loại công văn"></asp:TextBox>
            <asp:TextBox ID="txtSearchTenLoai" runat="server" CssClass="search-input" placeholder="Nhập tên loại công văn"></asp:TextBox>
            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click">
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
            OnRowCommand="grvLoaiCV_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Mã loại công văn"><ItemTemplate><asp:Label ID="lblMaLoai" runat="server" Text='<%# Eval("MaLoaiCV") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                <asp:TemplateField HeaderText="Tên loại công văn"><ItemTemplate><asp:Label ID="lblTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                <asp:TemplateField HeaderText="Phê duyệt"><ItemTemplate><asp:Label ID="lblPheDuyet" runat="server" Text='<%# ((GridViewRow)Container).RowIndex % 2 == 0 ? "Có" : "Không" %>'></asp:Label></ItemTemplate></asp:TemplateField>
                <asp:TemplateField HeaderText="Thao tác">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="ShowEditPopup" CommandArgument='<%# Eval("MaLoaiCV") %>' ToolTip="Sửa" CausesValidation="False"><i class="fa fa-edit" style="color:blue;"></i></asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="ShowDeletePopup" CommandArgument='<%# Eval("MaLoaiCV") %>' ToolTip="Xóa" CausesValidation="False"><i class="fa fa-trash" style="color:red;"></i></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle CssClass="pagination" HorizontalAlign="Center" />
        </asp:GridView>
    </center>
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
                 <asp:RadioButton ID="rbPheDuyetCo" runat="server" Text="Có" GroupName="pheduyet_add" Checked="true" /><asp:RadioButton ID="rbPheDuyetKhong" runat="server" Text="Không" GroupName="pheduyet_add" />
            </div>
        </div>
        <div class="modal-footer">
            <asp:Button ID="btnLuu" runat="server" Text="Thêm" CssClass="btn btn-success" OnClick="btnAdd_Click" UseSubmitBehavior="true" />
            <asp:Button ID="btnHuy" runat="server" Text="Đóng" CssClass="btn btn-secondary" />
        </div>
    </asp:Panel>
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
                 <asp:RadioButton ID="rbEditPheDuyetCo" runat="server" Text="Có" GroupName="pheduyet_edit" /><asp:RadioButton ID="rbEditPheDuyetKhong" runat="server" Text="Không" GroupName="pheduyet_edit" />
            </div>
        </div>
        <div class="modal-footer">
            <asp:Button ID="btnUpdate" runat="server" Text="Sửa" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancelEdit" runat="server" Text="Đóng" CssClass="btn btn-secondary" />
        </div>
    </asp:Panel>
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
    </script>
</asp:Content>