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
            <asp:RadioButton ID="rdpCVDen" runat="server" Text="Xem Công Văn Đến" AutoPostBack="True"
                GroupName="Search" OnCheckedChanged="rdpCVDen_CheckedChanged" />
            <asp:RadioButton ID="rdoCVdi" runat="server" Text="Xem Công Văn Đi" AutoPostBack="True"
                GroupName="Search" OnCheckedChanged="rdoCVdi_CheckedChanged" />
        
    </div>
    <br />
    <span style="color: Red">Click vào xem để xem chi tiết</span>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
                    AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView1_PageIndexChanging1"
                    ShowFooter="True" ForeColor="#333333" OnRowDataBound="GridView1_RowDataBound">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="SoCV" HeaderText="Số CV" SortExpression="SoCV" >
                        <ItemStyle Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TieudeCV" HeaderText="Tiêu đề" SortExpression="TieuDeCV">
                            <ItemStyle Width="150px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NgayGui" HeaderText="Ngày gửi" 
                            SortExpression="Ngaygui" DataFormatString="{0:dd/MM/yyyy}" >
                        <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TrichYeuND" HeaderText="Trích yếu ND" SortExpression="TrichYeuND">
                            <ItemStyle Width="300px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Chi tiết" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'>Xem</a>
                                <%-- <asp:LinkButton ID="lnk_Xem" runat="server" OnClick="lnk_Xem_Click" CommandArgument='<%# Eval("MaCV") %>'>Xem</asp:LinkButton>--%>
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
