CREATE DATABASE QuanLyGiaoVu_DB

USE QuanLyGiaoVu_DB

CREATE TABLE KHOA
(
	MAKHOA varchar(4) NOT NULL,
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4)
)

CREATE TABLE MONHOC
(
	MAMH varchar(10) NOT NULL,
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4)
)

CREATE TABLE DIEUKIEN
(
	MAMH varchar(10) NOT NULL,
	MAMH_TRUOC varchar(10) NOT NULL
)

CREATE TABLE GIAOVIEN
(
	MAGV char(4) NOT NULL,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4)
)

CREATE TABLE LOP
(
	MALOP char(3) NOT NULL,
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4)
)

CREATE TABLE HOCVIEN
(
	MAHV char(5) NOT NULL,
	HO varchar(40),
	TEN varchar(10),
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3)
)

CREATE TABLE GIANGDAY
(
	MALOP char(3) NOT NULL,
	MAMH varchar(10) NOT NULL,
	MAGV char(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime
)

CREATE TABLE KETQUATHI
(
	MAHV char(5) NOT NULL,
	MAMH varchar(10) NOT NULL,
	LANTHI tinyint NOT NULL,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10)
)

--Tao khoa chinh--

ALTER TABLE KHOA ADD CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
ALTER TABLE MONHOC ADD CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH)
ALTER TABLE DIEUKIEN ADD CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH, MAMH_TRUOC)
ALTER TABLE GIAOVIEN ADD CONSTRAINT PK_GIAOVIEN PRIMARY KEY (MAGV)
ALTER TABLE LOP ADD CONSTRAINT PK_LOP PRIMARY KEY (MALOP)
ALTER TABLE HOCVIEN ADD CONSTRAINT PK_HOCVIEN PRIMARY KEY (MAHV)
ALTER TABLE GIANGDAY ADD CONSTRAINT PK_GIANGDAY PRIMARY KEY (MALOP, MAMH)
ALTER TABLE KETQUATHI ADD CONSTRAINT PK_KETQUATHI PRIMARY KEY (MAHV, MAMH, LANTHI)

--Tao khoa ngoai--

--KHOA
ALTER TABLE KHOA ADD CONSTRAINT FK_KHOA_TRGKHOA FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN (MAGV)

--MONHOC
ALTER TABLE MONHOC ADD CONSTRAINT FK_MONHOC_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA (MAKHOA)

--DIEUKIEN
ALTER TABLE DIEUKIEN ADD CONSTRAINT FK01_DIEUKIEN_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)
ALTER TABLE DIEUKIEN ADD CONSTRAINT FK02_DIEUKIEN_MONHOC FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC (MAMH)

--GIAOVIEN
ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_GIAOVIEN_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA (MAKHOA)

--LOP
ALTER TABLE LOP ADD CONSTRAINT FK01_LOP_HOCVIEN FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN (MAHV)
ALTER TABLE LOP ADD CONSTRAINT FK02_LOP_GIAOVIEN FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN (MAGV)

--HOCVIEN
ALTER TABLE HOCVIEN ADD CONSTRAINT FK_HOCVIEN_LOP FOREIGN KEY (MALOP) REFERENCES LOP (MALOP)

--GIANGDAY
ALTER TABLE GIANGDAY ADD CONSTRAINT FK01_GIANGDAY_LOP FOREIGN KEY (MALOP) REFERENCES LOP (MALOP)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK02_GIANGDAY_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK03_GIANGDAY_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN (MAGV)

--KETQUATHI
ALTER TABLE KETQUATHI ADD CONSTRAINT FK01_KETQUATHI_HOCVIEN FOREIGN KEY (MAHV) REFERENCES HOCVIEN (MAHV)
ALTER TABLE KETQUATHI ADD CONSTRAINT FK02_KETQUATHI_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)

SET DATEFORMAT DMY

--Nhap du lieu--

ALTER TABLE KHOA NOCHECK CONSTRAINT ALL
ALTER TABLE LOP NOCHECK CONSTRAINT ALL
ALTER TABLE MONHOC NOCHECK CONSTRAINT ALL
ALTER TABLE DIEUKIEN NOCHECK CONSTRAINT ALL
ALTER TABLE GIAOVIEN NOCHECK CONSTRAINT ALL
ALTER TABLE HOCVIEN NOCHECK CONSTRAINT ALL
ALTER TABLE GIANGDAY NOCHECK CONSTRAINT ALL
ALTER TABLE KETQUATHI NOCHECK CONSTRAINT ALL

