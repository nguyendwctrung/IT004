﻿CREATE DATABASE QuanLyBanHang_DB

USE QuanLyBanHang_DB

CREATE TABLE KHACHHANG
(
	MAKH CHAR(4) NOT NULL,
	HOTEN VARCHAR(40),
	DCHI VARCHAR(50),
	SODT VARCHAR(20),
	NGSINH smalldatetime,
	DOANHSO money,
	NGDK smalldatetime
)

CREATE TABLE NHANVIEN
(
	MANV CHAR(4) NOT NULL,
	HOTEN VARCHAR(40),
	SODT VARCHAR(20),
	NGVL smalldatetime
)

CREATE TABLE SANPHAM
(
	MASP CHAR(4) NOT NULL,
	TENSP VARCHAR(40),
	DVT VARCHAR(20),
	NSX VARCHAR(40),
	GIA money
)

CREATE TABLE HOADON
(
	SOHD int NOT NULL,
	NGHD smalldatetime,
	MAKH CHAR(4),
	MANV CHAR(4),
	TRIGIA money
)

CREATE TABLE CTHD
(
	SOHD int NOT NULL,
	MASP CHAR(4) NOT NULL,
	SL int
)

--Tạo khóa chính--
ALTER TABLE NHANVIEN ADD CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV)
ALTER TABLE KHACHHANG ADD CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH)
ALTER TABLE SANPHAM ADD CONSTRAINT PK_SANPHAM PRIMARY KEY (MASP)
ALTER TABLE HOADON ADD CONSTRAINT PK_HOADON PRIMARY KEY (SOHD)
ALTER TABLE CTHD ADD CONSTRAINT PK_CTHD PRIMARY KEY (SOHD, MASP)

--Tạo khóa ngoại--
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH)
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV)
ALTER TABLE CTHD ADD CONSTRAINT FK_CTHD_HOADON FOREIGN KEY (SOHD) REFERENCES HOADON (SOHD)
ALTER TABLE CTHD ADD CONSTRAINT FK_CTHD_SANPHAM FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP)

SET DATEFORMAT DMY

--Insert dữ liệu--

