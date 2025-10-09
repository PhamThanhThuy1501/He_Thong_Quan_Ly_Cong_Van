<!DOCTYPE html>
<html>
  <head runat="server">
    <title>Hệ thống Quản lý Công văn điện tử</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background-color: #fff;
        font-family: "Segoe UI", sans-serif;
      }
      header {
        border-bottom: 2px solid #c1121f;
        text-align: center;
        padding: 10px 0;
      }
      header img {
        width: 120px;
      }
      .school-name {
        font-weight: 700;
        font-size: 22px;
        color: #002147;
      }
      .school-sub {
        font-style: italic;
        color: #444;
      }
      nav {
        background-color: #c1121f;
        color: white;
        padding: 10px 0;
      }
      nav a {
        color: white;
        text-decoration: none;
        margin: 0 20px;
        font-weight: 500;
      }
      nav a:hover {
        text-decoration: underline;
      }
      .welcome {
        background-color: #c1121f;
        color: white;
        text-align: center;
        padding: 8px;
        font-weight: 500;
      }
      .section-title {
        background-color: #f2f2f2;
        font-weight: bold;
        padding: 10px;
        font-size: 18px;
      }
      .search-box {
        margin-top: 15px;
        display: flex;
        gap: 10px;
        justify-content: center;
      }
      .table th {
        background-color: #c1121f;
        color: white;
        text-align: center;
      }
      .btn-custom {
        background-color: #007bff;
        color: white;
        border: none;
      }
      .btn-custom:hover {
        background-color: #0056b3;
      }
      .logout {
        float: right;
        margin-right: 20px;
      }
      .logout a {
        color: red;
        font-weight: bold;
      }
      .logout span {
        color: green;
        margin-right: 10px;
      }
    </style>
  </head>

  <body>
    <form id="form1" runat="server">
      <!-- HEADER -->
      <header>
        <img src="./Images/logoA.jpg" alt="Logo" />
        <div class="school-name">TRƯỜNG QUÂN SỰ QUÂN KHU 2</div>
        <div class="school-sub">MILITARY SCHOOL OF MILITARY REGION 2</div>
      </header>

      <!-- MENU -->
      <nav class="text-center">
        <a href="#">GIỚI THIỆU</a>
        <a href="#">XEM CÔNG VĂN</a>
        <a href="#">NHẬP NỘI DUNG CÔNG VĂN</a>
        <a href="#">QUẢN LÝ LOẠI CÔNG VĂN</a>
        <a href="#">QUẢN LÝ NGƯỜI DÙNG</a>
        <a href="#">QUẢN LÝ NHÓM</a>
        <div class="logout">
          <span
            >Xin chào:
            <asp:Label ID="lblUser" runat="server" Text="quyen"></asp:Label
          ></span>
          <a href="DangXuat.aspx">Thoát</a>
        </div>
      </nav>

      <!-- DÒNG CHÀO MỪNG -->
      <div class="welcome">
        Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.
      </div>

      <!-- TIÊU ĐỀ PHẦN -->
      <div class="section-title text-primary">QUẢN LÝ NGƯỜI DÙNG</div>

      <!-- DANH SÁCH NHÓM QUYỀN -->
      <div class="container mt-4">
        <h4 class="text-center fw-bold">DANH SÁCH NHÓM QUYỀN</h4>

        <div class="search-box">
          <asp:TextBox
            ID="txtTenNhom"
            runat="server"
            CssClass="form-control"
            Placeholder="Nhập tên nhóm quyền"
            Width="250px"
          ></asp:TextBox>
          <asp:TextBox
            ID="txtMaNhom"
            runat="server"
            CssClass="form-control"
            Placeholder="Nhập mã nhóm quyền"
            Width="250px"
          ></asp:TextBox>
          <asp:Button
            ID="btnTimKiem"
            runat="server"
            Text="🔍"
            CssClass="btn btn-danger"
            OnClick="btnTimKiem_Click"
          />
          <asp:Button
            ID="btnThem"
            runat="server"
            Text="Thêm nhóm quyền"
            CssClass="btn btn-custom"
            OnClick="btnThem_Click"
          />
        </div>

        <asp:GridView
          ID="gvNhomQuyen"
          runat="server"
          AutoGenerateColumns="False"
          CssClass="table table-bordered table-striped mt-4"
          OnRowCommand="gvNhomQuyen_RowCommand"
          OnRowDeleting="gvNhomQuyen_RowDeleting"
          DataKeyNames="MaNhomQuyen"
        >
          <Columns>
            <asp:BoundField
              DataField="MaNhomQuyen"
              HeaderText="Mã nhóm quyền"
            />
            <asp:BoundField
              DataField="TenNhomQuyen"
              HeaderText="Tên nhóm quyền"
            />
            <asp:TemplateField HeaderText="Thao tác">
              <ItemTemplate>
                <asp:Button
                  ID="btnGanQuyen"
                  runat="server"
                  Text="Gán quyền"
                  CommandName="GanQuyen"
                  CommandArgument='%# Eval("MaNhomQuyen") %'
                  CssClass="btn btn-primary btn-sm"
                />
                <asp:Button
                  ID="btnSua"
                  runat="server"
                  Text="✏️"
                  CommandName="Sua"
                  CommandArgument='%# Eval("MaNhomQuyen") %'
                  CssClass="btn btn-warning btn-sm"
                />
                <asp:Button
                  ID="btnXoa"
                  runat="server"
                  Text="🗑️"
                  CommandName="Xoa"
                  CommandArgument='%# Eval("MaNhomQuyen") %'
                  CssClass="btn btn-danger btn-sm"
                />
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>

        <asp:Label
          ID="lblThongBao"
          runat="server"
          ForeColor="Red"
          CssClass="mt-3"
        ></asp:Label>
      </div>
    </form>
  </body>
</html>
