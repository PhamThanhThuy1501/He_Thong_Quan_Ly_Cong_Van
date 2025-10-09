<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true"
    CodeBehind="NhapNDCV.aspx.cs" Inherits="QLCVan.NhapNDCV" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        body {
            background-color: #f8f9fa;
        }

    .welcome-banner {
        background-color: #d60000; /* đỏ đậm */
        width: 100%;
        height: 36px;
        font-weight: 500;
    }

        .card {
            border-radius: 10px;
            overflow: hidden;
        }

        .card-header {
            letter-spacing: 0.5px;
        }

        .table td {
            vertical-align: middle;
        }

        .alert-info {
            background-color: #e8f4ff;
            border: 1px solid #b6e0ff;
        }


        .form-control,
        .form-select {
            border-radius: 8px;
        }

        .input-group .btn {
            border-radius: 0 8px 8px 0 !important;
        }

        .btn {
            border-radius: 8px;
        }

        .table-borderless td {
            border: none;
        }

        .fw-semibold {
            color: #212529;
            font-weight: 600;
        }

        .fa-solid {
            color: #0d6efd;
        }

        textarea {
            resize: none;
        }
</style>

    <script src="Scripts/datepicker/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Scripts/datepicker/jquery-ui.js" type="text/javascript"></script>
    <link href="Scripts/datepicker/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script type="text/javascript">
        jQuery(function ($) {
            $.datepicker.regional['vi'] = {
                closeText: 'Đóng', prevText: '&#x3c;Trước', nextText: 'Tiếp&#x3e;', currentText: 'Hôm nay',
                monthNames: ['Tháng Một', 'Tháng Hai', 'Tháng Ba', 'Tháng Tư', 'Tháng Năm', 'Tháng Sáu', 'Tháng Bảy', 'Tháng Tám', 'Tháng Chín', 'Tháng Mười', 'Th.Mười Một', 'Th.Mười Hai'],
                monthNamesShort: ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12'],
                dayNames: ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'],
                dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                weekHeader: 'Tu', dateFormat: 'dd/mm/yy', firstDay: 0, isRTL: false, showMonthAfterYear: false, yearSuffix: ''
            };
            $.datepicker.setDefaults($.datepicker.regional['vi']);
            $('#<%= txtngayracv.ClientID %>').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
            $('#<%= txtngaynhancv.ClientID %>').datepicker({ changeMonth: true, changeYear: true, yearRange: '2000:2040' });
        });
        function confirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa file đã chọn không?");
        }
    </script>
    <!-- test -->
    <!-- FORM -->
