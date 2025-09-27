<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="LoaiCV.aspx.cs" Inherits="QLCVan.LoaiCV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <center>
        <h3>
            &nbsp;<b>QUẢN LÝ LOẠI CÔNG VĂN</b></h3>
        <p>
            <asp:HiddenField ID="hdfID" runat="server" />
        </p>
<%--        <div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                <ContentTemplate>--%>
                    <asp:GridView ID="grvLoaiCV" runat="server" ShowFooter="True" AutoGenerateColumns="False"
                        CellPadding="4" ForeColor="#333333" OnRowDeleting="rowDeleting" Width="48%" OnRowCancelingEdit="rowCancelingEdit"
                        OnRowEditing="rowEditing" OnRowUpdating="rowUpdating" OnRowCommand="rowCommand"
                        DataKeyNames="MaLoaiCV" GridLines="None">
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField HeaderText="Mã Loại" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("MaLoaiCV") %>'></asp:Label>
                                </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên Loại">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%#Eval("TenLoaiCV") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTenLoai" onKeyup="js_Validate(this.value)" runat="server" Text='<%#Eval("TenLoaiCV") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TxtTenLoai" onKeyup="js_Validate(this.value)" runat="server"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="" ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Cập nhật"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Hủy"></asp:LinkButton>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="AddNew"
                                        Text="Thêm mới"></asp:LinkButton>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandArgument='<%#Eval("MaLoaiCV") %>'
                                        CommandName="Edit" Text="Sửa"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete"
                                        Text="Xóa"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                        <SortedAscendingCellStyle BackColor="#FDF5AC" />
                        <SortedAscendingHeaderStyle BackColor="#4D0000" />
                        <SortedDescendingCellStyle BackColor="#FCF6C0" />
                        <SortedDescendingHeaderStyle BackColor="#820000" />
                    </asp:GridView>
                    </center>
          <%--      </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="grvLoaiCV" />
                </Triggers>
            </asp:UpdatePanel>
        </div>--%>
</asp:Content>