--Nhân viên
INSERT INTO NHANVIEN VALUES('NV01', 'Nguyen Nhu Nhut', '0927345678', '13/04/2006')
INSERT INTO NHANVIEN VALUES('NV02', 'Le Thi Phi Yen', '0987567390', '21/04/2006')
INSERT INTO NHANVIEN VALUES('NV03', 'Nguyen Van B', '0997047382', '27/04/2006')
INSERT INTO NHANVIEN VALUES('NV04', 'Ngo Thanh Tuan', '0913758498', '24/06/2006')
INSERT INTO NHANVIEN VALUES('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '20/07/2006')

--Khách hàng
INSERT INTO KHACHHANG VALUES('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '22/10/1960', 13060000, '22/07/2006')
INSERT INTO KHACHHANG VALUES('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '03/04/1974', 280000, '30/07/2006')
INSERT INTO KHACHHANG VALUES('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '12/06/1980', 3860000, '05/08/2006')
INSERT INTO KHACHHANG VALUES('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '09/03/1965', 250000, '02/10/2006')
INSERT INTO KHACHHANG VALUES('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '10/03/1950', 21000, '28/10/2006')
INSERT INTO KHACHHANG VALUES('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '31/12/1981', 915000, '24/11/2006')
INSERT INTO KHACHHANG VALUES('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '06-04-1971', 12500, '01/12/2006')
INSERT INTO KHACHHANG VALUES('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '10/01/1971', 365000, '13/12/2006')
INSERT INTO KHACHHANG VALUES('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '03-09-1979', 70000, '14/01/2007')
INSERT INTO KHACHHANG VALUES('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '02/05/1983', 67500, '16/01/2007')

--Sản phẩm
INSERT INTO SANPHAM VALUES('BC01', 'But chi', 'cay', 'Singapore', 3000)
INSERT INTO SANPHAM VALUES('BC02', 'But chi', 'cay', 'Singapore', 5000)
INSERT INTO SANPHAM VALUES('BC03', 'But chi', 'cay', 'Viet Nam', 3500)
INSERT INTO SANPHAM VALUES('BC04', 'But chi', 'hop', 'Viet Nam', 30000)
INSERT INTO SANPHAM VALUES('BB01', 'But bi', 'cay', 'Viet Nam', 5000)
INSERT INTO SANPHAM VALUES('BB02', 'But bi', 'cay', 'Trung Quoc', 7000)
INSERT INTO SANPHAM VALUES('BB03', 'But bi', 'hop', 'Thai Lan', 100000)
INSERT INTO SANPHAM VALUES('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 2500)
INSERT INTO SANPHAM VALUES('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 4500)
INSERT INTO SANPHAM VALUES('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000)
INSERT INTO SANPHAM VALUES('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500)
INSERT INTO SANPHAM VALUES('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000)
INSERT INTO SANPHAM VALUES('TV06', 'Tao 200 trang', 'chuc', 'Viet Nam', 53000)
INSERT INTO SANPHAM VALUES('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000)
INSERT INTO SANPHAM VALUES('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 50000)
INSERT INTO SANPHAM VALUES('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000)
INSERT INTO SANPHAM VALUES('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000)
INSERT INTO SANPHAM VALUES('ST04', 'So tay', 'quyen', 'Thai Lan', 55000)
INSERT INTO SANPHAM VALUES('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000)
INSERT INTO SANPHAM VALUES('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000)
INSERT INTO SANPHAM VALUES('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000)
INSERT INTO SANPHAM VALUES('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000)
INSERT INTO SANPHAM VALUES('ST09', 'But long', 'cay', 'Viet Nam', 5000)
INSERT INTO SANPHAM VALUES('ST10', 'But long', 'cay', 'Trung Quoc', 7000)

--Hóa đơn
INSERT INTO HOADON VALUES(1001, '23/07/2006', 'KH01', 'NV01', 320000)
INSERT INTO HOADON VALUES(1002, '12/08/2006', 'KH01', 'NV02', 840000)
INSERT INTO HOADON VALUES(1003, '23/08/2006', 'KH02', 'NV01', 100000)
INSERT INTO HOADON VALUES(1004, '01/09/2006', 'KH02', 'NV01', 180000)
INSERT INTO HOADON VALUES(1005, '20/10/2006', 'KH01', 'NV02', 3800000)
INSERT INTO HOADON VALUES(1006, '16/10/2006', 'KH01', 'NV03', 2430000)
INSERT INTO HOADON VALUES(1007, '28/10/2006', 'KH03', 'NV03', 510000)
INSERT INTO HOADON VALUES(1008, '28/10/2006', 'KH01', 'NV03', 440000)
INSERT INTO HOADON VALUES(1009, '28/10/2006', 'KH03', 'NV04', 200000)
INSERT INTO HOADON VALUES(1010, '01/11/2006', 'KH01', 'NV01', 5200000)
INSERT INTO HOADON VALUES(1011, '04/11/2006', 'KH04', 'NV03', 250000)
INSERT INTO HOADON VALUES(1012, '30/11/2006', 'KH05', 'NV03', 21000)
INSERT INTO HOADON VALUES(1013, '12/12/2006', 'KH06', 'NV01', 5000)
INSERT INTO HOADON VALUES(1014, '31/12/2006', 'KH03', 'NV02', 3150000)
INSERT INTO HOADON VALUES(1015, '01/01/2007', 'KH06', 'NV01', 910000)
INSERT INTO HOADON VALUES(1016, '01/01/2007', 'KH07', 'NV02', 12500)
INSERT INTO HOADON VALUES(1017, '02/01/2007', 'KH08', 'NV03', 35000)
INSERT INTO HOADON VALUES(1018, '13/01/2007', 'KH08', 'NV03', 330000)
INSERT INTO HOADON VALUES(1019, '13/01/2007', 'KH01', 'NV03', 30000)
INSERT INTO HOADON VALUES(1020, '14/01/2007', 'KH09', 'NV04', 70000)
INSERT INTO HOADON VALUES(1021, '16/01/2007', 'KH10', 'NV03', 67500)
INSERT INTO HOADON VALUES(1022, '16/01/2007', Null, 'NV03', 7000)
INSERT INTO HOADON VALUES(1023, '17/01/2007', Null, 'NV01', 330000)


--Chi tiết hóa đơn
INSERT INTO CTHD VALUES(1001, 'TV02', 10)
INSERT INTO CTHD VALUES(1001, 'ST01', 5)
INSERT INTO CTHD VALUES(1001, 'BC01', 5)
INSERT INTO CTHD VALUES(1001, 'BC02', 10)
INSERT INTO CTHD VALUES(1001, 'ST08', 10)
INSERT INTO CTHD VALUES(1002, 'BC04', 20)
INSERT INTO CTHD VALUES(1002, 'BB01', 20)
INSERT INTO CTHD VALUES(1002, 'BB02', 20)
INSERT INTO CTHD VALUES(1003, 'BB03', 10)
INSERT INTO CTHD VALUES(1004, 'TV01', 20)
INSERT INTO CTHD VALUES(1004, 'TV02', 10)
INSERT INTO CTHD VALUES(1004, 'TV03', 10)
INSERT INTO CTHD VALUES(1004, 'TV04', 10)
INSERT INTO CTHD VALUES(1005, 'TV05', 50)
INSERT INTO CTHD VALUES(1005, 'TV06', 50)
INSERT INTO CTHD VALUES(1006, 'TV07', 20)
INSERT INTO CTHD VALUES(1006, 'ST01', 30)
INSERT INTO CTHD VALUES(1006, 'ST02', 10)
INSERT INTO CTHD VALUES(1007, 'ST03', 10)
INSERT INTO CTHD VALUES(1008, 'ST04', 8)
INSERT INTO CTHD VALUES(1009, 'ST05', 10)
INSERT INTO CTHD VALUES(1010, 'TV07', 50)
INSERT INTO CTHD VALUES(1010, 'ST07', 50)
INSERT INTO CTHD VALUES(1010, 'ST08', 100)
INSERT INTO CTHD VALUES(1010, 'ST04', 50)
INSERT INTO CTHD VALUES(1010, 'TV03', 100)
INSERT INTO CTHD VALUES(1011, 'ST06', 50)
INSERT INTO CTHD VALUES(1012, 'ST07', 3)
INSERT INTO CTHD VALUES(1013, 'ST08', 5)
INSERT INTO CTHD VALUES(1014, 'BC02', 80)
INSERT INTO CTHD VALUES(1014, 'BB02', 100)
INSERT INTO CTHD VALUES(1014, 'BC04', 60)
INSERT INTO CTHD VALUES(1014, 'BB01', 50)
INSERT INTO CTHD VALUES(1015, 'BB02', 30)
INSERT INTO CTHD VALUES(1015, 'BB03', 7)
INSERT INTO CTHD VALUES(1016, 'TV01', 5)
INSERT INTO CTHD VALUES(1017, 'TV02', 1)
INSERT INTO CTHD VALUES(1017, 'TV03', 1)
INSERT INTO CTHD VALUES(1017, 'TV04', 5)
INSERT INTO CTHD VALUES(1018, 'ST04', 6)
INSERT INTO CTHD VALUES(1019, 'ST05', 1)
INSERT INTO CTHD VALUES(1019, 'ST06', 2)
INSERT INTO CTHD VALUES(1020, 'ST07', 10)
INSERT INTO CTHD VALUES(1021, 'ST08', 5)
INSERT INTO CTHD VALUES(1021, 'TV01', 7)
INSERT INTO CTHD VALUES(1021, 'TV02', 10)
INSERT INTO CTHD VALUES(1022, 'ST07', 1)
INSERT INTO CTHD VALUES(1023, 'ST04', 6)