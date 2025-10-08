<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="QLnguoidung.aspx.cs" Inherits="QLCVan.QLnguoidung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    :root{
      --primary:#0b57d0;
      --primary-press:#0949ae;
      --border:#e6e6e6;
      --ink:#0f172a;
      --gridHead:#c62828;
    }

    .page{ max-width:1100px; margin:24px auto 28px; padding:0 14px; }
    .page-title{ text-align:center; font-size:26px; letter-spacing:.6px; margin:2px 0 18px; color:var(--ink); }

    .form-card{
      display:grid; grid-template-columns:1fr 1fr; gap:22px;
      background:#fafafa; border:1px solid var(--border); border-radius:12px; padding:18px 20px;
    }
    .formTable{ width:100%; border-collapse:separate; border-spacing:0 10px; }
    .formTable td{ vertical-align:middle; }
    .formTable .lbl{ width:180px; text-align:right; color:var(--ink); font-weight:700; padding:0 12px 0 0; white-space:nowrap; }

    .input-lg{
      width:100%; box-sizing:border-box; height:42px; padding:9px 12px;
      border:1px solid #cfd3da; border-radius:10px; background:#fff; color:var(--ink);
      transition:border-color .15s ease;
    }
    .input-lg:focus{ outline:none; border-color:var(--primary); box-shadow:0 0 0 2px rgba(11,87,208,.15); }
    .req{ color:#dc2626; }

    .actions{ display:flex; gap:12px; margin-top:6px; justify-content:center; }
    .btn{
      display:inline-flex; align-items:center; justify-content:center; gap:8px;
      height:44px; padding:0 18px; border-radius:10px; font-size:14px; cursor:pointer;
      border:1px solid #d1d5db; background:#f3f4f6; color:#111827; text-decoration:none;
    }
    .btn:hover{ filter:brightness(.98); }
    .btn-primary{ border-color:var(--primary); background:var(--primary); color:#fff; }
    .btn-primary:active{ background:var(--primary-press); border-color:var(--primary-press); }
    .btn-outline{ background:#fff; color:var(--primary); border-color:var(--primary); }
    .btn-outline:hover{ background:rgba(11,87,208,.06); }

    .gridWrapper{ width:100vw; margin-left:calc(50% - 50vw); margin-top:22px; }
    .gridInner{ max-width:1100px; margin:0 auto; padding:0 14px; }
    .grid{ width:100%; border-collapse:collapse; table-layout:fixed; }
    .grid-header th{ background:var(--gridHead); color:#fff; font-weight:800; padding:12px 10px; text-align:left; border:1px solid var(--border); }
    .grid-row td, .grid-alt td{ padding:12px 10px; border:1px solid var(--border); color:#0f172a; word-wrap:break-word; }
    .grid-alt{ background:#fafafa; }
    .grid-footer{ background:var(--gridHead); color:#fff; }

    .iconBtn{ display:inline-flex; align-items:center; justify-content:center; width:36px; height:36px; border-radius:10px; border:1px solid var(--border); background:#fff; }
    .iconBtn:hover{ background:#f3f4f6; }
    .icon-edit{ color:var(--primary); }
    .icon-del{ color:#dc2626; }

    @media (max-width:880px){
      .form-card{ grid-template-columns:1fr; }
      .formTable .lbl{ text-align:left; display:block; padding:0 0 6px; }
      .gridInner{ padding:0 10px; }
    }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="page">
    <h3 class="page-title"><b>QUẢN LÝ NGƯỜI DÙNG</b></h3>

    <div class="form-card">
      <!-- Cột trái -->
      <div>
        <table class="formTable">
          <tr>
            <td class="lbl">Mã ND<span class="req">*</span>:</td>
            <td><asp:TextBox ID="txtMaNguoiDung" runat="server" CssClass="input-lg" /></td>
          </tr>
          <tr>
            <td class="lbl">Họ tên<span class="req">*</span>:</td>
            <td><asp:TextBox ID="txtHoTen" runat="server" CssClass="input-lg" /></td>
          </tr>
          <tr>
            <td class="lbl">Email:</td>
            <td><asp:TextBox ID="txtEmail" runat="server" CssClass="input-lg" /></td>
          </tr>
          <tr>
            <td class="lbl">Quyền:</td>
            <td>
              <asp:DropDownList ID="ddlQuyen" runat="server" CssClass="input-lg">
                <asp:ListItem>User</asp:ListItem>
                <asp:ListItem>Admin</asp:ListItem>
              </asp:DropDownList>
            </td>
          </tr>
          <!-- ✅ Thay CheckBoxList bằng DropDownList -->
          <tr>
            <td class="lbl">Nhóm:</td>
            <td>
              <asp:DropDownList ID="ddlNhom" runat="server" CssClass="input-lg" />
            </td>
          </tr>
        </table>
      </div>

      <!-- Cột phải -->
      <div>
        <table class="formTable">
          <tr>
            <td class="lbl">Tên đăng nhập:</td>
            <td><asp:TextBox ID="txtTenDN" runat="server" CssClass="input-lg" /></td>
          </tr>
          <tr>
            <td class="lbl">Mật khẩu<span class="req">*</span>:</td>
            <td><asp:TextBox ID="txtMatkhau" runat="server" TextMode="Password" CssClass="input-lg" /></td>
          </tr>
          <tr>
            <td class="lbl">Xác nhận mật khẩu<span class="req">*</span>:</td>
            <td><asp:TextBox ID="txtMatkhau1" runat="server" TextMode="Password" CssClass="input-lg" /></td>
          </tr>
          <tr>
            <td class="lbl">Trạng thái:</td>
            <td>
              <asp:RadioButtonList ID="rblTrangThai" runat="server" RepeatDirection="Horizontal" CssClass="rbl">
                <asp:ListItem Value="0">Hiệu lực</asp:ListItem>
                <asp:ListItem Value="1">Chưa hiệu lực</asp:ListItem>
              </asp:RadioButtonList>
            </td>
          </tr>
        </table>

        <div class="actions">
          <asp:Button ID="btnThem" runat="server" Text="Thêm" OnClick="btnThem_Click" CssClass="btn btn-primary" />
          <asp:Button ID="btnTaoMoi" runat="server" Text="Tạo mới" OnClick="btnTaoMoi_Click" CssClass="btn btn-outline" />
        </div>

        <div class="msg"><asp:Literal ID="lblAlert" runat="server"></asp:Literal></div>
      </div>
    </div>

    <!-- GRID -->
    <div class="gridWrapper">
      <div class="gridInner">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
          <ContentTemplate>
            <asp:GridView ID="GridView2" runat="server"
                          AutoGenerateColumns="False"
                          AllowPaging="True"
                          DataKeyNames="MaNguoiDung"
                          DataSourceID="LinqDataSource2"
                          CssClass="grid">
              <Columns>
                <asp:BoundField DataField="TenDN" HeaderText="Tên đăng nhập" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="MaNhom" HeaderText="Nhóm" />
                <asp:TemplateField HeaderText="Trạng thái">
                  <ItemTemplate><%# (Eval("TrangThai")+"")=="0" ? "Hiệu lực" : "Chưa hiệu lực" %></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                  <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit"
                                    CommandArgument='<%# Eval("MaNguoiDung") %>' CssClass="iconBtn" ToolTip="Sửa">
                      <i class="fa fa-pen icon-edit"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                    CommandArgument='<%# Eval("MaNguoiDung") %>'
                                    OnClientClick="return confirm('Bạn có chắc muốn xoá?');"
                                    CssClass="iconBtn" ToolTip="Xóa">
                      <i class="fa fa-trash icon-del"></i>
                    </asp:LinkButton>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <HeaderStyle CssClass="grid-header" />
              <RowStyle CssClass="grid-row" />
              <AlternatingRowStyle CssClass="grid-alt" />
              <FooterStyle CssClass="grid-footer" />
            </asp:GridView>

            <asp:LinqDataSource ID="LinqDataSource2" runat="server"
                                ContextTypeName="QLCVan.InfoDataContext"
                                EnableDelete="True" EnableInsert="True" EnableUpdate="True"
                                TableName="tblNguoiDungs" />
          </ContentTemplate>
        </asp:UpdatePanel>
      </div>
    </div>
  </div>
</asp:Content>