DELETE FROM KHOA
DELETE FROM LOP
DELETE FROM MONHOC
DELETE FROM DIEUKIEN
DELETE FROM GIAOVIEN
DELETE FROM HOCVIEN
DELETE FROM GIANGDAY
DELETE FROM KETQUATHI

--KHOA
INSERT INTO KHOA VALUES ('KHMT', 'Khoa hoc may tinh', '07/06/2005', 'GV01')
INSERT INTO KHOA VALUES ('HTTT', 'He thong thong tin', '07/06/2005', 'GV02')
INSERT INTO KHOA VALUES ('CNPM', 'Cong nghe phan mem', '07/06/2005', 'GV04')
INSERT INTO KHOA VALUES ('MTT', 'Mang va truyen thong', '20/10/2005', 'GV03')
INSERT INTO KHOA VALUES ('KTMT', 'Ky thuat may tinh', '20/12/2005', Null)

--LOP
INSERT INTO LOP VALUES ('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07')
INSERT INTO LOP VALUES ('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09')
INSERT INTO LOP VALUES ('K11', 'Lop 3 khoa 1', 'K1358', 12, 'GV14')

--MONHOC
INSERT INTO MONHOC VALUES ('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT')
INSERT INTO MONHOC VALUES ('CTRR', 'Cau truc roi rac', 5, 0, 'KHMT')
INSERT INTO MONHOC VALUES ('CSDL', 'Co so du lieu', 3, 1, 'HTTT')
INSERT INTO MONHOC VALUES ('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT')
INSERT INTO MONHOC VALUES ('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT')
INSERT INTO MONHOC VALUES ('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT')
INSERT INTO MONHOC VALUES ('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT')
INSERT INTO MONHOC VALUES ('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT')
INSERT INTO MONHOC VALUES ('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT')
INSERT INTO MONHOC VALUES ('HDH', 'He dieu hanh', 4, 0, 'KTMT')
INSERT INTO MONHOC VALUES ('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM')
INSERT INTO MONHOC VALUES ('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM')
INSERT INTO MONHOC VALUES ('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM')

-- DIEUKIEN
INSERT INTO DIEUKIEN VALUES ('CSDL', 'CTRR')
INSERT INTO DIEUKIEN VALUES ('CSDL', 'CTDLGT')
INSERT INTO DIEUKIEN VALUES ('CTDLGT', 'THDC')
INSERT INTO DIEUKIEN VALUES ('PTTKTT', 'THDC')
INSERT INTO DIEUKIEN VALUES ('PTTKTT', 'CTDLGT')
INSERT INTO DIEUKIEN VALUES ('DHMT', 'THDC')
INSERT INTO DIEUKIEN VALUES ('LTHDT', 'THDC')
INSERT INTO DIEUKIEN VALUES ('PTTKHTTT', 'CSDL')

-- GIANGDAY
INSERT INTO GIANGDAY VALUES('K11', 'THDC', 'GV07', 1, 2006, '02/01/2006', '12/05/2006')
INSERT INTO GIANGDAY VALUES('K12', 'THDC', 'GV06', 1, 2006, '02/01/2006', '12/05/2006')
INSERT INTO GIANGDAY VALUES('K13', 'THDC', 'GV15', 1, 2006, '02/01/2006', '12/05/2006')
INSERT INTO GIANGDAY VALUES('K11', 'CTRR', 'GV02', 1, 2006, '09/01/2006', '17/05/2006')
INSERT INTO GIANGDAY VALUES('K12', 'CTRR', 'GV02', 1, 2006, '09/01/2006', '17/05/2006')
INSERT INTO GIANGDAY VALUES('K13', 'CTRR', 'GV08', 1, 2006, '09/01/2006', '17/05/2006')
INSERT INTO GIANGDAY VALUES('K11', 'CSDL', 'GV05', 2, 2006, '01/06/2006', '15/07/2006')
INSERT INTO GIANGDAY VALUES('K12', 'CSDL', 'GV09', 2, 2006, '01/06/2006', '15/07/2006')
INSERT INTO GIANGDAY VALUES('K13', 'CTDLGT', 'GV15', 2, 2006, '01/06/2006', '15/07/2006')
INSERT INTO GIANGDAY VALUES('K13', 'CSDL', 'GV05', 3, 2006, '01/08/2006', '15/12/2006')
INSERT INTO GIANGDAY VALUES('K13', 'DHMT', 'GV07', 3, 2006, '01/08/2006', '15/12/2006')
INSERT INTO GIANGDAY VALUES('K11', 'CTDLGT', 'GV15', 3, 2006, '01/08/2006', '15/12/2006')
INSERT INTO GIANGDAY VALUES('K12', 'CTDLGT', 'GV15', 3, 2006, '01/08/2006', '15/12/2006')
INSERT INTO GIANGDAY VALUES('K11', 'HDH', 'GV04', 1, 2007, '02/01/2007', '18/02/2007')
INSERT INTO GIANGDAY VALUES('K12', 'HDH', 'GV04', 1, 2007, '02/01/2007', '20/03/2007')
INSERT INTO GIANGDAY VALUES('K11', 'DHMT', 'GV07', 1, 2007, '18/02/2007', '20/03/2007')