<div class="container my-3">
    <h5 class="fw-bold text-primary mb-3">NHẬP NỘI DUNG CÔNG VĂN</h5>

    <div class="welcome-banner text-white px-4 d-flex justify-content-end align-items-center mb-4">
        <span>Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.</span>
    </div>

    <div class="card shadow-sm border-0 rounded-4">
        <div class="card-header bg-danger text-white text-center fw-bold">
            THÊM MỚI CÔNG VĂN
        </div>
        <div class="card-body px-4 py-4">

            <!-- Tiêu đề -->
            <div class="row mb-3 align-items-center">
                <label class="col-md-2 fw-semibold text-nowrap">
                    Tiêu đề
                </label>
                <div class="col-md-10">
                    <asp:TextBox ID="txttieude" CssClass="form-control" runat="server" placeholder="Nhập tiêu đề văn bản..." />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txttieude" ErrorMessage="* Nhập tiêu đề" CssClass="text-danger small" />
                </div>
            </div>

            <!-- Số công văn + Tên loại công văn -->
            <div class="row mb-3 align-items-center">
                <label class="col-md-2 fw-semibold text-nowrap">
                    Số công văn
                </label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtsocv" CssClass="form-control" runat="server" placeholder="VD: 334/TB-ĐHSPKTHY" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtsocv" ErrorMessage="* Nhập số công văn" CssClass="text-danger small" />
                </div>

                <label class="col-md-2 fw-semibold text-nowrap">
                    Tên loại công văn
                </label>

                <div class="col-md-4">
                    <asp:TextBox ID="txtloaiCV" CssClass="form-control" runat="server" placeholder="Nhập loại công văn" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtloaiCV" ErrorMessage="* Nhập loại công văn" CssClass="text-danger small" />
                </div>
            </div>

            <!-- Cơ quan ban hành + Loại công văn -->
            <div class="row mb-3 align-items-center">
                <label class="col-md-2 fw-semibold text-nowrap">
                    Cơ quan ban hành
                </label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtcqbh" CssClass="form-control" runat="server" placeholder="Tên cơ quan ban hành" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtcqbh" ErrorMessage="* Nhập cơ quan ban hành" CssClass="text-danger small" />
                </div>

                <label class="col-md-2 fw-semibold text-nowrap">
                    Loại công văn
                </label>

                <div class="col-md-4">
                    <asp:DropDownList ID="ddlLoaiCV" CssClass="form-select" runat="server">
                        <asp:ListItem Text="-- Chọn loại --" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlLoaiCV" InitialValue="" ErrorMessage="* Chọn loại công văn" CssClass="text-danger small" />
                </div>
            </div>

            <!-- Ngày ban hành + Ngày kết thúc -->
            <div class="row mb-3 align-items-center">
                <label class="col-md-2 fw-semibold text-nowrap">
                    Ngày ban hành
                </label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtngayracv" CssClass="form-control" runat="server" placeholder="dd/mm/yyyy" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtngayracv" ErrorMessage="* Nhập ngày ban hành" CssClass="text-danger small" />
                </div>

                <label class="col-md-2 fw-semibold text-nowrap">
                    Ngày kết thúc
                </label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtngaynhancv" CssClass="form-control" runat="server" placeholder="dd/mm/yyyy" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtngaynhancv" ErrorMessage="* Nhập ngày kết thúc" CssClass="text-danger small" />
                </div>
            </div>

            <!-- Trích yếu -->
            <div class="row mb-3 align-items-center">
                <label class="col-md-2 fw-semibold text-nowrap">
                    Trích yếu
                </label>
                <div class="col-md-10">
                    <textarea id="txttrichyeu" runat="server" rows="4" class="form-control" placeholder="Tóm tắt nội dung văn bản..."></textarea>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txttrichyeu" ErrorMessage="* Nhập trích yếu" CssClass="text-danger small" />
                </div>
            </div>

            <!-- File nếu có -->
            <div class="row mb-3 align-items-center">
                <label class="col-md-2 fw-semibold text-nowrap">
                    File (nếu có)
                </label>
                <div class="col-md-10">
                    <div class="input-group">
                        <asp:FileUpload ID="FileUpload1" CssClass="form-control" runat="server" AllowMultiple="true" />
                        <asp:Button ID="btnUpload" runat="server" CssClass="btn btn-outline-primary" Text="Upload" OnClick="btnUpload_Click" CausesValidation="False" />
                    </div>
                    <asp:Label ID="lblchuachonfile" runat="server" Text="" CssClass="text-secondary small ms-1"></asp:Label>
                </div>
            </div>

            <!-- Danh sách file -->
            <div class="row mb-3 align-items-center">
                <label class="col-md-2 fw-semibold text-nowrap">
                    Danh sách file
                </label>
                <div class="col-md-10">
                    <asp:ListBox ID="ListBox1" runat="server" CssClass="form-control mb-2" Height="140px" SelectionMode="Multiple" />
                    <div class="d-flex justify-content-end">
                        <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" Text="Xóa" OnClientClick="return confirm('Bạn có chắc muốn xóa file này không?');" OnClick="btnDelete_Click" CausesValidation="False" />
                    </div>
                    <asp:Label ID="lblloi" runat="server" Text="" CssClass="text-danger small mt-2 d-block"></asp:Label>
                </div>
            </div>

            <!-- Nút hành động -->
            <div class="d-flex justify-content-center gap-2 mt-3">
                <asp:Button ID="btnthem" runat="server" CssClass="btn btn-success px-4" Text="Thêm" OnClick="btnthem_Click" />
                <asp:Button ID="btnlammoi" runat="server" CssClass="btn btn-secondary px-4" Text="Làm mới" OnClick="btnlammoi_Click" CausesValidation="False" />
                <asp:Button ID="btnsua" runat="server" CssClass="btn btn-primary px-4" Text="Lưu" OnClick="btnsua_Click" />
            </div>

        </div>
    </div>
</div>

    <!-- GRID -->
    <div class="grid-wrap">
        <div class="grid-title">TẤT CẢ CÁC CÔNG VĂN</div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:GridView ID="gvnhapcnden" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="vb-table"
                    CellPadding="4"
                    Width="100%"
                    AllowPaging="True"
                    PageSize="4"
                    OnPageIndexChanging="gvnhapcnden_PageIndexChanging"
                    OnSelectedIndexChanged="gvnhapcnden_SelectedIndexChanged"
                    GridLines="None">

                    <AlternatingRowStyle BackColor="White" />

                    <Columns>
                        <asp:TemplateField HeaderText="Số công văn">
                            <ItemTemplate>
                                <%# Eval("SOCV") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tiêu đề">
                            <ItemTemplate>
                                <%# Eval("TieudeCV") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Loại công văn">
                            <ItemTemplate>
                                <%# Eval("TenLoaiCV") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Ngày ban hành">
                            <ItemTemplate>
                                <%# Eval("NgayGui", "{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Trích yếu ND">
                            <ItemTemplate>
                                <div class="vb-summary"><%# Eval("TrichYeuND") %></div>
                                <div class="vb-attach">
                                    <i class="fa fa-file-pdf-o"></i>
                                    <a href="#">Tài liệu đính kèm</a>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sửa" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_Sua" runat="server"
                                    CausesValidation="False"
                                    OnClick="lnk_Sua_Click"
                                    CommandArgument='<%# Eval("MaCV") %>'>
                                Sửa
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Xóa" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_Xoa" runat="server"
                                    CausesValidation="False"
                                    OnClick="lnk_Xoa_Click"
                                    OnClientClick="return confirm('Bạn có chắc chắn muốn xóa công văn này không?')"
                                    CommandArgument='<%# Eval("MaCV") %>'>
                                Xóa
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                </asp:GridView>
            </ContentTemplate>

            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="gvnhapcnden" EventName="PageIndexChanging" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
