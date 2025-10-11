<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/QLCV.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* khung tổng thể */
        .cv-wrap{max-width:980px;margin:24px auto 48px auto;}
        .cv-card{background:#fff;border:1px solid #e5e7eb;border-radius:10px;}
        .cv-head{position:relative;padding:18px 22px 0 22px}
        .cv-title{font-weight:700;text-align:center;margin:0 0 14px}
        .cv-badge{position:absolute;right:22px;top:14px;background:green;color:#333;
            border-radius:20px;padding:6px 12px;font-weight:600}

        /* lưới 2 cột */
        .cv-body{padding:18px 22px 22px}
        .grid2{display:grid;grid-template-columns:1fr 1fr;gap:14px 24px}
        @media(max-width:768px){.grid2{grid-template-columns:1fr}}

        /* dòng field (label trái + control phải) */
        .field{display:flex;align-items:center;gap:12px}
        .field .lbl{width:160px;min-width:160px;color:#4b5563;font-weight:600;text-align:left}
        .field .ctl{flex:1}

        /* full width hàng đơn */
        .row-full{grid-column:1/-1}

        /* input/select/textarea look */
        .ipt,.sel,.ta{
            width:100%;box-sizing:border-box;height:38px;padding:6px 10px;border:1px solid #d1d5db;
            border-radius:6px;background:#f8fafc;outline:none
        }
        .ta{min-height:92px;height:auto;resize:none;padding-top:8px;line-height:1.4}
        .ipt[readonly],.sel:disabled,.ta[readonly]{background:#f1f5f9;color:#111827}
        .sel{appearance:none;background-image:
            linear-gradient(45deg, transparent 50%, #6b7280 50%),
            linear-gradient(135deg, #6b7280 50%, transparent 50%),
            linear-gradient(to right, #e5e7eb, #e5e7eb);
            background-position:
            calc(100% - 18px) 16px, calc(100% - 12px) 16px, calc(100% - 36px) 0;
            background-size:6px 6px,6px 6px,1px 100%; background-repeat:no-repeat}
        .sel:disabled{opacity:.8}

        /* radio */
        .radio-wrap{display:flex;align-items:center;gap:14px}
        .radio-wrap .lbl-inline{font-weight:600;color:#4b5563;margin-right:6px}

        /* file line & buttons */
        .file-line i{font-style:italic}
        .muted{color:#6b7280}
        .actions{display:flex;justify-content:flex-end;gap:10px;margin-top:18px}
        .btn{border:none;border-radius:6px;padding:.5rem 1rem;cursor:pointer}
        .btn-ghost{border:1px solid #cbd5e1;background:#f8fafc;color:#475569}
        .btn-info{background:#0d6efd;color:#fff}
        .btn-primary{background:#0d6efd;color:#fff}
        /* --- Tiêu đề khu vực + dải đỏ chạy --- */
.section-wrap{max-width:980px;margin:0 auto 14px auto;}
.section-title{
  margin:0 0 8px 0; font-weight:800; letter-spacing:.3px;
  color:#0b3f79; /* xanh đậm như ảnh */
  text-transform:uppercase;
}
.ticker-strip{
  width:100%; height:34px; background:#c80000; color:#fff; 
  border-radius:2px; overflow:hidden; display:flex; align-items:center;
}
/* dùng lại ticker chạy, canh phải như ảnh */
.ticker-strip .ticker__track{
  white-space:nowrap; display:inline-block; padding-left:100%;
  animation:ticker-move 18s linear infinite;
  font-weight:700;
}
.ticker-strip:hover .ticker__track{ animation-play-state:paused; }
.ticker__item{ padding:0 1.5rem; }
@keyframes ticker-move { 0%{transform:translateX(0)} 100%{transform:translateX(-100%)} }

    </style>
    <!-- Phần tiêu đề + dải đỏ chạy -->
<div class="section-wrap">
  <h5 class="section-title">NHẬP NỘI DUNG CÔNG VĂN</h5>
  <div class="ticker-strip">
    <div class="ticker__track" aria-label="Thông báo chạy">
      <span class="ticker__item">Chào mừng bạn đến với hệ thống quản lý công văn điện tử</span>
     
    </div>
  </div>
</div>


    <div class="cv-wrap">
        <div class="cv-card">
            <div class="cv-head">
                <h5 class="cv-title">CHI TIẾT CÔNG VĂN</h5>
                <span class="cv-badge">Đã duyệt</span>
            </div>

            <div class="cv-body">
                <div class="grid2">
                    <!-- Tiêu đề (full width) -->
                    <div class="row-full field">
                        <div class="lbl">Tiêu đề:</div>
                        <div class="ctl"><input class="ipt" type="text" value="Công văn chiến lược" readonly></div>
                    </div>

                    <!-- Số CV -->
                    <div class="field">
                        <div class="lbl">Số CV:</div>
                        <div class="ctl"><input class="ipt" type="text" value="334-TB/QSQK2" readonly></div>
                    </div>
                    <!-- Loại công văn -->
                    <div class="field">
                        <div class="lbl">Loại công văn:</div>
                        <div class="ctl">
                            <select class="sel" disabled>
                                <option selected>Chiến lược</option>
                                <option>Hành chính</option>
                                <option>Khác</option>
                            </select>
                        </div>
                    </div>

                    <!-- Ngày ban hành -->
                    <div class="field">
                        <div class="lbl">Ngày ban hành:</div>
                        <div class="ctl"><input class="ipt" type="text" value="10/09/2025" readonly></div>
                    </div>
                    <!-- Ngày gửi -->
                    <div class="field">
                        <div class="lbl">Ngày gửi:</div>
                        <div class="ctl"><input class="ipt" type="text" value="10/09/2025" readonly></div>
                    </div>

                    <!-- Cơ quan ban hành -->
                    <div class="field">
                        <div class="lbl">Cơ quan ban hành:</div>
                        <div class="ctl">
                            <select class="sel" disabled>
                                <option selected>Tiểu đoàn 2</option>
                                <option>Phòng Đào tạo</option>
                            </select>
                        </div>
                    </div>
                    <!-- Đơn vị nhận -->
                    <div class="field">
                        <div class="lbl">Đơn vị nhận:</div>
                        <div class="ctl">
                            <select class="sel" disabled>
                                <option selected>Ban giám hiệu</option>
                                <option>Các khoa</option>
                            </select>
                        </div>
                    </div>

                    <!-- Người ký -->
                    <div class="field">
                        <div class="lbl">Người ký:</div>
                        <div class="ctl">
                            <select class="sel" disabled>
                                <option selected>Tiểu đoàn trưởng</option>
                            </select>
                        </div>
                    </div>
                    <!-- Người nhận -->
                    <div class="field">
                        <div class="lbl">Người nhận:</div>
                        <div class="ctl">
                            <select class="sel" disabled>
                                <option selected>Dương Anh Tuấn</option>
                            </select>
                        </div>
                    </div>

                    <!-- Bảo mật -->
                    <div class="field">
                        <div class="lbl">Bảo mật:</div>
                        <div class="ctl radio-wrap">
                            <label><input type="radio" checked disabled> Có</label>
                            <label><input type="radio" disabled> Không</label>
                        </div>
                    </div>

                    <!-- hàng trống để giữ 2 cột cân -->
                    <div></div>

                    <!-- Trích yếu (full width) -->
                    <div class="row-full field">
                        <div class="lbl">Trích yếu:</div>
                        <div class="ctl">
                            <textarea class="ta" readonly>1. Khoa thông báo kế hoạch đồ án đến các Bộ môn
2. Bộ môn tổng hợp số lượng giảng viên, số lượng đề tài có thể/được phép hướng dẫn gửi về Khoa để
lên kế hoạch chung cho cả Khoa</textarea>
                        </div>
                    </div>

                    <!-- Ghi chú (full width) -->
                    <div class="row-full field">
                        <div class="lbl">Ghi chú:</div>
                        <div class="ctl">
                            <textarea class="ta" readonly>Không có ghi chú</textarea>
                        </div>
                    </div>

                    <!-- Tệp đính kèm (full width) -->
                    <div class="row-full field">
                        <div class="lbl">Tệp đính kèm:</div>
                        <div class="ctl file-line">
                            <i><a href="#" target="_blank">ISO-IT13.01Lap ke hoach do an tot nghiep (2016).doc</a></i>
                            <span class="muted"> 38400 MB</span>
                        </div>
                    </div>
                </div>

                <!-- nút hành động -->
                <div class="actions">
                    <button type="button" class="btn btn-ghost">Quay lại</button>
                    <button type="button" class="btn btn-info">chỉnh sửa</button>
                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>
