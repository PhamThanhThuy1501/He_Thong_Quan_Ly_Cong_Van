<%@ Page Title="" Language="C#" MasterPageFile="~/QLCV.Master" AutoEventWireup="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    .section-title{font-size:26px;font-weight:700;color:#0f172a;text-align:center;margin:20px 0 10px}
    .marquee{font-family:'Segoe UI','Helvetica Neue',Arial,sans-serif;font-size:18px;font-weight:600;color:#fff;background:#c00;padding:8px 0;text-align:center}
    .grid-header-red th{background:#c00!important;color:#fff!important;text-align:center}
    .search-strip{width:60%;margin:0 auto 16px}
    .table-wrapper{width:60%;margin:0 auto}
    .table td,.table th{vertical-align:middle}
    .pagination .page-link{color:#0f172a}
    .pagination .active .page-link{background:#0d6efd;border-color:#0d6efd}
    .cv-head{ font-weight:700; }
.cv-head{ font-weight:700; }

  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="cv">
    <div class="cv-head">QUẢN LÝ NGƯỜI DÙNG</div>

    <!-- Dải chữ chạy đỏ -->
    <div class="marquee">
      <marquee behavior="scroll" direction="left" scrollamount="5">
        Chào mừng bạn đến với hệ thống Quản lý Công Văn điện tử.
      </marquee>
    </div>

    <h3 class="section-title">GÁN QUYỀN CHO TRƯỞNG KHOA</h3>

    <!-- Ô tìm kiếm -->
<div class="search-strip">
  <div class="row g-2 align-items-center">
    <!-- Nhãn Tìm kiếm -->
    <div class="col-md-2 text-md-end">
      <label for="txtTenNhom" class="col-form-label fw-semibold mb-0">Tìm kiếm</label>
    </div>

    <!-- Ô nhập tên nhóm quyền -->
    <div class="col-md-4">
      <input id="txtTenNhom" type="text" class="form-control"
             placeholder="Nhập tên nhóm quyền" aria-label="Tên nhóm quyền" />
    </div>

    <!-- Ô nhập mã nhóm quyền -->
    <div class="col-md-4">
      <input id="txtMaNhom" type="text" class="form-control"
             placeholder="Nhập mã nhóm quyền" aria-label="Mã nhóm quyền" />
    </div>

    <!-- Nút tìm -->
    <div class="col-md-2 text-start">
      <button type="button" class="btn btn-danger">
        <i class="fa fa-search"></i>
      </button>
    </div>
  </div>
</div>


    <!-- Bảng danh sách (UI tĩnh, dữ liệu ví dụ) -->
    <div class="table-wrapper">
      <table class="table table-bordered table-striped table-hover">
        <thead class="grid-header-red">
          <tr>
            <th class="text-center" style="width:20%">Mã nhóm quyền</th>
            <th class="text-center">Tên nhóm quyền</th>
            <th class="text-center" style="width:20%">Thao tác</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="text-center">NV_01</td>
            <td>Quyền nhân viên</td>
            <td class="text-center">
              <button type="button" class="btn btn-primary btn-sm">Gắn</button>
            </td>
          </tr>
          <tr>
            <td class="text-center">TK_01</td>
            <td>Quyền trưởng khoa</td>
            <td class="text-center">
              <button type="button" class="btn btn-outline-secondary btn-sm" disabled>Đã gắn</button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Phân trang kiểu số ở giữa -->
      <nav aria-label="pagination">
        <ul class="pagination justify-content-center mb-4">
          <li class="page-item active"><a class="page-link" href="#">1</a></li>
          <li class="page-item"><a class="page-link" href="#">2</a></li>
        </ul>
      </nav>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </div>
</asp:Content>
