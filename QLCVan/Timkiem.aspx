<%@ Page Title="Tìm kiếm" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true" CodeBehind="Timkiem.aspx.cs" Inherits="QLCVan.Timkiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 20px;">

        <!-- Ô nhập nội dung tìm kiếm -->
        <asp:TextBox ID="txtNoiDung" runat="server" Width="300px" Placeholder="Nhập từ khóa..." />
        <asp:Button ID="btnTim" runat="server" Text="Tìm kiếm" OnClick="btnTim_Click" />

        <br /><br />

        <!-- Dropdown Loại công văn -->
        <asp:DropDownList ID="ddlLoaiCV" runat="server"></asp:DropDownList>

        <!-- Dropdown Cơ quan ban hành -->
        <asp:DropDownList ID="ddlCoQuan" runat="server"></asp:DropDownList>

        <!-- Dropdown Năm ban hành -->
        <asp:DropDownList ID="ddlNam" runat="server"></asp:DropDownList>

        <br /><br />

        <!-- Grid hiển thị kết quả -->
        <asp:GridView ID="gvTimkiem" runat="server" AutoGenerateColumns="False"
            AllowPaging="true" PageSize="10"
            OnPageIndexChanging="gvTimkiem_PageIndexChanging">

            <Columns>
                <asp:BoundField DataField="SoCV" HeaderText="Số CV" />
                <asp:BoundField DataField="TieuDeCV" HeaderText="Tiêu đề" />
                <asp:BoundField DataField="TrichYeuND" HeaderText="Trích yếu" />

                <asp:TemplateField HeaderText="Xóa">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_Xoa" runat="server" Text="Xóa"
                            CommandArgument='<%# Eval("MaCV") %>'
                            OnClick="lnk_Xoa_Click"
                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa?');">
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </div>
</asp:Content>
