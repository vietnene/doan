-- Đảm bảo bạn đang dùng đúng database
USE QL_BanHang;
GO

-- 1. TẠO BẢNG KHACHHANG
CREATE TABLE KhachHang (
    MaKH INT PRIMARY KEY IDENTITY(1,1), -- Mã khách hàng tự tăng
    TenKH NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255),
    SoDienThoai VARCHAR(15) UNIQUE -- Số điện thoại là duy nhất
);
GO

-- 2. TẠO BẢNG SANPHAM
CREATE TABLE SanPham (
    MaSP INT PRIMARY KEY IDENTITY(1,1), -- Mã sản phẩm tự tăng
    TenSP NVARCHAR(150) NOT NULL,
    DonViTinh NVARCHAR(20),
    DonGia DECIMAL(18, 0) NOT NULL CHECK (DonGia >= 0), -- Giá không được âm
    SoLuongTon INT NOT NULL CHECK (SoLuongTon >= 0) -- Tồn kho không được âm
);
GO

-- 3. TẠO BẢNG HOADON
CREATE TABLE HoaDon (
    MaHD INT PRIMARY KEY IDENTITY(1,1), -- Mã hóa đơn tự tăng
    NgayLap DATE NOT NULL DEFAULT GETDATE(), -- Ngày lập, mặc định là ngày hiện tại
    MaKH INT NOT NULL, -- Khóa ngoại
    MaSP INT NOT NULL, -- Khóa ngoại
    SoLuongMua INT NOT NULL CHECK (SoLuongMua > 0), -- Số lượng mua phải lớn hơn 0
    TongTien DECIMAL(18, 0) NOT NULL,

    -- TẠO RÀNG BUỘC KHÓA NGOẠI
    CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    CONSTRAINT FK_HoaDon_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);
GO

-- Chèn dữ liệu mẫu để kiểm tra
INSERT INTO KhachHang (TenKH, DiaChi, SoDienThoai) VALUES
(N'Nguyễn Văn An', N'123 Đường ABC, Quận 1, TP.HCM', '0909123456'),
(N'Trần Thị Bình', N'456 Đường XYZ, Quận 3, TP.HCM', '0987654321');
GO

INSERT INTO SanPham (TenSP, DonViTinh, DonGia, SoLuongTon) VALUES
(N'Laptop Dell Inspiron', N'Cái', 18000000, 50),
(N'Chuột Logitech M331', N'Cái', 350000, 200),
(N'Bàn phím cơ Fuhlen', N'Cái', 750000, 150);
GO

PRINT 'Tạo CSDL QL_BanHang thành công!';