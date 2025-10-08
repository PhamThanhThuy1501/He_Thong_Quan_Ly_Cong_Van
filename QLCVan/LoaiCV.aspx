<%@ Page Title="Quản lý Loại Công văn" Language="C#" MasterPageFile="~/QLCV.Master"
    AutoEventWireup="true" CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 + Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
<<<<<<< HEAD
        h3 {
            text-transform: uppercase;
            color: #990000;
            margin-top: 20px;
        }
        .table {
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .action-btn {
            font-size: 18px;
            margin: 0 6px;
            cursor: pointer;
        }
        .modal-header {
            background-color: #990000;
            color: #fff;
        }
=======
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
>>>>>>> origin/main
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<<<<<<< HEAD
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3><b>QUẢN LÝ LOẠI CÔNG VĂN</b></h3>
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addModal">
                <i class="fa fa-plus-circle"></i> Thêm mới
            </button>
        </div>

        <asp:GridView ID="grvLoaiCV" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered text-center"
            ShowFooter="False" DataKeyNames="MaLoaiCV" AllowPaging="True" PageSize="10"
=======
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
>>>>>>> origin/main
            OnPageIndexChanging="grvLoaiCV_PageIndexChanging"
            OnRowDeleting="rowDeleting" OnRowCancelingEdit="rowCancelingEdit"
            OnRowEditing="rowEditing" OnRowUpdating="rowUpdating">
            <Columns>
<<<<<<< HEAD
               
=======
>>>>>>> origin/main
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# (grvLoaiCV.PageIndex * grvLoaiCV.PageSize) + ((GridViewRow)Container).RowIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>

<<<<<<< HEAD
              
                <asp:BoundField DataField="MaLoaiCV" HeaderText="Mã Loại" ReadOnly="True" />

              
=======
                <asp:TemplateField HeaderText="Mã Loại">
                    <ItemTemplate>
                        <asp:Label ID="lblMaLoai" runat="server" Text='<%# Eval("MaLoaiCV") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

>>>>>>> origin/main
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
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Sửa" CssClass="action-btn text-primary">
                            <i class="fa fa-edit"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Xóa" CssClass="action-btn text-danger"
                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa loại công văn này không?');">
                            <i class="fa fa-trash"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="action-btn text-success">
                            <i class="fa fa-check"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="action-btn text-secondary">
                            <i class="fa fa-times"></i>
                        </asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>

            <PagerStyle CssClass="pagination" HorizontalAlign="Center" />

        </asp:GridView>
<<<<<<< HEAD
    </div>

    <!-- Modal thêm loại công văn -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Thêm Loại Công Văn Mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="txtMaLoaiNew" class="form-label">Mã loại công văn</label>
                        <asp:TextBox ID="txtMaLoaiNew" runat="server" CssClass="form-control" placeholder="Nhập mã loại công văn..."></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtTenLoaiNew" class="form-label">Tên loại công văn</label>
                        <asp:TextBox ID="txtTenLoaiNew" runat="server" CssClass="form-control" placeholder="Nhập tên loại công văn..."></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-success" Text="Thêm"
                        OnClick="btnAdd_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Script Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
=======
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

>>>>>>> origin/main
</asp:Content>


