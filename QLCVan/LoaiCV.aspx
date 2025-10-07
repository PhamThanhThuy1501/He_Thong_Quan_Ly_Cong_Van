<%@ Page Title="Quản lý Loại Công văn" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        .add-button-container {
            width: 75%;
            margin: 0 auto 10px auto;
            display: flex;
            justify-content: flex-end;
            padding-right: 1px;
        }

        .page-title {
            text-align: center;
            font-size: 26px;
            letter-spacing: .6px;
            margin: 2px 0 18px;
            color: var(--ink);
        }

        .btn-add {
            background-color: #007bff;
            color: #fff;
            padding: 6px 14px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            line-height: 1.5;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: background-color 0.3s ease;
        }

            .btn-add:hover {
                background-color: #0056b3;
            }

        .table {
            border-collapse: collapse;
            width: 90%;
            margin: 0 auto;
            background: #fff;
        }

            .table th, .table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }

            .table th {
                background-color: #990000;
                color: #fff;
            }

        .modalBackground {
            background-color: rgba(0,0,0,0.5);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 10000;
        }

        /* ===== Popup đẹp như figma (không dùng Bootstrap) ===== */
        .modalBackground {
            background: rgba(0,0,0,.6);
            position: fixed;
            inset: 0;
            z-index: 9999;
        }

        /* khung modal */
        .modalPopup {
            width: 520px;
            max-width: 92vw;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 14px 40px rgba(0,0,0,.28);
            font-family: Segoe UI,system-ui,-apple-system,Arial,sans-serif;
            overflow: hidden; /* để header bo tròn đẹp */
            padding: 0; /* QUAN TRỌNG: dùng header/body/footer riêng */
            animation: fadeInScale .22s ease-out;
        }

        /* Header */
        .modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 20px 10px 20px;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 700;
            color: #222;
            width: 100%;
            text-align: left;
            position: relative;
            padding-bottom: 10px;
        }

            .modal-title::after {
                content: "";
                display: block;
                height: 2px;
                width: 100%;
                background: #1e90ff;
                border-radius: 1px;
                position: absolute;
                left: 0;
                bottom: 0;
            }

        /* nút X */
        .modal-close {
            border: none;
            background: transparent;
            cursor: pointer;
            font-size: 22px;
            line-height: 1;
            color: #6b7280;
            margin-left: 12px;
        }

            .modal-close:hover {
                color: #111;
            }

        /* Body */
        .modal-body {
            padding: 18px 20px 6px 20px;
        }

            .modal-body .form-control {
                width: 100%;
                height: 44px;
                box-sizing: border-box;
                border: 1px solid #D0D5DD;
                border-radius: 8px;
                padding: 10px 12px;
                font-size: 14px;
                color: #111;
                outline: none;
                transition: border-color .15s;
                margin-bottom: 12px;
            }

                .modal-body .form-control:focus {
                    border-color: #1e90ff;
                }

                .modal-body .form-control::placeholder {
                    color: #9aa0a6;
                }

        /* Footer (nút nằm bên phải) */
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding: 12px 20px 20px 20px;
        }

            .modal-footer .btn {
                padding: 9px 18px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: filter .15s;
            }

            .modal-footer .btn-success {
                background: #22c55e;
                color: #fff;
            }

                .modal-footer .btn-success:hover {
                    filter: brightness(.95);
                }

            .modal-footer .btn-secondary {
                background: #6b7280;
                color: #fff;
            }

                .modal-footer .btn-secondary:hover {
                    filter: brightness(.95);
                }

        /* hiệu ứng */
        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(.95)
            }

            to {
                opacity: 1;
                transform: scale(1)
            }
        }

        /* =========================
   PHÂN TRANG ĐẸP GIỐNG FIGMA
   ========================= */
        .pagination {
            background-color: #fff !important;
            text-align: center;
            padding: 15px 0;
        }

            .pagination table {
                margin: 0 auto;
            }

            .pagination td {
                border: none !important;
                padding: 4px;
            }

            .pagination a,
            .pagination span {
                display: inline-block;
                padding: 6px 12px;
                margin: 0 3px;
                border: 1px solid #ddd;
                border-radius: 4px;
                color: #333;
                background-color: #fff;
                text-decoration: none;
                font-size: 14px;
                transition: all 0.2s ease;
            }

                .pagination a:hover {
                    background-color: #f2f2f2;
                    border-color: #bbb;
                }

            .pagination span {
                background-color: #e74c3c;
                color: #fff;
                border-color: #e74c3c;
                cursor: default;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="page-title"><b>DANH SÁCH LOẠI CÔNG VĂN</b></h3>

    <center>
        <div class="add-button-container">
            <!-- Nút user click: chỉ gọi JS, KHÔNG postback -->
            <asp:LinkButton ID="btnOpenAdd" runat="server" CssClass="btn-add"
                OnClientClick="openAddModal(); return false;" CausesValidation="false">
        <i class="fa fa-plus-circle"></i> Thêm mới
            </asp:LinkButton>

            <!-- Nút ẩn: là trigger thực sự cho ModalPopupExtender -->
            <asp:Button ID="btnShowPopupTarget" runat="server" Style="display: none" />

            <ajaxToolkit:ModalPopupExtender ID="mpeAdd" runat="server"
                TargetControlID="btnShowPopupTarget"
                PopupControlID="pnlPopup"
                BackgroundCssClass="modalBackground"
                CancelControlID="btnHuy"
                DropShadow="true" />
        </div>

        <!-- GridView hiển thị -->
        <asp:GridView ID="grvLoaiCV" runat="server" ShowFooter="False" AutoGenerateColumns="False"
            CssClass="table" DataKeyNames="MaLoaiCV"
            AllowPaging="True" PageSize="5"
            PagerStyle-HorizontalAlign="Center"
            PagerStyle-BackColor="#fff"
            PagerStyle-ForeColor="Black"
            OnPageIndexChanging="grvLoaiCV_PageIndexChanging"
            OnRowDeleting="rowDeleting" OnRowCancelingEdit="rowCancelingEdit"
            OnRowEditing="rowEditing" OnRowUpdating="rowUpdating">

            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# (grvLoaiCV.PageIndex * grvLoaiCV.PageSize) + ((GridViewRow)Container).RowIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Mã Loại">
                    <ItemTemplate>
                        <asp:Label ID="lblMaLoai" runat="server" Text='<%# Eval("MaLoaiCV") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Tên Loại">
                    <ItemTemplate>
                        <asp:Label ID="lblTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTenLoai" runat="server" Text='<%# Eval("TenLoaiCV") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thao tác">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Sửa" CausesValidation="False">
                            <i class="fa fa-edit" style="color:blue;"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Xóa" CausesValidation="False"
                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa loại công văn này không?');">
                            <i class="fa fa-trash" style="color:red;"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Cập nhật" CausesValidation="False">
                            <i class="fa fa-check" style="color:green;"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Hủy" CausesValidation="False">
                            <i class="fa fa-times" style="color:gray;"></i>
                        </asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>

            <PagerStyle CssClass="pagination" HorizontalAlign="Center" />

        </asp:GridView>
    </center>

    <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none;">


        <div class="modal-header">
            <div class="modal-title">Thêm loại công văn</div>
            <button type="button" class="modal-close" onclick="closeAddModal()" aria-label="Đóng">×</button>
        </div>

        <!-- Body -->
        <div class="modal-body">
            <asp:TextBox ID="txtMaLoaiCV" runat="server"
                CssClass="form-control"
                placeholder="Nhập mã loại công văn" />

            <asp:TextBox ID="txtTenLoaiCV" runat="server"
                CssClass="form-control"
                placeholder="Nhập tên loại công văn" />
        </div>

        <!-- Footer (nút bên phải) -->
        <div class="modal-footer">
            <asp:Button ID="btnLuu" runat="server" Text="Lưu"
                CssClass="btn btn-success"
                OnClick="btnAdd_Click"
                UseSubmitBehavior="true" />
            <asp:Button ID="btnHuy" runat="server" Text="Đóng"
                CssClass="btn btn-secondary" />
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


