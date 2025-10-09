<!DOCTYPE html>
<html>
  <head runat="server">
    <title>Quản lý tài liệu đính kèm</title>
  </head>
  <body>
    <form id="form1" runat="server">
      <h2>Quản lý tài liệu đính kèm cho công văn</h2>

      <asp:Label ID="lblMaCV" runat="server" Text="Mã công văn: "></asp:Label>
      <asp:TextBox ID="txtMaCV" runat="server"></asp:TextBox>
      <br /><br />

      <asp:FileUpload ID="fileUpload" runat="server" />
      <asp:TextBox
        ID="txtMota"
        runat="server"
        Width="300px"
        placeholder="Mô tả file..."
      ></asp:TextBox>
      <asp:Button
        ID="btnUpload"
        runat="server"
        Text="Tải lên"
        OnClick="btnUpload_Click"
      />
      <br /><br />

      <asp:GridView
        ID="gvFiles"
        runat="server"
        AutoGenerateColumns="False"
        DataKeyNames="FileID"
        OnRowDeleting="gvFiles_RowDeleting"
      >
        <Columns>
          <asp:BoundField DataField="FileID" HeaderText="ID" ReadOnly="True" />
          <asp:BoundField DataField="Tenfile" HeaderText="Tên file" />
          <asp:BoundField DataField="Mota" HeaderText="Mô tả" />
          <asp:BoundField
            DataField="DateUpload"
            HeaderText="Ngày tải lên"
            DataFormatString="{0:dd/MM/yyyy HH:mm}"
          />
          <asp:CommandField ShowDeleteButton="True" HeaderText="Xóa" />
        </Columns>
      </asp:GridView>

      <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </form>
  </body>
</html>
