<%@ Page Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="ChinhSuaCV.aspx.cs" Inherits="QLCVan.ChinhSuaCV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="edit-wrap">
        <div class="edit-card">
            <div class="edit-header">
                <div>
                    <div class="edit-title">Chỉnh sửa nội dung công văn</div>
                    <div class="edit-sub">Sửa thông tin chính — lưu để cập nhật dữ liệu</div>
                </div>
                <div>
                    <asp:Label ID="lblMsg" runat="server" CssClass="msg" />
                </div>
            </div>

            <div class="edit-grid">
                <!-- TIÊU ĐỀ (full row) -->
                <div class="full-row">
                    <div class="label">Tiêu đề:</div>
                    <div class="field">
                        <asp:TextBox ID="txtTieuDe" runat="server" CssClass="input" />
                    </div>
                </div>

                <div class="label">Số công văn:</div>
                <div>
                    <asp:TextBox ID="txtSoCV" runat="server" CssClass="input" />
                </div>

                <div class="label">Loại công văn:</div>
                <div>
                    <asp:DropDownList ID="ddlLoaiCV" runat="server" CssClass="select" />
                </div>

                <div class="label">Cơ quan ban hành:</div>
                <div>
                    <asp:TextBox ID="txtCQBH" runat="server" CssClass="input" />
                </div>

                <div class="label">Ngày ban hành:</div>
                <div>
                    <asp:TextBox ID="txtNgayBH" runat="server" CssClass="input" placeholder="dd-MM-yyyy" />
                </div>

                <div class="label">Ngày gửi:</div>
                <div>
                    <asp:TextBox ID="txtNgayGui" runat="server" CssClass="input" placeholder="dd-MM-yyyy" />
                </div>

                <div class="label label-top">Trích yếu:</div>
                <div style="grid-column: 2 / -1;">
                    <asp:TextBox ID="txtTrichYeu" runat="server" TextMode="MultiLine" CssClass="input" />
                </div>

                <!-- file list -->
                <div class="label">Tệp đính kèm:</div>
                <div>
                    <div class="file-list">
                        <asp:Repeater ID="rptFiles" runat="server">
                          <ItemTemplate>
                            <div class="file-item">
                              <a href='<%# Eval("Url") %>' target="_blank"><%# Eval("TenFile") %></a>
                              <asp:HyperLink runat="server" NavigateUrl='<%# Eval("Url") %>' Text="Tải" Target="_blank" />
                            </div>
                          </ItemTemplate>
                        </asp:Repeater>
                      <asp:Literal ID="litNoFiles" runat="server" EnableViewState="false" />
                    </div>
                </div>

                <!-- hidden -->
                <asp:HiddenField ID="hdnMaCV" runat="server" />

                <!-- actions -->
                <div class="actions">
                    <asp:Button ID="btnSave" runat="server" Text="Lưu thay đổi" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="btn btn-ghost" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
