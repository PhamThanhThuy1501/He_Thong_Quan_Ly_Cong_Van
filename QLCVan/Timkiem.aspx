<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="Timkiem.aspx.cs" Inherits="QLCVan.Timkiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Thêm Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h3 class="text-center mb-4 fw-bold">TÌM KIẾM CÔNG VĂN</h3>

        <!-- Loại văn bản -->
        <div class="row mb-3 text-center">
            <div class="col">
                <asp:RadioButton ID="rdoTatCa" runat="server" Text="Tất cả" AutoPostBack="True" GroupName="Search"
                    OnCheckedChanged="rdoTatCa_CheckedChanged" CssClass="form-check-inline" />
                <asp:RadioButton ID="rdpCVDen" runat="server" Text="CV Đến" AutoPostBack="True" GroupName="Search"
                    OnCheckedChanged="rdpCVDen_CheckedChanged" CssClass="form-check-inline" />
                <asp:RadioButton ID="rdoCVdi" runat="server" Text="CV Đi" AutoPostBack="True" GroupName="Search"
                    OnCheckedChanged="rdoCVdi_CheckedChanged" CssClass="form-check-inline" />
                <asp:RadioButton ID="RadioButton1" runat="server" Text="Dự thảo" AutoPostBack="True" GroupName="Search"
                    OnCheckedChanged="rdoCVdi_CheckedChanged" CssClass="form-check-inline" />
                <asp:RadioButton ID="RadioButton2" runat="server" Text="Nội Bộ" AutoPostBack="True" GroupName="Search"
                    OnCheckedChanged="rdoCVdi_CheckedChanged" CssClass="form-check-inline" />
            </div>
        </div>

        <!-- Form tìm kiếm -->
        <div class="row g-3 mb-3">
            <div class="col-md-3">
                <label class="form-label">Loại Công Văn</label>
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col-md-3">
                <label class="form-label">Cơ quan ban hành</label>
                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col-md-3">
                <label class="form-label">Năm ban hành</label>
                <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col-md-3">
                <label class="form-label">Số lượng kết quả</label>
                <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-select">
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem Selected="True">50</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="row g-3 mb-3">
            <div class="col-md-9">
                <label class="form-label">Nội dung</label>
                <asp:TextBox ID="txtNoiDung" runat="server" CssClass="form-control" placeholder="Nhập nội dung..."></asp:TextBox>
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <asp:Button ID="Button1" runat="server" Text="Tìm kiếm" CssClass="btn btn-primary w-100" OnClick="Button1_Click" />
            </div>
        </div>

        <!-- Bảng kết quả -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:GridView ID="gvTimkiem" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover text-center"
                    PageSize="10" AllowPaging="True" OnPageIndexChanging="gvTimkiem_PageIndexChanging">

                    <Columns>
                        <asp:BoundField DataField="SoCV" HeaderText="Số CV" />
                        <asp:BoundField DataField="TieudeCV" HeaderText="Tiêu đề" />
                        <asp:BoundField DataField="TrichyeuND" HeaderText="Trích yếu" />
                        <asp:TemplateField HeaderText="Chi tiết">
                            <ItemTemplate>
                                <a href='CTCV.aspx?id=<%#Eval("MaCV")%>' class="btn btn-sm btn-info text-white">Xem</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Xóa">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_Xoa" runat="server" CssClass="btn btn-sm btn-danger"
                                    OnClick="lnk_Xoa_Click" CommandArgument='<%# Eval("Macv") %>'
                                    OnClientClick="return confirm('Bạn có chắc chắn muốn xóa công văn này không?');">Xóa</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
