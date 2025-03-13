CREATE DATABASE QuanlyHangHoa_DB

USE QuanLyHangHoa_DB

CREATE TABLE Nhacungcap
(
	maNCC varchar(5) not null,
	tenNCC varchar(20),
	trangthai numeric(2,0),
	thanhpho varchar(30)
)

CREATE TABLE Phutung
(
	maPT varchar(5) not null,
	tenPT varchar(10),
	mausac varchar(10),
	khoiluong float,
	thanhpho varchar(30)
)

CREATE TABLE Vanchuyen
(
	maNCC varchar(5) not null,
	maPT varchar(5) not null,
	soluong numeric(5,0)
)
--Tạo khóa chính--
ALTER TABLE Nhacungcap ADD CONSTRAINT PK_Nhacungcap PRIMARY KEY (maNCC)
ALTER TABLE Phutung ADD CONSTRAINT PK_Phutung PRIMARY KEY (maPT)
ALTER TABLE Vanchuyen ADD CONSTRAINT PK_Vanchuyen PRIMARY KEY (maNCC, maPT)

--Tạo khóa ngoại--
ALTER TABLE Vanchuyen ADD CONSTRAINT FK_Vanchuyen_Nhacungcap FOREIGN KEY (maNCC) REFERENCES Nhacungcap (maNCC)
ALTER TABLE Vanchuyen ADD CONSTRAINT FK_Vanchuyen_Phutung FOREIGN KEY (maPT) REFERENCES Phutung (maPT)
