<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="Timkiem.aspx.cs" Inherits="QLCVan.Timkiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        #txtaTrichyeu
        {
            width: 568px;
            height: 84px;
            margin-right: 0px;
        }
        #txtaButphe
        {
            width: 568px;
            height: 84px;
        }
        #txttepdinhkem
        {
            width: 308px;
        }
        .style1
        {
            height: 27px;
        }
        .style2
        {
            height: 27px;
            width: 119px;
        }
        .style3
        {
            width: 119px;
        }
        .style4
        {
            width: 175px;
        }
    </style>
    <div>
        <center>
            <b>
                <h3>
                    TÌM KIẾM</h3>
            </b>
            <%-- </div>--%>
            <div style="width: 750px;">
                <table style="width: 600px;">
                    <tr>
                        <td colspan="5">
                            <asp:RadioButton ID="rdoTatCa" runat="server" Text="Tất cả" AutoPostBack="True" GroupName="Search"
                                OnCheckedChanged="rdoTatCa_CheckedChanged" />
                            <asp:RadioButton ID="rdpCVDen" runat="server" Text="CV Đến" OnCheckedChanged="rdpCVDen_CheckedChanged"
                                AutoPostBack="True" GroupName="Search" />
                            <asp:RadioButton ID="rdoCVdi" runat="server" Text="CV Đi" OnCheckedChanged="rdoCVdi_CheckedChanged"
                                AutoPostBack="True" GroupName="Search" />
                        </td>
                    </tr>
                    <td>
                        Loại Công Văn
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="100px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Nội Dung :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtNoiDung" runat="server" Width="380px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="Button1" runat="server" Text="Tìm" Width="70px" Height="26px" OnClick="btnTim_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <div style="width: 750px;">
                        <asp:GridView ID="gvTimkiem" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            ForeColor="#333333" ShowFooter="True" PageSize="3" AllowPaging="True" Width="750px"
                            OnPageIndexChanging="gvTimkiem_PageIndexChanging">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="SoCV" HeaderText="Số CV" />
                                <asp:BoundField DataField="TieudeCV" HeaderText="Tiêu đề" />
                                <asp:BoundField HeaderText="Trích yếu" DataField="TrichyeuND" />
                                <asp:TemplateField HeaderText="Chi tiết" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'>Xem</a></ItemTemplate>
                                    <ItemStyle Width="80px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Xóa" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk_Xoa" runat="server" OnClick="lnk_Xoa_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa công văn này không?')"
                                            CommandArgument='<%# Eval("Macv") %>'>Xóa</asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="80px" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <EditRowStyle BackColor="#999999" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="Silver" Font-Bold="True" ForeColor="SteelBlue" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="gvTimkiem" />
                </Triggers>
            </asp:UpdatePanel>
            <br />
        </center>
    </div>
</asp:Content>
