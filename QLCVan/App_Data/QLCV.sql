Create Database QuanLyCongVan;
GO
USE QuanLyCongVan;
GO

-- Bảng tblLoaiCV
CREATE TABLE tblLoaiCV (
    MaloaiCV INT PRIMARY KEY,
    TenloaiCV NVARCHAR(150) NOT NULL
);

-- Bảng tblNhapNDCV
CREATE TABLE tblNhapNDCV (
    MaCV NVARCHAR(50) PRIMARY KEY,              -- sửa NCHAR -> NVARCHAR
    MaloaiCV INT NOT NULL,
    TieuDeCV NVARCHAR(200) NULL,
    NgayGuiNhan NVARCHAR(20) NULL,
    SoCV NVARCHAR(50) NULL,
    CoQuanBanHanh NVARCHAR(150) NULL,
    NgayBanHanh NVARCHAR(50) NULL,
    TrichYeuND NVARCHAR(200) NULL,
    NguoiKy NVARCHAR(50) NULL,
    NoiNhan NVARCHAR(255) NULL,
    TuKhoa NVARCHAR(255) NULL,
    ButPheLanhDao NVARCHAR(255) NULL,
    GuiHayNhan INT NOT NULL,
    GhiChu NVARCHAR(200) NULL,
    CONSTRAINT FK_tblNhapNDCV_tblLoaiCV FOREIGN KEY (MaloaiCV) REFERENCES tblLoaiCV(MaloaiCV)
);

-- Bảng tblNhom
CREATE TABLE tblNhom (
    MaNhom INT PRIMARY KEY,
    TenNhom NVARCHAR(150) NOT NULL
);

-- Bảng tblNguoiDung
CREATE TABLE tblNguoiDung (
    MaND NVARCHAR(20) PRIMARY KEY,
    Hoten NVARCHAR(100) NOT NULL,
    Matkhau NVARCHAR(50) NOT NULL,
    Email NVARCHAR(200) NULL,
    TenDN NVARCHAR(50) NOT NULL,
    Quyenhan NVARCHAR(100) NULL,
    Trangthai INT NULL
);

-- Bảng tblFileDinhKem
CREATE TABLE tblFileDinhKem (
    FileID INT NOT NULL PRIMARY KEY,
    Url NVARCHAR(250) NOT NULL,
    Size INT NULL,
    Dateupload DATETIME NOT NULL,
    MaCV NVARCHAR(50) NOT NULL,                 -- đồng bộ với tblNhapNDCV
    Mota NVARCHAR(255) NULL,
    Tenfile NVARCHAR(255) NULL,
    CONSTRAINT FK_tblFileDinhKem_tblNhapNDCV FOREIGN KEY (MaCV) REFERENCES tblNhapNDCV(MaCV)
);

-- Bảng tblMenu
CREATE TABLE tblMenu (
    MenuID INT PRIMARY KEY,
    MenuName NVARCHAR(100) NOT NULL,
    MenuUrl NVARCHAR(50) NOT NULL
);

-- Bảng tblNhomND
CREATE TABLE tblNhomND (
    MaND NVARCHAR(20) NOT NULL,
    MaNhom INT NOT NULL,
    PRIMARY KEY (MaND, MaNhom),
    CONSTRAINT FK_tblNhomND_tblNguoiDung FOREIGN KEY (MaND) REFERENCES tblNguoiDung(MaND),
    CONSTRAINT FK_tblNhomND_tblNhom FOREIGN KEY (MaNhom) REFERENCES tblNhom(MaNhom)
);