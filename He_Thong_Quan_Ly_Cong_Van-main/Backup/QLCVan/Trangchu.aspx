<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="Trangchu.aspx.cs" Inherits="QLCVan.Trangchu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <style type="text/css">
        body
        {
            color: black;
        }
        #bang
        {
        }
        #bang1
        {
            float: left;
            height: 300px;
        }
        #bang2
        {
            float: left;
            height: 300px;
        }
        #btn
        {
            margin-top: 20px;
            padding-right: 10px;
            height: 100px;
            position: absolute;
            top: 360px;
            left: 200px;
        }
        #gv
        {
            position: absolute;
            top: 440px;
        }
    </style>
    <div>
        <br />
        <b>XEM CÔNG VĂN</b>
        <asp:RadioButton ID="rdpCVDen" runat="server" Text="Công Văn đến" AutoPostBack="True"
            GroupName="Search" OnCheckedChanged="rdpCVDen_CheckedChanged" />
        <asp:RadioButton ID="rdoCVdi" runat="server" Text="Công Văn đi" AutoPostBack="True"
            GroupName="Search" OnCheckedChanged="rdoCVdi_CheckedChanged" />
        <asp:RadioButton ID="rdoCVmoi" runat="server" Text="Công Văn chờ" AutoPostBack="True"
            GroupName="Search" OnCheckedChanged="rdoCVmoi_CheckedChanged" />
    </div>
    <br />
    <span style="color: Red">Click vào xem để xem chi tiết</span>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
                    AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView1_PageIndexChanging1"
                    ShowFooter="True" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField SortExpression="SoCV" HeaderText="Số CV">
                            <ItemTemplate>
                                <a href='CTCV.aspx?id=<%#Eval("MaCV")%>' style="text-decoration: none">
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("SoCV") %>'></asp:Label></a>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="TieudeCV" HeaderText="Tiêu đề">
                            <ItemTemplate>
                                <a href='CTCV.aspx?id=<%#Eval("MaCV")%>' style="text-decoration: none">
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("TieudeCV") %>'></asp:Label></a>
                            </ItemTemplate>
                            <ItemStyle Width="250px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="NgayGui" HeaderText="Ngày gửi" SortExpression="Ngaygui"
                            DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:TemplateField SortExpression="TrichyeuND" HeaderText="Trích yếu nội dung">
                            <ItemTemplate>
                                <a href='CTCV.aspx?id=<%#Eval("MaCV")%>' style="text-decoration: none">
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("TrichyeuND") %>'></asp:Label></a>
                            </ItemTemplate>
                            <ItemStyle Width="300px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Chi tiết" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a href='CTCV.aspx?id=<%#Eval("MaCV")%>' style="text-decoration: none">Xem</a>
                            </ItemTemplate>
                            <ItemStyle Width="60px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Xóa" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_Xoa" runat="server" OnClick="lnk_Xoa_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa công văn này không?')"
                                    CommandArgument='<%# Eval("Macv") %>'>Xóa</asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="60px" />
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" ForeColor="#333333" Font-Bold="True" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="GridView1" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
