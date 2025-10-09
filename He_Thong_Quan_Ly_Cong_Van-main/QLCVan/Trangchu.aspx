<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="Trangchu.aspx.cs" Inherits="QLCVan.Trangchu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            color: #222;
        }

        .section-header {
            font-size: 20px;
            font-weight: bold;
            color: #003366;
            margin-bottom: 10px;
        }

        .search-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin: 20px 0 10px 0;
            gap: 10px;
        }

        .filter-left {
            text-align: left;
            margin: 10px 0 20px 0;
            background: #fff;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            display: inline-block;
        }

        .filter-left label {
            margin-right: 15px;
            font-weight: normal;
            cursor: pointer;
        }

        .notice {
            color: red;
            font-size: 13px;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            font-family: Tahoma, sans-serif;
            font-size: 13px;
            color: #000;
        }

        .gridview th {
            background-color: #c00;
            color: #fff;
            font-weight: bold;
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .gridview td {
            border: 1px solid #ddd;
            padding: 6px 8px;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .gridview tr:hover {
            background-color: #f1f1f1;
        }

        .gridview a {
            color: #0066cc;
            text-decoration: none;
        }

        .gridview a:hover {
            text-decoration: underline;
        }

        .gridview .pager {
            text-align: center;
            padding: 10px 0;
        }

        .gridview .pager a,
        .gridview .pager span {
            display: inline-block;
            margin: 0 4px;
            padding: 4px 8px;
            border-radius: 3px;
            color: #0066cc;
            text-decoration: none;
            border: 1px solid transparent;
        }

        .gridview .pager a:hover {
            border: 1px solid #c00;
            color: #c00;
        }

        .gridview .pager span {
            border: 1px solid #c00;
            background-color: #c00;
            color: #fff;
            font-weight: bold;
        }

        .pager {
            align-items: center;
            text-align: center;
            padding: 10px;
            background: #f1f1f1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="section-header">XEM CÔNG VĂN</div>
    <!-- Thanh chữ chạy -->
    <div style="background: #c00; color: #fff; padding: 6px 10px; font-weight: bold;">
        <marquee behavior="scroll" direction="left" scrollamount="4">
            Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.
        </marquee>
    </div>

<!-- Thanh tìm kiếm (ở giữa) -->
<div class="search-container">
    <asp:TextBox ID="TextBox1" runat="server" placeholder="Nhập số công văn..."
        Style="width: 200px; padding: 6px; border: 1px solid #ccc; border-radius: 3px;" />

    <asp:DropDownList ID="ddlLoai" runat="server"
        Style="padding: 6px; border-radius: 3px; border: 1px solid #ccc;">
        <asp:ListItem Value="">-- Tất cả --</asp:ListItem>
        <asp:ListItem Value="1">Công văn đến</asp:ListItem>
        <asp:ListItem Value="0">Công văn đi</asp:ListItem>
        <asp:ListItem Value="2">Dự thảo</asp:ListItem>
        <asp:ListItem Value="3">Nội bộ</asp:ListItem>
    </asp:DropDownList>

    <asp:TextBox ID="txtFromDate" runat="server" placeholder="Từ ngày"
        TextMode="Date"
        Style="width: 160px; padding: 6px; border: 1px solid #ccc; border-radius: 3px;" />

    <asp:TextBox ID="txtToDate" runat="server" placeholder="Đến ngày"
        TextMode="Date"
        Style="width: 160px; padding: 6px; border: 1px solid #ccc; border-radius: 3px;" />

    <asp:Button ID="Button1" Text="Tìm Kiếm" runat="server"
        OnClick="btnSearch_Click"
        Style="background: #c00; color: #fff; margin-left: 5px; padding: 6px 12px; border: none; border-radius: 3px; cursor: pointer;" />
</div>


   <!-- Checkbox lọc công văn (căn trái, dưới tìm kiếm) -->
<div class="filter-left">
    <asp:CheckBox ID="chkCVDen" runat="server" Text="Công văn đến" AutoPostBack="True"
        OnCheckedChanged="chkCVDen_CheckedChanged" />
    <asp:CheckBox ID="chkCVdi" runat="server" Text="Công văn đi" AutoPostBack="True"
        OnCheckedChanged="chkCVdi_CheckedChanged" />
    <asp:CheckBox ID="chkCVDuThao" runat="server" Text="Dự thảo" AutoPostBack="True"
        OnCheckedChanged="chkCVDuThao_CheckedChanged" />
    <asp:CheckBox ID="chkCVNoiBo" runat="server" Text="Nội bộ" AutoPostBack="True"
        OnCheckedChanged="chkCVNoiBo_CheckedChanged" />
</div>


    <div class="notice">Click vào "Xem" để xem chi tiết</div>

    <!-- Bảng dữ liệu -->
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" CssClass="gridview" AutoGenerateColumns="False"
                Width="100%" AllowPaging="True" PageSize="5"
                OnPageIndexChanging="GridView1_PageIndexChanging1"
                ShowFooter="False" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField SortExpression="SoCV" HeaderText="Số CV">
                        <ItemTemplate>
                            <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'><%#Eval("SoCV") %></a>
                        </ItemTemplate>
                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="NgayGui" HeaderText="Ngày gửi"
                        SortExpression="Ngaygui" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle Width="120px" HorizontalAlign="Center" />
                    </asp:BoundField>

                    <asp:TemplateField SortExpression="TrichyeuND" HeaderText="Trích yếu nội dung">
                        <ItemTemplate>
                            <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'><%#Eval("TrichyeuND") %></a>
                        </ItemTemplate>
                        <ItemStyle Width="300px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Chi tiết" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <a href='CTCV.aspx?id=<%#Eval("MaCV")%>'>Xem</a>
                        </ItemTemplate>
                        <ItemStyle Width="60px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Xóa" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnk_Xoa" runat="server" OnClick="lnk_Xoa_Click"
                                OnClientClick="return confirm('Bạn có chắc chắn muốn xóa công văn này không?')"
                                CommandArgument='<%# Eval("Macv") %>'>Xóa</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Width="60px" />
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pager" />
            </asp:GridView>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="GridView1" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
