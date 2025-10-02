USE [master]
GO
/****** Object:  Database [QuanLyCongVan]    Script Date: 20/12/2016 9:35:45 CH ******/
CREATE DATABASE [QuanLyCongVan]
GO
ALTER DATABASE [QuanLyCongVan] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyCongVan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyCongVan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyCongVan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyCongVan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyCongVan] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyCongVan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyCongVan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyCongVan] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QuanLyCongVan]
GO
/****** Object:  FullTextCatalog [FT_QLCV]    Script Date: 20/12/2016 9:35:46 CH ******/
CREATE FULLTEXT CATALOG [FT_QLCV]WITH ACCENT_SENSITIVITY = ON

GO
/****** Object:  StoredProcedure [dbo].[NoiDungCVSelect]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NoiDungCVSelect] 	
	@searchInfo nvarchar(200)
	
AS
BEGIN	
	SET NOCOUNT ON;
with tmp as(
    select * from dbo.tblNoiDungCV
   where Freetext(TieuDeCV, @searchInfo) or Freetext(TrichYeuND, @searchInfo)
			or Freetext(SoCV, @searchInfo))
   select * from tmp
   
END

GO
/****** Object:  Table [dbo].[DanhBaEmail]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhBaEmail](
	[Email] [nvarchar](50) NOT NULL,
	[SoLanGui] [int] NULL,
	[MaPhongBan] [int] NOT NULL,
	[UserName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DanhBaEmail_1] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblFileDinhKem]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFileDinhKem](
	[FileID] [nvarchar](50) NOT NULL,
	[Url] [nvarchar](250) NULL,
	[Size] [int] NULL,
	[DateUpload] [nvarchar](100) NULL,
	[MaCV] [nvarchar](50) NULL,
	[TenFile] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblFileDinhKem] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblGuiNhan]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGuiNhan](
	[MaCV] [nvarchar](50) NOT NULL,
	[MaNguoiDung] [int] NOT NULL,
 CONSTRAINT [PK_tblGuiNhan] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC,
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLoaiCV]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLoaiCV](
	[MaLoaiCV] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiCV] [nvarchar](150) NULL,
 CONSTRAINT [PK_tblLoaiCV] PRIMARY KEY CLUSTERED 
(
	[MaLoaiCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMenu]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMenu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](50) NULL,
	[MenuURL] [nvarchar](50) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNguoiDung]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNguoiDung](
	[MaNguoiDung] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[TenDN] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](50) NULL,
	[QuyenHan] [nchar](20) NULL,
	[TrangThai] [int] NULL,
	[HoTen] [nvarchar](100) NULL,
	[MaNhom] [int] NOT NULL,
 CONSTRAINT [PK_tblNguoiDung] PRIMARY KEY CLUSTERED 
(
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNhom]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhom](
	[MaNhom] [int] IDENTITY(1,1) NOT NULL,
	[MoTa] [nvarchar](200) NULL,
 CONSTRAINT [PK_tblNhom] PRIMARY KEY CLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNhomNguoiDung]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhomNguoiDung](
	[MaNguoiDung] [nvarchar](20) NOT NULL,
	[MaNhom] [int] NOT NULL,
 CONSTRAINT [PK_tblNhomNguoiDung] PRIMARY KEY CLUSTERED 
(
	[MaNguoiDung] ASC,
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNoiDungCV]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNoiDungCV](
	[MaCV] [nvarchar](50) NOT NULL,
	[MaLoaiCV] [int] NULL,
	[TieuDeCV] [nvarchar](200) NULL,
	[NgayGui] [datetime] NULL,
	[SoCV] [nvarchar](200) NULL,
	[CoQuanBanHanh] [nvarchar](300) NULL,
	[NgayBanHanh] [datetime] NULL,
	[TrichYeuND] [nvarchar](500) NULL,
	[NguoiKy] [nvarchar](30) NULL,
	[NoiNhan] [nvarchar](255) NULL,
	[TuKhoa] [nvarchar](255) NULL,
	[TrangThai] [bit] NULL,
	[GuiHayNhan] [int] NULL CONSTRAINT [DF_tblNoiDungCV_GuiHayNhan]  DEFAULT ((1)),
	[GhiChu] [nvarchar](200) NULL,
 CONSTRAINT [PK_tblNoiDungCV] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPhongBan]    Script Date: 20/12/2016 9:35:46 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPhongBan](
	[MaPhongBan] [int] NOT NULL,
	[TenPhongBan] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblPhongBan] PRIMARY KEY CLUSTERED 
(
	[MaPhongBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'1ff9f297-07df-4431-9fb3-7ffad6ea010f', N'~/Upload/ISO-IT13.01.Lap ke hoach do an tot nghiep (2013).doc', 38400, N'6/15/2014', N'931de876-1832-4def-9fab-876edfffc416', N'ISO-IT13.01.Lap ke hoach do an tot nghiep (2016).doc')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'2f121dd6-6739-4094-8646-0d4cf1d09cbc', N'~/Upload/698-QD-TTg (1).DOC', 83456, N'6/17/2014', N'fc693150-0bdf-484d-aa77-f8c6f225997b', N'698-QD-TTg (1).DOC')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'61eac80e-02b6-4060-8fe8-7caa034ef6cc', N'~/Upload/2013-6-23-0-16-38. hoi thao khoa hoc 2.jpg', 121638, N'6/23/2013', N'ef837c0d-514c-4d25-9247-8a19ad07a59d', N'hoi thao khoa hoc 2.jpg')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'75e20aaf-9413-4cd4-bddc-e41365751712', N'~/Upload/54-TB-BGDDT.doc', 90112, N'6/24/2013', N'2582599b-48f7-4722-ba38-334cc5101023', N'54-TB-BGDDT.doc')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'79ac5a46-95cc-4339-9040-3f7cc724eb8a', N'~/Upload/2012-12-27-22-29-14. Huong dan su dung.doc', NULL, N'Dec 27 2012 10:29PM', N'dac60048-bd24-4148-90d7-224de4c1abfc', N'Huong dan su dung.doc')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'8b4cebd7-f7d0-45d5-a2be-519456025fe8', N'~/Upload/2013-6-22-21-51-43. File 33.bmp', 121638, N'6/22/2013', N'ef91791d-644a-4d4f-abcc-b8675c0135cc', N'File 33.bmp')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'a92d9466-1aae-4027-81b2-d81cb2ea4465', N'~/Upload/2013-6-22-23-56-21. hs thieu thu tuc thi 309.jpg', 100928, N'6/22/2013', N'fd6bfece-3f60-4c58-b7ce-97e377fcbbe9', N'hs thieu thu tuc thi 309.jpg')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'b5e1feb3-a9bd-4e53-a887-44c1c5a91aac', N'~/Upload/698-QD-TTg.DOC', 83456, N'6/24/2013', N'1aab3690-8d20-4e8f-bc36-041537685123', N'698-QD-TTg.DOC')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'c276cb7f-be1d-4e32-bae7-f2dfcb895b22', N'~/Upload/2009-05-25 To trinh ve to chuc chuong trinh giao luu chao mung ACCP.doc', 68096, N'6/23/2013', N'd85abed5-604d-47f7-a74e-e3a74f531065', N'2009-05-25 To trinh ve to chuc chuong trinh giao luu chao mung ACCP.doc')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'da2693eb-f3a4-472c-a5ce-71bc77546fc6', N'~/Upload/homthutruongthpt.doc', 44032, N'6/23/2013', N'd85abed5-604d-47f7-a74e-e3a74f531065', N'homthutruongthpt.doc')
INSERT [dbo].[tblFileDinhKem] ([FileID], [Url], [Size], [DateUpload], [MaCV], [TenFile]) VALUES (N'fe936758-ade3-44ae-a940-90a5aba3d14e', N'~/Upload/Thong bao ve trien khai do an 5 mon hoc Ky 1 nam hoc 2013-2014 .docx', 28698, N'11/5/2013', N'3109b74f-bd8a-4549-b045-22f15316151e', N'Thong bao ve trien khai do an 5 mon hoc Ky 1 nam hoc 2013-2014 .docx')
SET IDENTITY_INSERT [dbo].[tblLoaiCV] ON 

INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (2, N'Loại khác')
INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (3, N'Thông báo')
INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (4, N'Đề nghị')
INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (7, N'Quy Chế')
INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (9, N'Nghị quyết')
INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (10, N'Báo cáo')
INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (12, N'Thông tư')
INSERT [dbo].[tblLoaiCV] ([MaLoaiCV], [TenLoaiCV]) VALUES (13, N'Tờ trình')
SET IDENTITY_INSERT [dbo].[tblLoaiCV] OFF
SET IDENTITY_INSERT [dbo].[tblMenu] ON 

INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (1, N'Giới thiệu', N'Gioithieu.aspx')
INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (2, N'Xem công văn', N'Trangchu.aspx')
INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (3, N'Nhập nội dung công văn', N'NhapNDCV.aspx')
INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (4, N'Quản lý loại công văn', N'LoaiCV.aspx')
INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (5, N'Quản lý người dùng', N'QLnguoidung.aspx')
INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (6, N'Quản lý nhóm', N'QLNhom.aspx')
INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (7, N'Tìm kiếm công văn', N'Timkiem.aspx')
INSERT [dbo].[tblMenu] ([MenuID], [MenuName], [MenuURL]) VALUES (9, N'Danh bạ Email', N'DanhBaEmail.aspx')
SET IDENTITY_INSERT [dbo].[tblMenu] OFF
INSERT [dbo].[tblNguoiDung] ([MaNguoiDung], [Email], [TenDN], [MatKhau], [QuyenHan], [TrangThai], [HoTen], [MaNhom]) VALUES (N'05', N'quyen@gmail.com', N'quyen', N'123456', N'Admin               ', 0, N'Phan Thị Minh Quyên', 14)
SET IDENTITY_INSERT [dbo].[tblNhom] ON 

INSERT [dbo].[tblNhom] ([MaNhom], [MoTa]) VALUES (5, N'Công nghệ phần mềm')
INSERT [dbo].[tblNhom] ([MaNhom], [MoTa]) VALUES (6, N'Mạng máy tính')
INSERT [dbo].[tblNhom] ([MaNhom], [MoTa]) VALUES (7, N'Kỹ thuật máy tính')
INSERT [dbo].[tblNhom] ([MaNhom], [MoTa]) VALUES (11, N'Trưởng bộ môn')
INSERT [dbo].[tblNhom] ([MaNhom], [MoTa]) VALUES (13, N'Trưởng khoa')
INSERT [dbo].[tblNhom] ([MaNhom], [MoTa]) VALUES (14, N'Giáo vụ')
SET IDENTITY_INSERT [dbo].[tblNhom] OFF
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'1aab3690-8d20-4e8f-bc36-041537685123', 3, N'Quyết định về việc thành lập Ban tổ chức cuộc thi Sáng tạo Robot 2012', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'334/TB-ĐHSPKTHY', N'Trường ĐH SPKT Hưng Yên', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'1. Với năm thứ 1: Sinh viên được xét học năm thứ 2 nếu đủ điều kiện: Có điểm TBC học tập từ 5,0 trở lên; Có không quá 5 học phần có điểm học phần dưới 5,0 nhưng lơn hơn 3,5
2. Với năm thứ 2: Sinh viên được xét học năm thứ 3 nếu đủ điều kiện: Có điểm TBC học tập từ 5,0 trở lên; Có không quá 5 học phần có điểm học phần dưới 5,0 nhưng lơn hơn 3,5; SV phải hoàn thành chứng chỉ CNTT và vượt qua kỳ thi test ngoại ngữ định kỳ; SV phải hoàn thành đủ chứng chỉ chuyên môn do khoa quy định', N'Nguyễn Minh Quý', N'', NULL, 1, 0, N'Không')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'2582599b-48f7-4722-ba38-334cc5101023', 2, N'Thông báo về việc hỗ trợ tiền mặt cho cán bộ, giảng viên được phong hàm GS, PGS', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'123/QĐ-ĐHSPKTHY', N'Trường ĐH SPKT Hưng Yên', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Từ năm 2012 những cán bộ GV được nhà nước phong hàm GS, PGS mà hồ sơ đề nghị phong học hàm từ trường ĐH SPKT Hưng Yên sẽ được nhà trường hỗ trợ bằng tiền mặt với mức 30 triệu đồng đối với người được phong hàm PGS và 50 triệu đồng với người được phong học hàm GS', N'Nguyễn Minh Quý', N'', NULL, 1, 0, N'Khổng')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'3109b74f-bd8a-4549-b045-22f15316151e', 7, N'Quy chế về việc thành lập Ban tổ chức cuộc thi Sáng tạo Robot 2012', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'554/TB-ĐHSPKTHY', N'Trường ĐH SPKT Hưng Yên', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Từ năm 2012 những cán bộ GV được nhà nước phong hàm GS, PGS mà hồ sơ đề nghị phong học hàm từ trường ĐH SPKT Hưng Yên sẽ được nhà trường hỗ trợ bằng tiền mặt với mức 30 triệu đồng đối với người được phong hàm PGS và 50 triệu đồng với người được phong hihihi hahaaaa', N'Nguyễn Minh Quý', N'', NULL, 1, 1, N'Không')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'68017546-54e1-45d2-b913-fe1968fe8478', 2, N'abcabc', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'11/NQ/ĐHSPKTHY', N'aaaa', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'aaaaaaaaaaaaaa', NULL, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'931de876-1832-4def-9fab-876edfffc416', 12, N'Công tác chuẩn bị bảo vệ đồ án 2014', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'TT125/ĐHSPKTHY', N'ĐHSPKTHY', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'1.	Khoa thông báo kế hoạch đồ án đến các Bộ môn
2.	Bộ môn tổng hợp số lượng giáo viên, số lượng đề tài có thể/được phép hướng dẫn gửi về Khoa để lên kế hoạch chung cho cả Khoa

', N'Nguyễn Minh Quý', N'', NULL, 0, 0, N'')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'd85abed5-604d-47f7-a74e-e3a74f531065', 2, N'Quyết định về việc thành lập Ban tổ chức cuộc thi Sáng tạo Robot 2012', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'334/TB-ĐHSPKTHY', N'Trường ĐH SPKT Hưng Yên', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Quyết định thành lập "Ban tổ chức cuộc thi Sáng tạo Robot 2012 Trường ĐHSP KT Hưng Yên".', N'Nguyễn Minh Quý', N'', NULL, 1, 0, N'')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'dac60048-bd24-4148-90d7-224de4c1abfc', 3, N'Thông báo về việc tổ chức tập huấn GVCN và Lớp trưởng các lớp HSSV năm học 2010 - 2011', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'TB8', N'Trường ĐH SPKT Hưng Yên', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Phòng TT&CTSV đề nghị các khoa, trung tâm thống kê kết quả học tập, rèn luyện học kỳ II năm học 2009 - 2010 theo mẫu nộp về phòng TT&CTSV chậm nhất vào thứ 2 ngày 18/10/2010', N'Nguyễn Văn Quyết', N'', N'', 1, 1, N'')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'de6fd709-242d-4882-9ba9-9a079f968b5e', 3, N'Thông báo về việc thu tiền vệ sinh giảng đường', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'TB123/DHSPKTHY', N'ĐHSPKTHY', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Thông báo về việc thu tiền vệ sinh giảng đường hạn cuối là vào 30/6/2014. Yêu nộp đúng hạn và đầy đủ', N'Nguyễn Minh Quý', N'', NULL, 1, 0, N'')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'ef837c0d-514c-4d25-9247-8a19ad07a59d', 3, N'Thông báo về việc thực hiện chuẩn đầu ra', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'667/QĐ-ĐHSPKT', N'Trường ĐH SPKT Hưng Yên', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Ngoài nội dung trong chương trình đào tạo, để đạt chuẩn đầu ra theo quy định của nhà trường với mục tiêu tăng cường năng lực, sinh viên cần hoàn thành:
       1. Các chứng chỉ chung bắt buộc cho toàn trường: Toeic cho sinh viên các ngành không chuyên ngữ, IELTS cho sinh viên chuyên ngữ; B ++ cho các ngành không chuyên tin.
        2. Các chứng chỉ chuyên môn bắt buộc: Đại học tối đa 3 chứng chỉ, cao đẳng tối đa 2 chứng ch', N'Nguyễn Minh Quý', N'', NULL, 1, 0, N'')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'ef91791d-644a-4d4f-abcc-b8675c0135cc', 7, N'Thông báo V/v tổ chức họp đánh giá kết quả thực hiện chỉ thị số 296/CT-TTg của Thủ tướng chính phủ và Chương trình hành động của Bộ GD&ĐT về đổi mới quản lý giáo dục đại học giai đoạn 2010 - 2012', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'324/TB-ĐHSPKTHY', N'Trường ĐH SPKT Hưng Yên', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Tổ chức họp đánh giá kết quả thực hiện việc đổi mới quản lý giáo dục trong năm 2010 - 2011; Bổ sung nội dung, xây dựng giải pháp thực hiện chương trình hành động nhằm thực hiện tốt chỉ thị số 296/CT-TTg ngày 27/02/2010 của Thủ tướng chính phủ; Các đề xuất, kiến nghị; Các đơn vị họp và nộp biên bản gốc ghi tại buổi họp về phòng Tổ chức Cán bộ trước ngày 26/8/2011', N'Nguyễn Minh Quý', N'', NULL, 1, 1, N'Không')
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'fc693150-0bdf-484d-aa77-f8c6f225997b', 9, N'Thông báo về việc thu tiền vệ sinh giảng đường', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'99/NQ/ĐHSPKTHY', N'', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'Thông báo về việc thu tiền vệ sinh giảng đường', NULL, N'', NULL, 0, 0, NULL)
INSERT [dbo].[tblNoiDungCV] ([MaCV], [MaLoaiCV], [TieuDeCV], [NgayGui], [SoCV], [CoQuanBanHanh], [NgayBanHanh], [TrichYeuND], [NguoiKy], [NoiNhan], [TuKhoa], [TrangThai], [GuiHayNhan], [GhiChu]) VALUES (N'fd6bfece-3f60-4c58-b7ce-97e377fcbbe9', 2, N'Thông báo về việc thu tiền vệ sinh giảng đường', CAST(N'2016-05-11 00:00:00.000' AS DateTime), N'100/QĐ-ĐHSPKT', N'Trường ĐH SPKT Hưng Yên', CAST(N'2013-01-01 00:00:00.000' AS DateTime), N'Căn cứ vào biên bản cuộc họp ngày 17/8/2011 giữa lãnh đạo trường với trưởng các phòng, ban, cơ sở 2 & 3 về việc thu các khoản tiền trong năm 2011 - 2012: Thống nhất mức thu 40.000 đồng/HSSV/1 năm học.', N'Nguyễn Minh Quý', N'', NULL, 0, 0, N'Không')
INSERT [dbo].[tblPhongBan] ([MaPhongBan], [TenPhongBan]) VALUES (1, N'CNTT')
INSERT [dbo].[tblPhongBan] ([MaPhongBan], [TenPhongBan]) VALUES (2, N'Kinh Tế')
INSERT [dbo].[tblPhongBan] ([MaPhongBan], [TenPhongBan]) VALUES (3, N'Cơ Bản')
INSERT [dbo].[tblPhongBan] ([MaPhongBan], [TenPhongBan]) VALUES (4, N'Cơ Khí')
INSERT [dbo].[tblPhongBan] ([MaPhongBan], [TenPhongBan]) VALUES (5, N'Khác')
ALTER TABLE [dbo].[DanhBaEmail]  WITH CHECK ADD  CONSTRAINT [FK_DanhBaEmail_tblPhongBan] FOREIGN KEY([MaPhongBan])
REFERENCES [dbo].[tblPhongBan] ([MaPhongBan])
GO
ALTER TABLE [dbo].[DanhBaEmail] CHECK CONSTRAINT [FK_DanhBaEmail_tblPhongBan]
GO
ALTER TABLE [dbo].[tblFileDinhKem]  WITH CHECK ADD  CONSTRAINT [FK_tblFileDinhKem_tblNoiDungCV] FOREIGN KEY([MaCV])
REFERENCES [dbo].[tblNoiDungCV] ([MaCV])
GO
ALTER TABLE [dbo].[tblFileDinhKem] CHECK CONSTRAINT [FK_tblFileDinhKem_tblNoiDungCV]
GO
ALTER TABLE [dbo].[tblGuiNhan]  WITH CHECK ADD  CONSTRAINT [FK_tblGuiNhan_tblNoiDungCV] FOREIGN KEY([MaCV])
REFERENCES [dbo].[tblNoiDungCV] ([MaCV])
GO
ALTER TABLE [dbo].[tblGuiNhan] CHECK CONSTRAINT [FK_tblGuiNhan_tblNoiDungCV]
GO
ALTER TABLE [dbo].[tblNhomNguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_tblNhomNguoiDung_tblNguoiDung] FOREIGN KEY([MaNguoiDung])
REFERENCES [dbo].[tblNguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[tblNhomNguoiDung] CHECK CONSTRAINT [FK_tblNhomNguoiDung_tblNguoiDung]
GO
ALTER TABLE [dbo].[tblNhomNguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_tblNhomNguoiDung_tblNhom] FOREIGN KEY([MaNhom])
REFERENCES [dbo].[tblNhom] ([MaNhom])
GO
ALTER TABLE [dbo].[tblNhomNguoiDung] CHECK CONSTRAINT [FK_tblNhomNguoiDung_tblNhom]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=gui, 1=nhan' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblNoiDungCV', @level2type=N'COLUMN',@level2name=N'GuiHayNhan'
GO
USE [master]
GO
ALTER DATABASE [QuanLyCongVan] SET  READ_WRITE 
GO
