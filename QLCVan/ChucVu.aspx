<%@ Page Title="Chức vụ" Language="C#" MasterPageFile="~/QLCV.Master"
    AutoEventWireup="true" CodeBehind="ChucVu.aspx.cs" Inherits="QLCVan.ChucVu" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <style>
        .page { max-width:1100px; margin:24px auto; padding:0 14px; }
        .page-title { text-align:center; font-size:26px; letter-spacing:.6px; margin:10px 0 18px; }
        .table td,.table th{ vertical-align:middle; }
        .pager a,.pager span{ margin:0 3px; display:inline-block; padding:4px 10px; border:1px solid #ddd; border-radius:4px;}
        .pager .active{ background:#007bff; color:#fff; border-color:#007bff;}
        .search-container { display: flex; }
        .search-container input { margin-right: 10px; }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="page">
        <h4 class="page-title font-weight-bold">DANH SÁCH CHỨC VỤ</h4>

        <div class="row mb-2">
            <div class="col-md-7 d-flex search-container">
                <asp:TextBox runat="server" ID="txtCodeSearch" CssClass="form-control mr-2" placeholder="Nhập mã chức vụ"></asp:TextBox>
                <asp:TextBox runat="server" ID="txtNameSearch" CssClass="form-control mr-2" placeholder="Nhập chức vụ"></asp:TextBox>
                <asp:Button runat="server" ID="btnSearch" Text="Tìm" CssClass="btn btn-outline-primary" OnClick="btnSearch_Click" />
            </div>
            <div class="col-md-5 text-right">
                <asp:Button runat="server" ID="btnOpenCreate" Text="Thêm chức vụ" CssClass="btn btn-primary"
                    OnClientClick="$('#modalPosition').modal('show'); return false;" />
            </div>
        </div>

        <asp:UpdatePanel runat="server" ID="upList">
            <ContentTemplate>
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th style="width:160px">Mã chức vụ</th>
                            <th>Chức vụ</th>
                            <th style="width:230px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptPositions" OnItemCommand="rptPositions_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Code") %></td>
                                    <td><%# Eval("Name") %></td>
                                    <td>
                                        <a class="btn btn-sm btn-primary" href="javascript:void(0)">
                                            <i class="fa fa-shield-halved mr-1"></i>Gán quyền</a>
                                        <asp:LinkButton runat="server" CssClass="btn btn-sm btn-info"
                                            CommandName="edit" CommandArgument='<%# Eval("Id") %>'>
                                            <i class="fa fa-pen-to-square mr-1"></i>Sửa</asp:LinkButton>
                                        <asp:LinkButton runat="server" CssClass="btn btn-sm btn-danger"
                                            OnClientClick="return confirm('Xoá chức vụ này?');"
                                            CommandName="delete" CommandArgument='<%# Eval("Id") %>'>
                                            <i class="fa fa-trash mr-1"></i>Xoá</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div class="pager text-center">
                    <asp:PlaceHolder runat="server" ID="phPager"></asp:PlaceHolder>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <!-- Modal Thêm/Sửa -->
    <div class="modal fade" id="modalPosition" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title"><asp:Literal runat="server" ID="litModalTitle" Text="Thêm chức vụ"></asp:Literal></h5>
            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
          </div>
          <div class="modal-body">
            <asp:HiddenField runat="server" ID="hidId" />
            <div class="form-group">
              <label>Mã chức vụ</label>
              <asp:TextBox runat="server" ID="txtCode" CssClass="form-control" MaxLength="50"></asp:TextBox>
            </div>
            <div class="form-group">
              <label>Chức vụ</label>
              <asp:TextBox runat="server" ID="txtName" CssClass="form-control" MaxLength="150"></asp:TextBox>
            </div>
            <asp:Label runat="server" ID="lbError" CssClass="text-danger"></asp:Label>
          </div>
          <div class="modal-footer">
            <asp:Button runat="server" ID="btnSave" Text="Lưu" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