-- GIAOVIEN
INSERT INTO GIAOVIEN VALUES('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '02/05/1950', '11/01/2004', 5, 2250000, 'KHMT')
INSERT INTO GIAOVIEN VALUES('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '17/12/1965', '20/04/2004', 4.5, 2025000, 'HTTT')
INSERT INTO GIAOVIEN VALUES('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '01/08/1950', '23/09/2004', 4, 1800000, 'CNPM')
INSERT INTO GIAOVIEN VALUES('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '22/02/1961', '12/01/2005', 4.5, 2025000, 'KTMT')
INSERT INTO GIAOVIEN VALUES('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '12/03/1958', '12/01/2005', 3, 1350000, 'HTTT')
INSERT INTO GIAOVIEN VALUES('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '11/03/1953', '12/01/2005', 4.5, 2025000, 'KHMT')
INSERT INTO GIAOVIEN VALUES('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '23/11/1971', '01/03/2005', 4, 1800000, 'KHMT')
INSERT INTO GIAOVIEN VALUES('GV08', 'Le Thi Tran', 'KS', 'Null', 'Nu', '26/03/1974', '01/03/2005', 1.69, 760500, 'KHMT')
INSERT INTO GIAOVIEN VALUES('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '31/12/1966', '01/03/2005', 4, 1800000, 'HTTT')
INSERT INTO GIAOVIEN VALUES('GV10', 'Le Tran Anh Loan', 'KS', 'Null', 'Nu', '17/07/1972', '01/03/2005', 1.86, 837000, 'CNPM')
INSERT INTO GIAOVIEN VALUES('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '12/1/1980', '15/05/2005', 2.67, 1201500, 'MTT')
INSERT INTO GIAOVIEN VALUES('GV12', 'Tran Van Anh', 'CN', 'Null', 'Nu', '29/03/1981', '15/05/2005', 1.69, 760500, 'CNPM')
INSERT INTO GIAOVIEN VALUES('GV13', 'Nguyen Linh Dan', 'CN', 'Null', 'Nu', '23/05/1980', '15/05/2005', 1.69, 760500,'KTMT')
INSERT INTO GIAOVIEN VALUES('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '30/11/1976', '15/05/2005', 3, 1350000, 'MTT')
INSERT INTO GIAOVIEN VALUES('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '04/05/1978', '15/05/2005', 3, 1350000, 'KHMT')

-- HOCVIEN
INSERT INTO HOCVIEN VALUES ('K1101', 'Nguyen Van', 'A', '27/01/1986', 'Nam', 'TpHCM', 'K11')
INSERT INTO HOCVIEN VALUES ('K1102', 'Tran Ngoc', 'Han', '14/03/1986', 'Nu', 'Kien Giang', 'K11')
INSERT INTO HOCVIEN VALUES ('K1103', 'Ha Duy','Lap', '18/04/1986', 'Nam', 'Nghe An', 'K11')
INSERT INTO HOCVIEN VALUES ('K1104', 'Tran Ngoc', 'Linh', '30/03/1986', 'Nu', 'Tay Ninh', 'K11')
INSERT INTO HOCVIEN VALUES ('K1105', 'Tran Minh', 'Long', '27/02/1986', 'Nam', 'TpHCM', 'K11')
INSERT INTO HOCVIEN VALUES ('K1106', 'Le Nhat', 'Minh', '24/01/1986', 'Nam', 'TpHCM', 'K11')
INSERT INTO HOCVIEN VALUES ('K1107', 'Nguyen Nhu',' Nhut', '27/01/1986', 'Nam', 'Ha Noi', 'K11')
INSERT INTO HOCVIEN VALUES ('K1108', 'Nguyen Manh', 'Tam', '27/02/1986', 'Nam', 'Kien Giang', 'K11')
INSERT INTO HOCVIEN VALUES ('K1109', 'Phan Thi Thanh', 'Tam', '27/01/1986', 'Nu', 'Vinh Long', 'K11')
INSERT INTO HOCVIEN VALUES ('K1110', 'Le Hoai', 'Thuong', '05/02/1986', 'Nu', 'Can Tho', 'K11')
INSERT INTO HOCVIEN VALUES ('K1111', 'Le Ha', 'Vinh', '25/12/1986', 'Nam', 'Vinh Long', 'K11')
INSERT INTO HOCVIEN VALUES ('K1201', 'Nguyen Van', 'B', '11/02/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO HOCVIEN VALUES ('K1202', 'Nguyen Thi Kim', 'Duyen', '18/01/1986', 'Nu', 'TpHCM', 'K12')
INSERT INTO HOCVIEN VALUES ('K1203', 'Tran Thi Kim', 'Duyen', '17/09/1986', 'Nu', 'TpHCM', 'K12')
INSERT INTO HOCVIEN VALUES ('K1204', 'Truong My', 'Hanh', '19/5/1986', 'Nu', 'Dong Nai', 'K12')
INSERT INTO HOCVIEN VALUES ('K1205', 'Nguyen Thanh', 'Nam', '17/4/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO HOCVIEN VALUES ('K1206', 'Nguyen Thi Truc', 'Thanh', '04/03/1986', 'Nu', 'Kien Giang', 'K12')
INSERT INTO HOCVIEN VALUES ('K1207', 'Tran Thi Bich', 'Thuy', '08/02/1986', 'Nu', 'Nghe An', 'K12')
INSERT INTO HOCVIEN VALUES ('K1208', 'Huynh Thi Kim', 'Trieu', '08/04/1986', 'Nu', 'Tay Ninh', 'K12')
INSERT INTO HOCVIEN VALUES ('K1209', 'Pham Thanh', 'Trieu', '23/02/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO HOCVIEN VALUES ('K1210', 'Ngo Thanh', 'Tuan', '14/02/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO HOCVIEN VALUES ('K1211', 'Do Thi', 'Xuan', '09/03/1986', 'Nu', 'Ha Noi', 'K12')
INSERT INTO HOCVIEN VALUES ('K1212', 'Le Thi Phi', 'Yen', '12/03/1986', 'Nu', 'TpHCM', 'K12')
INSERT INTO HOCVIEN VALUES ('K1301', 'Nguyen Thi Kim', 'Cuc', '09/06/1986', 'Nu', 'Kien Giang', 'K13')
INSERT INTO HOCVIEN VALUES ('K1302', 'Truong Thi My', 'Hien', '18/03/1986', 'Nu', 'Nghe An', 'K13')
INSERT INTO HOCVIEN VALUES ('K1303', 'Le Duc', 'Hien', '21/03/1986', 'Nam', 'Tay Ninh', 'K13')
INSERT INTO HOCVIEN VALUES ('K1304', 'Le Quang', 'Hien', '18/04/1986', 'Nam', 'TpHCM', 'K13')
INSERT INTO HOCVIEN VALUES ('K1305', 'Le Thi', 'Huong', '27/3/1986', 'Nu', 'TpHCM', 'K13')
INSERT INTO HOCVIEN VALUES ('K1306', 'Nguyen Thai', 'Huu', '30/03/1986', 'Nam', 'Ha Noi', 'K13')
INSERT INTO HOCVIEN VALUES ('K1307', 'Tran Minh', 'Man', '28/05/1986', 'Nam', 'TpHCM', 'K13')
INSERT INTO HOCVIEN VALUES ('K1308', 'Nguyen Hieu', 'Nghia', '08/04/1986', 'Nam', 'Kien Giang', 'K13')
INSERT INTO HOCVIEN VALUES ('K1309', 'Nguyen Trung', 'Nghia', '18/01/1987', 'Nam', 'Nghe An', 'K13')
INSERT INTO HOCVIEN VALUES ('K1310', 'Tran Thi Hong', 'Tham', '22/04/1986', 'Nu', 'Tay Ninh', 'K13')
INSERT INTO HOCVIEN VALUES ('K1311', 'Tran Minh', 'Thuc', '04/04/1986', 'Nam', 'TpHCM', 'K13')
INSERT INTO HOCVIEN VALUES ('K1312', 'Nguyen Thi Kim', 'Yen', '07/09/1986', 'Nu', 'TpHCM', 'K13')

--KETQUATHI
INSERT INTO KETQUATHI VALUES ('K1101', 'CSDL', 1, '20/07/2006', 10, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1101', 'CTDLGT', 1, '28/12/2006', 9, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1101', 'THDC', 1, '20/05/2006', 9, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1101', 'CTRR', 1, '13/05/2006', 9.5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'CSDL ', 1, '20/07/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'CSDL', 2, '27/07/2006', 4.25, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'CSDL', 3, '10/08/2006', 4.5, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'CTDLGT', 1, '28/12/2006', 4.5, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'CTDLGT', 2, '05/01/2007', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'CTDLGT', 3, '15/01/2007', 6, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'THDC', 1, '20/05/2006', 5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1102', 'CTRR', 1, '13/05/2006', 7, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103', 'CSDL', 1, '20/07/2006', 3.5, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1103', 'CSDL', 2, '27/07/2006', 8.25, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103', 'CTDLGT', 1, '28/12/2006', 7, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103', 'THDC', 1, '20/05/2006', 8, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103', 'CTRR', 1, '13/05/2006', 6.5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1104', 'CSDL', 1, '20/07/2006', 3.75, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104', 'CTDLGT', 1, '28/12/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104', 'THDC', 1, '20/05/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104', 'CTRR', 1, '13/05/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104', 'CTRR', 2, '20/05/2006', 3.5, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104', 'CTRR', 3, '30/06/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1201', 'CSDL', 1, '20/07/2006', 6, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1201', 'CTDLGT', 1, '28/12/2006', 5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1201', 'THDC', 1, '20/05/2006', 8.5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1201', 'CTRR', 1, '13/05/2006', 9, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'CSDL', 1, '20/07/2006', 8, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'CTDLGT', 1, '28/12/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'CTDLGT', 2, '05/01/2007', 5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'THDC', 1, '20/05/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'THDC', 2, '27/05/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'CTRR', 1, '13/05/2006', 3, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'CTRR', 2, '20/05/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'CTRR', 3, '30/06/2006', 6.25, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1203', 'CSDL', 1, '20/07/2006', 9.25, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1203', 'CTDLGT', 1, '28/12/2006', 9.5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1203', 'THDC', 1, '20/05/2006', 10, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1203', 'CTRR', 1, '13/05/2006', 10, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1204', 'CSDL', 1, '20/07/2006', 8.5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1204', 'CTDLGT', 1, '28/12/2006', 6.75, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1204', 'THDC', 1, '20/05/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1204', 'CTRR', 1, '13/05/2006', 6, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1301', 'CSDL', 1, '20/12/2006', 4.25, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1301', 'CTDLGT', 1, '25/07/2006', 8, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1301', 'THDC', 1, '20/05/2006', 7.75, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1301', 'CTRR', 1, '13/05/2006', 8, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1302', 'CSDL', 1, '20/12/2006', 6.75, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1302', 'CTDLGT', 1, '25/07/2006', 5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1302', 'THDC', 1, '20/05/2006', 8, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1302', 'CTRR', 1, '13/05/2006', 8.5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'CSDL', 1, '20/12/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'CTDLGT', 1, '25/07/2006', 4.5, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'CTDLGT', 2, '07/08/2006', 4, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'CTDLGT', 3, '15/08/2006', 4.25, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'THDC', 1, '20/05/2006', 4.5, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'CTRR', 1, '13/05/2006', 3.25, 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'CTRR', 2, '20/05/2006', 5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1304', 'CSDL', 1, '20/12/2006', 7.75, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1304', 'CTDLGT', 1, '25/07/2006', 9.75, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1304', 'THDC', 1, '20/05/2006', 5.5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1304', 'CTRR', 1, '13/05/2006', 5, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1305', 'CSDL', 1, '20/12/2006', 9.25, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1305', 'CTDLGT', 1, '25/07/2006', 10, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1305', 'THDC ', 1, '20/05/2006', 8, 'Dat')
INSERT INTO KETQUATHI VALUES ('K1305', 'CTRR', 1, '13/05/2006', 10, 'Dat')