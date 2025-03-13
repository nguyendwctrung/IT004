USE QuanLyDeTaiDB

-- Q1. Cho"biết"họ"tên"và"mức"lương"của"các"giáo"viên"nữ."
SELECT HOTEN, LUONG
FROM GIAOVIEN
WHERE PHAI = N'Nữ'

-- Q2. Cho"biết"họ"tên"của"các"giáo"viên"và"lương"của"họ"sau"khi"tăng"10%.
SELECT HOTEN, LUONG, LUONG * 1.1 AS LUONG_TANG_10
FROM GIAOVIEN

-- Q3. Cho"biết"mã"của"các"giáo"viên"có"họ"tên"bắt"đầu"là"“Nguyễn”"và"lương"trên"$2000"hoặc,"giáo"viên"là"trưởng" bộ"môn"nhận"chức"sau"năm"1995."
SELECT DISTINCT GIAOVIEN.MAGV
FROM GIAOVIEN
LEFT JOIN BOMON ON GIAOVIEN.MAGV = BOMON.TRUONGBM
WHERE (HOTEN LIKE N'Nguyễn%' AND LUONG > 2000)
   OR (BOMON.NGNHANCHUC > '1995-12-31')

-- Q4. Cho"biết"tên"những"giáo"viên"khoa"Công"nghệ"thông"tin."
SELECT GIAOVIEN.HOTEN
FROM GIAOVIEN
JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM
JOIN KHOA ON BOMON.MAKHOA = KHOA.MAKHOA
WHERE KHOA.TENKHOA = N'Công nghệ thông tin'

-- Q5. Cho"biết"thông"tin"của"bộ"môn"cùng"thông"tin"giảng"viên"làm"trưởng"bộ"môn"đó."
SELECT BOMON.*, GIAOVIEN.HOTEN AS TRUONG_BOMON, GIAOVIEN.DIACHI
FROM BOMON
LEFT JOIN GIAOVIEN ON BOMON.TRUONGBM = GIAOVIEN.MAGV

-- Q6. Với"mỗi"giáo"viên,"hãy"cho"biết"thông"tin"của"bộ"môn"mà"họ"đang"làm"việc."
SELECT GIAOVIEN.HOTEN, BOMON.*
FROM GIAOVIEN
JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM

-- Q7. Cho"biết"tên"đề"tài"và"giáo"viên"chủ"nhiệm"đề"tài."
SELECT DETAI.TENDT, GIAOVIEN.HOTEN AS CHU_NHIEM
FROM DETAI
JOIN GIAOVIEN ON DETAI.GVCNDT = GIAOVIEN.MAGV

-- Q8. Với"mỗi"khoa"cho"biết"thông"tin"trưởng"khoa.
SELECT KHOA.*, GIAOVIEN.HOTEN AS TRUONG_KHOA, GIAOVIEN.DIACHI
FROM KHOA
LEFT JOIN GIAOVIEN ON KHOA.TRGKHOA = GIAOVIEN.MAGV

-- Q9. Cho"biết"các"giáo"viên"của"bộ"môn"“Vi"sinh”"có"tham"gia"đề"tài"006."
SELECT DISTINCT GIAOVIEN.HOTEN
FROM GIAOVIEN
JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM
JOIN THAMGIADT ON GIAOVIEN.MAGV = THAMGIADT.MAGV
WHERE BOMON.TENBM = N'Vi sinh' AND THAMGIADT.MADT = '006'

-- Q10. Với những đề tài thuộc cấp quản lý “Thành phố” cho biết mã, tên đề tài và giáo viên chủ nhiệm.
SELECT DETAI.MADT, DETAI.TENDT, GIAOVIEN.HOTEN AS CHU_NHIEM
FROM DETAI
JOIN GIAOVIEN ON DETAI.GVCNDT = GIAOVIEN.MAGV
WHERE DETAI.CAPQL = N'Thành phố'

-- Q11: Tìm họ tên của từng giáo viên và người phụ trách chuyên môn trực tiếp của giáo viên đó.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN, 
    GIAOVIEN_QL.HOTEN AS NGUOI_PHU_TRACH
FROM 
    GIAOVIEN
LEFT JOIN 
    GIAOVIEN AS GIAOVIEN_QL 
ON 
    GIAOVIEN.GVQLCM = GIAOVIEN_QL.MAGV

-- Q12: Tìm họ tên của những giáo viên được “Nguyễn Thanh Tùng” phụ trách trực tiếp.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN
FROM 
    GIAOVIEN
JOIN 
    GIAOVIEN AS NGUOI_PHU_TRACH 
ON 
    GIAOVIEN.GVQLCM = NGUOI_PHU_TRACH.MAGV
WHERE 
    NGUOI_PHU_TRACH.HOTEN = N'Nguyễn Thanh Tùng'

-- Q13: Cho biết tên giáo viên là trưởng bộ môn Hệ thống thông tin.
SELECT 
    BOMON.MABM, 
    BOMON.TENBM AS TEN_BO_MON, 
    GIAOVIEN.HOTEN AS TRUONG_BO_MON
FROM 
    BOMON
JOIN 
    GIAOVIEN 
ON 
    BOMON.TRUONGBM = GIAOVIEN.MAGV
WHERE 
    BOMON.TENBM = N'Hệ thống thông tin'

-- Q14: Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề Quản lý giáo dục.
SELECT 
    DETAI.MADT, 
    DETAI.TENDT AS TEN_DE_TAI, 
    GIAOVIEN.HOTEN AS CHU_NHIEM
FROM 
    DETAI
JOIN 
    GIAOVIEN 
ON 
    DETAI.GVCNDT = GIAOVIEN.MAGV
WHERE 
    DETAI.MACD = N'QLGD';

-- Q15: Cho biết tên các công việc của đề tài HTTT quản lý các trường ĐH có thời gian bắt đầu trong tháng 3/2008.
SELECT 
    CONGVIEC.MADT, 
    CONGVIEC.TENCV AS TEN_CONG_VIEC, 
    CONGVIEC.NGAYBD AS NGAY_BAT_DAU
FROM 
    CONGVIEC
JOIN 
    DETAI 
ON 
    CONGVIEC.MADT = DETAI.MADT
WHERE 
    DETAI.TENDT = N'HTTT quản lý các trường DH'
    AND MONTH(CONGVIEC.NGAYBD) = 3
    AND YEAR(CONGVIEC.NGAYBD) = 2008

-- Q16: Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN, 
    NGUOI_PHU_TRACH.HOTEN AS NGUOI_QUAN_LY
FROM 
    GIAOVIEN
LEFT JOIN 
    GIAOVIEN AS NGUOI_PHU_TRACH 
ON 
    GIAOVIEN.GVQLCM = NGUOI_PHU_TRACH.MAGV

-- Q17: Cho các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007.
SELECT 
    CONGVIEC.MADT, 
    CONGVIEC.TENCV AS TEN_CONG_VIEC, 
    CONGVIEC.NGAYBD AS NGAY_BAT_DAU
FROM 
    CONGVIEC
WHERE 
    CONGVIEC.NGAYBD BETWEEN '2007-01-01' AND '2007-08-01'

-- Q18: Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.MABM = (
        SELECT 
            MABM
        FROM 
            GIAOVIEN
        WHERE 
            HOTEN = N'Trần Trà Hương'
    )
    AND GIAOVIEN.HOTEN <> N'Trần Trà Hương'

-- Q19: Tìm những giáo viên vừa là trưởng bộ môn vừa chủ nhiệm đề tài.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.MAGV IN (SELECT TRUONGBM FROM BOMON)
    AND GIAOVIEN.MAGV IN (SELECT GVCNDT FROM DETAI)

-- Q20: Cho biết tên những giáo viên vừa là trưởng khoa và vừa là trưởng bộ môn.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.MAGV IN (SELECT TRGKHOA FROM KHOA)
    AND GIAOVIEN.MAGV IN (SELECT TRUONGBM FROM BOMON)

-- Q21: Cho biết tên những trưởng bộ môn mà vừa chủ nhiệm đề tài.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.MAGV IN (SELECT TRUONGBM FROM BOMON)
    AND GIAOVIEN.MAGV IN (SELECT GVCNDT FROM DETAI)

-- Q22: Cho biết mã số các trưởng khoa có chủ nhiệm đề tài.
SELECT 
    DISTINCT GIAOVIEN.MAGV
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.MAGV IN (SELECT TRGKHOA FROM KHOA)
    AND GIAOVIEN.MAGV IN (SELECT GVCNDT FROM DETAI);

-- Q23: Cho biết mã số các giáo viên thuộc bộ môn HTTT hoặc có tham gia đề tài mã 001.
SELECT DISTINCT G.MAGV
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
WHERE B.TENBM = N'Hệ thống thông tin'
UNION
SELECT DISTINCT TG.MAGV
FROM THAMGIADT TG
WHERE TG.MADT = '001'

-- Q24: Cho biết giáo viên làm việc cùng bộ môn với giáo viên 002.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.MABM = (SELECT MABM FROM GIAOVIEN WHERE MAGV = '002')
    AND GIAOVIEN.MAGV <> '002'

-- Q25: Tìm những giáo viên là trưởng bộ môn.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.MAGV IN (SELECT TRUONGBM FROM BOMON)

-- Q26: Cho biết họ tên và mức lương của các giáo viên.
SELECT 
    GIAOVIEN.MAGV, 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN, 
    GIAOVIEN.LUONG AS MUC_LUONG
FROM 
    GIAOVIEN

-- Q27: Cho biết số lượng giáo viên viên và tổng lương của họ.
SELECT 
    COUNT(GIAOVIEN.MAGV) AS SO_LUONG_GIAO_VIEN, 
    SUM(GIAOVIEN.LUONG) AS TONG_LUONG
FROM 
    GIAOVIEN

-- Q28: Cho biết số lượng giáo viên và lương trung bình của từng bộ môn.
SELECT 
    BOMON.TENBM, 
    COUNT(GIAOVIEN.MAGV) AS SO_LUONG_GIAO_VIEN,
    AVG(GIAOVIEN.LUONG) AS LUONG_TRUNG_BINH
FROM 
    GIAOVIEN
JOIN 
    BOMON ON GIAOVIEN.MABM = BOMON.MABM
GROUP BY 
    BOMON.TENBM

-- Q29: Cho biết tên chủ đề và số lượng đề tài thuộc về chủ đề đó.
SELECT 
    CHUDE.TENCD, 
    COUNT(DETAI.MADT) AS SO_LUONG_DE_TAI
FROM 
    CHUDE
JOIN 
    DETAI ON CHUDE.MACD = DETAI.MACD
GROUP BY 
    CHUDE.TENCD

-- Q30: Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia.
SELECT G.HOTEN, COUNT(TG.MADT) AS SoLuongDeTai
FROM GIAOVIEN G
LEFT JOIN THAMGIADT TG ON G.MAGV = TG.MAGV
GROUP BY G.HOTEN

-- Q31: Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm.
SELECT G.HOTEN, COUNT(D.MADT) AS SoLuongDeTai
FROM GIAOVIEN G
LEFT JOIN DETAI D ON G.MAGV = D.GVCNDT
GROUP BY G.HOTEN;

-- Q32: Với mỗi giáo viên, cho tên giáo viên và số người thân của giáo viên đó.
SELECT 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN, 
    COUNT(NGUOITHAN.MAGV) AS SO_NGUOI_THAN
FROM 
    GIAOVIEN
JOIN 
    NGUOITHAN ON GIAOVIEN.MAGV = NGUOITHAN.MAGV
GROUP BY 
    GIAOVIEN.HOTEN

-- Q33: Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên.
SELECT G.HOTEN
FROM GIAOVIEN G
JOIN THAMGIADT TG ON G.MAGV = TG.MAGV
GROUP BY G.HOTEN
HAVING COUNT(TG.MADT) >= 3;

-- Q34: Cho biết số lượng giáo viên đã tham gia vào đề tài "Ứng dụng hóa học xanh".
SELECT COUNT(DISTINCT TG.MAGV) AS SoLuongGV
FROM THAMGIADT TG
JOIN DETAI D ON TG.MADT = D.MADT
WHERE D.TENDT = N'Ứng dụng hóa học xanh'

-- Q35: Cho biết mức lương cao nhất của các giảng viên.
SELECT 
    MAX(GIAOVIEN.LUONG) AS LUONG_CAO_NHAT
FROM 
    GIAOVIEN;

-- Q36: Cho biết những giáo viên có lương lớn nhất.
SELECT 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN, 
    GIAOVIEN.LUONG
FROM 
    GIAOVIEN
WHERE 
    GIAOVIEN.LUONG = (SELECT MAX(LUONG) FROM GIAOVIEN)

-- Q37: Cho biết lương cao nhất trong bộ môn “HTTT”.
SELECT 
    MAX(GIAOVIEN.LUONG) AS LUONG_CAO_NHAT
FROM 
    GIAOVIEN
JOIN 
    BOMON ON GIAOVIEN.MABM = BOMON.MABM
WHERE 
    BOMON.TENBM = N'HTTT';

-- Q38: Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
SELECT TOP 1 G.HOTEN
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
WHERE B.TENBM = N'Hệ thống thông tin'
ORDER BY G.NGSINH;

-- Q39: Cho biết tên giáo viên nhỏ tuổi nhất khoa Công nghệ thông tin.
SELECT TOP 1 G.HOTEN
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
JOIN KHOA K ON B.MAKHOA = K.MAKHOA
WHERE K.TENKHOA = N'Công nghệ thông tin'
ORDER BY G.NGSINH DESC;

-- Q40: Cho biết tên giáo viên và tên khoa của giáo viên có lương cao nhất.
SELECT G.HOTEN, K.TENKHOA
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
JOIN KHOA K ON B.MAKHOA = K.MAKHOA
WHERE G.LUONG = (SELECT MAX(LUONG) FROM GIAOVIEN);

-- Q41: Cho biết những giáo viên có lương lớn nhất trong bộ môn của họ.
SELECT 
    GIAOVIEN.HOTEN AS TEN_GIAO_VIEN, 
    GIAOVIEN.LUONG, 
    BOMON.TENBM
FROM 
    GIAOVIEN
JOIN 
    BOMON ON GIAOVIEN.MABM = BOMON.MABM
WHERE 
    GIAOVIEN.LUONG = (
        SELECT MAX(LUONG) 
        FROM GIAOVIEN AS GV 
        WHERE GV.MABM = GIAOVIEN.MABM
    );

-- Q42: Cho biết những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia.
SELECT D.TENDT
FROM DETAI D
WHERE D.MADT NOT IN (SELECT MADT FROM THAMGIADT WHERE MAGV = '001')

-- Q43: Cho biết những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia. Xuất ra tên đề tài, tên người chủ nhiệm đề tài.
SELECT D.TENDT, G.HOTEN
FROM DETAI D
JOIN GIAOVIEN G ON D.GVCNDT = G.MAGV
WHERE D.MADT NOT IN (SELECT MADT FROM THAMGIADT WHERE MAGV = '001')

-- Q44: Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
SELECT G.HOTEN
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
JOIN KHOA K ON B.MAKHOA = K.MAKHOA
LEFT JOIN THAMGIADT TG ON G.MAGV = TG.MAGV
WHERE K.TENKHOA = N'Công nghệ thông tin'
AND TG.MADT IS NULL

-- Q45: Tìm những giáo viên không tham gia bất kỳ đề tài nào.
SELECT G.HOTEN
FROM GIAOVIEN G
LEFT JOIN THAMGIADT TG ON G.MAGV = TG.MAGV
WHERE TG.MADT IS NULL

-- Q46. Cho biết giáo viên có lương lớn hơn lương của giáo viên “Nguyễn Hoài An”
SELECT HOTEN, LUONG
FROM GIAOVIEN
WHERE LUONG > (SELECT LUONG FROM GIAOVIEN WHERE HOTEN = N'Nguyễn Hoài An')

-- Q47. Tìm những trưởng bộ môn tham gia tối thiểu 1 đề tài
SELECT DISTINCT G.HOTEN, B.TENBM
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
JOIN THAMGIADT TGD ON G.MAGV = TGD.MAGV
WHERE B.TRUONGBM = G.MAGV

-- Q48. Tìm giáo viên trùng tên và cùng giới tính với giáo viên khác trong cùng bộ môn
SELECT G1.HOTEN, G1.PHAI, B.TENBM
FROM GIAOVIEN G1
JOIN BOMON B ON G1.MABM = B.MABM
JOIN GIAOVIEN G2 ON G1.MAGV != G2.MAGV AND G1.HOTEN = G2.HOTEN AND G1.PHAI = G2.PHAI
WHERE G1.MABM = G2.MABM

-- Q49. Tìm những giáo viên có lương lớn hơn lương của ít nhất một giáo viên bộ môn “Công nghệ phần mềm”
SELECT G.HOTEN, G.LUONG
FROM GIAOVIEN G
WHERE G.LUONG > (SELECT LUONG FROM GIAOVIEN WHERE MABM = 'CNTT' AND G.MAGV != G.MAGV)

-- Q50. Tìm những giáo viên có lương lớn hơn lương của tất cả giáo viên thuộc bộ môn “Hệ thống thông tin”
SELECT G.HOTEN, G.LUONG
FROM GIAOVIEN G
WHERE G.LUONG > ALL (SELECT LUONG FROM GIAOVIEN WHERE MABM = 'HTTT')

-- Q51. Cho biết tên khoa có đông giáo viên nhất
SELECT TOP 1 K.TENKHOA
FROM KHOA K
JOIN BOMON B ON K.MAKHOA = B.MAKHOA
JOIN GIAOVIEN G ON B.MABM = G.MABM
GROUP BY K.TENKHOA
ORDER BY COUNT(G.MAGV) DESC

-- Q52. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
SELECT TOP 1 G.HOTEN
FROM GIAOVIEN G
JOIN DETAI D ON G.MAGV = D.GVCNDT
GROUP BY G.HOTEN
ORDER BY COUNT(D.MADT) DESC

-- Q53. Cho biết mã bộ môn có nhiều giáo viên nhất
SELECT TOP 1 B.MABM
FROM BOMON B
JOIN GIAOVIEN G ON B.MABM = G.MABM
GROUP BY B.MABM
ORDER BY COUNT(G.MAGV) DESC

-- Q54. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
SELECT TOP 1 G.HOTEN, B.TENBM
FROM GIAOVIEN G
JOIN THAMGIADT T ON G.MAGV = T.MAGV
JOIN DETAI D ON T.MADT = D.MADT
JOIN BOMON B ON G.MABM = B.MABM
GROUP BY G.HOTEN, B.TENBM
ORDER BY COUNT(D.MADT) DESC

-- Q55. Cho biết tên giáo viên tham gia nhiều đề tài nhất của bộ môn HTTT.
SELECT TOP 1 G.HOTEN
FROM GIAOVIEN G
JOIN THAMGIADT T ON G.MAGV = T.MAGV
JOIN DETAI D ON T.MADT = D.MADT
WHERE G.MABM = 'HTTT'
GROUP BY G.HOTEN
ORDER BY COUNT(D.MADT) DESC

-- Q56: Giáo viên và bộ môn có nhiều người thân nhất.
SELECT TOP 1 GV.HOTEN AS TEN_GIAO_VIEN, BM.TENBM AS TEN_BO_MON, COUNT(NT.TEN) AS SO_NGUOI_THAN
FROM GIAOVIEN GV
JOIN BOMON BM ON GV.MABM = BM.MABM
JOIN NGUOITHAN NT ON GV.MAGV = NT.MAGV
GROUP BY GV.HOTEN, BM.TENBM
ORDER BY COUNT(NT.TEN) DESC

-- Q57: Trưởng bộ môn chủ nhiệm nhiều đề tài nhất.
SELECT TOP 1 GV.HOTEN AS TEN_TRUONG_BO_MON, BM.TENBM, COUNT(DT.MADT) AS SO_DE_TAI
FROM GIAOVIEN GV
JOIN BOMON BM ON GV.MAGV = BM.TRUONGBM
JOIN DETAI DT ON GV.MAGV = DT.GVCNDT
GROUP BY GV.HOTEN, BM.TENBM
ORDER BY COUNT(DT.MADT) DESC

-- Q58: Giáo viên tham gia đủ tất cả các chủ đề.
SELECT GV.HOTEN AS TEN_GIAO_VIEN
FROM GIAOVIEN GV
JOIN THAMGIADT TG ON GV.MAGV = TG.MAGV
JOIN DETAI DT ON TG.MADT = DT.MADT
GROUP BY GV.HOTEN
HAVING COUNT(DISTINCT DT.MACD) = (SELECT COUNT(*) FROM CHUDE)

-- Q59: Đề tài được tất cả giáo viên của bộ môn HTTT tham gia.
SELECT DT.TENDT
FROM DETAI DT
JOIN THAMGIADT TG ON DT.MADT = TG.MADT
WHERE NOT EXISTS (
    SELECT 1
    FROM GIAOVIEN GV
    WHERE GV.MABM = 'HTTT' AND NOT EXISTS (
        SELECT 1
        FROM THAMGIADT TG2
        WHERE TG2.MADT = DT.MADT AND TG2.MAGV = GV.MAGV
    )
);

-- Q60: Đề tài có tất cả giảng viên bộ môn “Hệ thống thông tin” tham gia.
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
    SELECT 1
    FROM GIAOVIEN GV
    WHERE GV.MABM = 'HTTT' AND NOT EXISTS (
        SELECT 1
        FROM THAMGIADT TG
        WHERE TG.MADT = DT.MADT AND TG.MAGV = GV.MAGV
    )
);

-- Q61: Giáo viên tham gia tất cả các đề tài có mã chủ đề là QLGD.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
    SELECT 1
    FROM DETAI DT
    WHERE DT.MACD = 'QLGD' AND NOT EXISTS (
        SELECT 1
        FROM THAMGIADT TG
        WHERE TG.MADT = DT.MADT AND TG.MAGV = GV.MAGV
    )
);

-- Q62: Giáo viên tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
    SELECT 1
    FROM THAMGIADT TG_HUONG
    WHERE TG_HUONG.MAGV = (SELECT MAGV FROM GIAOVIEN WHERE HOTEN = N'Trần Trà Hương')
      AND NOT EXISTS (
          SELECT 1
          FROM THAMGIADT TG
          WHERE TG.MADT = TG_HUONG.MADT AND TG.MAGV = GV.MAGV
      )
);

-- Q63: Đề tài được tất cả giáo viên của bộ môn Hóa Hữu Cơ tham gia.
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
    SELECT 1
    FROM GIAOVIEN GV
    WHERE GV.MABM = (SELECT MABM FROM BOMON WHERE TENBM = N'Hóa hữu cơ')
      AND NOT EXISTS (
          SELECT 1
          FROM THAMGIADT TG
          WHERE TG.MADT = DT.MADT AND TG.MAGV = GV.MAGV
      )
);

-- Q64: Giáo viên tham gia tất cả các đề tài của bộ môn có chủ đề “Hệ thống thông tin”.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
    SELECT 1
    FROM DETAI DT
    WHERE DT.MACD = (SELECT MABM FROM BOMON WHERE TENBM = N'Hệ thống thông tin')
      AND NOT EXISTS (
          SELECT 1
          FROM THAMGIADT TG
          WHERE TG.MADT = DT.MADT AND TG.MAGV = GV.MAGV
      )
);

-- Q65: Giáo viên nào đã tham gia tất cả các đề tài của chủ đề "Ứng dụng công nghệ"?
SELECT DISTINCT TG.MAGV
FROM THAMGIADT TG
WHERE NOT EXISTS (
    SELECT *
    FROM DETAI DT
    WHERE DT.MACD = 'UDCN'
      AND NOT EXISTS (
          SELECT *
          FROM THAMGIADT TG2
          WHERE TG2.MADT = DT.MADT
            AND TG2.MAGV = TG.MAGV
      )
)

-- Q66: Tên giáo viên nào đã tham gia tất cả các đề tài của Trần Trà Hương làm chủ nhiệm?
SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
    SELECT *
    FROM DETAI DT
    WHERE DT.GVCNDT = '002'
      AND NOT EXISTS (
          SELECT *
          FROM THAMGIADT TG
          WHERE TG.MADT = DT.MADT
            AND TG.MAGV = GV.MAGV
      )
)

-- Q67: Tên đề tài nào mà được tất cả các giáo viên của khoa CNTT tham gia?
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
    SELECT GV.MAGV
    FROM GIAOVIEN GV
    INNER JOIN BOMON BM ON GV.MABM = BM.MABM
    WHERE BM.MAKHOA = 'CNTT'
      AND NOT EXISTS (
          SELECT *
          FROM THAMGIADT TG
          WHERE TG.MADT = DT.MADT
            AND TG.MAGV = GV.MAGV
      )
)

-- Q68: Tên giáo viên nào tham gia tất cả các công việc của đề tài "Nghiên cứu tế bào gốc"?
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
    SELECT CV.SOTT
    FROM CONGVIEC CV
    WHERE CV.MADT = '006'
      AND NOT EXISTS (
          SELECT *
          FROM THAMGIADT TG
          WHERE TG.MADT = CV.MADT
            AND TG.STT = CV.SOTT
            AND TG.MAGV = GV.MAGV
      )
)

-- Q69: Tên các giáo viên được phân công làm tất cả các đề tài có kinh phí trên 100 triệu?
SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
    SELECT DT.MADT
    FROM DETAI DT
    WHERE DT.KINHPHI > 100
      AND NOT EXISTS (
          SELECT *
          FROM THAMGIADT TG
          WHERE TG.MADT = DT.MADT
            AND TG.MAGV = GV.MAGV
      )
)

-- Q70: Tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia?
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
    SELECT GV.MAGV
    FROM GIAOVIEN GV
    INNER JOIN BOMON BM ON GV.MABM = BM.MABM
    WHERE BM.MAKHOA = 'SH'
      AND NOT EXISTS (
          SELECT *
          FROM THAMGIADT TG
          WHERE TG.MADT = DT.MADT
            AND TG.MAGV = GV.MAGV
      )
)

-- Q71: Mã số, họ tên, ngày sinh của giáo viên tham gia tất cả các công việc của đề tài “Ứng dụng hóa học xanh”.
SELECT GV.MAGV, GV.HOTEN, GV.NGSINH
FROM GIAOVIEN GV
WHERE NOT EXISTS (
    SELECT CV.SOTT
    FROM CONGVIEC CV
    WHERE CV.MADT = '005'
      AND NOT EXISTS (
          SELECT *
          FROM THAMGIADT TG
          WHERE TG.MADT = CV.MADT
            AND TG.STT = CV.SOTT
            AND TG.MAGV = GV.MAGV
      )
)

-- Q72: Cho biết mã số, họ tên, tên bộ môn và tên người quản lý chuyên môn của giáo viên tham gia tất cả các đề tài thuộc chủ đề “Nghiên cứu phát triển”.
SELECT DISTINCT 
    gv.MAGV, 
    gv.HOTEN AS TenGiaoVien, 
    bm.TENBM AS TenBoMon,
    (SELECT HOTEN FROM GIAOVIEN WHERE MAGV = gv.GVQLCM) AS NguoiQuanLyChuyenMon
FROM GIAOVIEN gv
JOIN BOMON bm ON gv.MABM = bm.MABM
JOIN THAMGIADT tg ON gv.MAGV = tg.MAGV
JOIN DETAI dt ON tg.MADT = dt.MADT
JOIN CHUDE cd ON dt.MACD = cd.MACD
WHERE cd.TENCD = N'Nghiên cứu phát triển'
GROUP BY gv.MAGV, gv.HOTEN, bm.TENBM, gv.GVQLCM

-- Q73: Cho biết họ tên, ngày sinh, tên khoa, tên trưởng khoa của giáo viên tham gia tất cả các đề tài có giáo viên “Nguyễn Hoài An” tham gia.
SELECT DISTINCT 
    gv.HOTEN AS TenGiaoVien, 
    gv.NGSINH AS NgaySinh, 
    k.TENKHOA AS TenKhoa, 
    (SELECT HOTEN FROM GIAOVIEN WHERE MAGV = k.TRGKHOA) AS TruongKhoa
FROM GIAOVIEN gv
JOIN THAMGIADT tg1 ON gv.MAGV = tg1.MAGV
JOIN DETAI dt ON tg1.MADT = dt.MADT
JOIN THAMGIADT tg2 ON dt.MADT = tg2.MADT
JOIN GIAOVIEN gv2 ON tg2.MAGV = gv2.MAGV
JOIN BOMON bm ON gv.MABM = bm.MABM
JOIN KHOA k ON bm.MAKHOA = k.MAKHOA
WHERE gv2.HOTEN = N'Nguyễn Hoài An'

-- Q74: Cho biết họ tên giáo viên khoa “Công nghệ thông tin” tham gia tất cả các công việc của đề tài có trưởng bộ môn của bộ môn đông nhất khoa “Công nghệ thông tin” làm chủ nhiệm.
WITH BoMonDongNhat AS (
    SELECT TOP 1 bm.TRUONGBM AS TruongBM
    FROM BOMON bm
    JOIN KHOA k ON bm.MAKHOA = k.MAKHOA
    WHERE k.TENKHOA = N'Công nghệ thông tin'
    GROUP BY bm.TRUONGBM
    ORDER BY COUNT(*) DESC
)
SELECT DISTINCT gv.HOTEN AS TenGiaoVien
FROM GIAOVIEN gv
JOIN BOMON bm ON gv.MABM = bm.MABM
JOIN KHOA k ON bm.MAKHOA = k.MAKHOA
JOIN THAMGIADT tg ON gv.MAGV = tg.MAGV
JOIN CONGVIEC cv ON tg.MADT = cv.MADT
WHERE k.TENKHOA = N'Công nghệ thông tin'
  AND cv.MADT IN (
      SELECT dt.MADT
      FROM DETAI dt
      WHERE dt.GVCNDT = (SELECT TruongBM FROM BoMonDongNhat)
  );

-- Q75: Cho biết họ tên giáo viên và tên bộ môn họ làm trưởng bộ môn nếu có.
SELECT 
    gv.HOTEN AS TenGiaoVien,
    bm.TENBM AS TenBoMon
FROM GIAOVIEN gv
JOIN BOMON bm ON gv.MAGV = bm.TRUONGBM

-- Q76: Cho danh sách tên bộ môn và họ tên trưởng bộ môn đó nếu có.
SELECT 
    bm.TENBM AS TenBoMon, 
    gv.HOTEN AS TruongBoMon
FROM BOMON bm
LEFT JOIN GIAOVIEN gv ON bm.TRUONGBM = gv.MAGV

-- Q77: Cho danh sách tên giáo viên và các đề tài giáo viên đó chủ nhiệm nếu có.
SELECT 
    gv.HOTEN AS TenGiaoVien,
    dt.TENDT AS TenDeTai
FROM GIAOVIEN gv
JOIN DETAI dt ON gv.MAGV = dt.GVCNDT

-- Q78: Xóa các đề tài mà giáo viên "Trần Trung Hiếu" tham gia nhưng chưa đạt yêu cầu.
DELETE FROM DETAI
WHERE MADT IN (
    SELECT tg.MADT
    FROM THAMGIADT tg
    JOIN GIAOVIEN gv ON tg.MAGV = gv.MAGV
    WHERE gv.HOTEN = N'Trần Trung Hiếu' AND tg.KETQUA IS NULL
);

-- Q79: Xuất thông tin của giáo viên và mức lương xếp hạng theo quy tắc:
SELECT MAGV, HOTEN,
       CASE 
           WHEN LUONG < 1800 THEN 'THẤP'
           WHEN LUONG >= 1800 AND LUONG <= 2200 THEN 'TRUNG BÌNH'
           ELSE 'CAO'
       END AS MUC_LUONG
FROM GIAOVIEN

-- Q80: Xuất thông tin giáo viên (MAGV, "HOTEN") và xếp hạng dựa vào mức lương. Nếu giáo viên có lương cao nhất thì hạng là 1.
SELECT 
    MAGV,
    HOTEN,
    RANK() OVER (ORDER BY LUONG DESC) AS XEP_HANG
FROM GIAOVIEN

-- Q81: Xuất thông tin thu nhập của giáo viên. Thu nhập = LƯƠNG + PHỤ CẤP. Nếu là trưởng bộ môn, phụ cấp = 300, nếu là trưởng khoa, phụ cấp = 600:
SELECT G.MAGV, G.HOTEN,
       G.LUONG + 
       CASE 
           WHEN G.MABM IN (SELECT TRUONGBM FROM BOMON WHERE TRUONGBM = G.MAGV) THEN 300
           WHEN K.TRGKHOA = G.MAGV THEN 600
           ELSE 0
       END AS THU_NHAP
FROM GIAOVIEN G
LEFT JOIN KHOA K ON G.MABM = K.MAKHOA

-- Q82: Xuất ra năm mà giáo viên dự kiến sẽ nghỉ hưu với quy định: Tuổi nghỉ hưu của Nam là 60, của Nữ là 55.
SELECT MAGV, HOTEN,
       YEAR(DATEADD(YEAR, 
           CASE 
               WHEN PHAI = N'Nam' THEN 60 - DATEDIFF(YEAR, NGSINH, GETDATE())
               WHEN PHAI = N'Nữ' THEN 55 - DATEDIFF(YEAR, NGSINH, GETDATE())
           END, GETDATE())) AS NAM_NGHI_HUU
FROM GIAOVIEN


-- RÀNG BUỘC TOÀN VẸN

-- R1: Tên phải duy nhất
ALTER TABLE GIAOVIEN ADD CONSTRAINT UQ_HOTEN UNIQUE (HOTEN)

-- R2: Trưởng bộ môn phải sinh sau trước 1975
GO
CREATE TRIGGER TRG_CHECK_TRUONGBM_BIRTHYEAR
ON BOMON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM BOMON B
        JOIN GIAOVIEN G ON B.TRUONGBM = G.MAGV
        WHERE YEAR(G.NGSINH) >= 1975
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, 'Trưởng bộ môn phải sinh trước năm 1975', 1
    END
END

-- R3: Một bộ môn có tối thiểu 1 giáo viên nữ
GO
CREATE TRIGGER trg_GiaoVienNu
ON BOMON
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM GIAOVIEN WHERE PHAI = N'Nữ' AND MABM IN (SELECT MABM FROM inserted))
    BEGIN
        RAISERROR('Bộ môn phải có tối thiểu 1 giáo viên nữ!', 16, 1)
        ROLLBACK TRANSACTION;
    END
END

-- R4: Một giáo viên phải có ít nhất 1 số điện thoại
GO
CREATE TRIGGER TRG_CHECK_GIAOVIEN_SDT
ON GV_DT
AFTER DELETE
AS
BEGIN
    IF EXISTS (
        SELECT MAGV
        FROM GIAOVIEN G
        WHERE NOT EXISTS (
            SELECT 1 FROM GV_DT D WHERE D.MAGV = G.MAGV
        )
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50003, 'Mỗi giáo viên phải có ít nhất 1 số điện thoại', 1
    END
END

-- R5: Một giáo viên có tối đa 3 số điện thoại
GO
CREATE TRIGGER TRG_CHECK_MAX_SDT
ON GV_DT
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT MAGV
        FROM GV_DT
        GROUP BY MAGV
        HAVING COUNT(*) > 3
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50004, 'Mỗi giáo viên chỉ được tối đa 3 số điện thoại', 1
    END
END

-- R6: Một bộ môn phải có tối thiểu 4 giáo viên
GO
CREATE TRIGGER TRG_CHECK_BOMON_GIAOVIEN
ON GIAOVIEN
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT MABM
        FROM GIAOVIEN
        GROUP BY MABM
        HAVING COUNT(*) < 4
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50005, 'Mỗi bộ môn phải có tối thiểu 4 giáo viên', 1
    END
END

-- R7: Trưởng bộ môn phải là người lớn tuổi nhất trong bộ môn
GO
CREATE TRIGGER TRG_CHECK_TRUONGBM_LONNHAT
ON BOMON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT B.MABM
        FROM BOMON B
        JOIN GIAOVIEN G ON B.TRUONGBM = G.MAGV
        WHERE G.NGSINH <> (
            SELECT MIN(G2.NGSINH)
            FROM GIAOVIEN G2
            WHERE G2.MABM = B.MABM
        )
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50006, 'Trưởng bộ môn phải là người lớn tuổi nhất trong bộ môn', 1
    END
END

-- R8: Giáo viên làm trưởng bộ môn không làm quản lý chuyên môn
GO
CREATE TRIGGER TRG_CHECK_TRUONG_QLCM
ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT G.MAGV
        FROM GIAOVIEN G
        JOIN BOMON B ON G.MAGV = B.TRUONGBM
        WHERE G.MAGV = G.GVQLCM
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50007, 'Giáo viên làm trưởng bộ môn không làm quản lý chuyên môn', 1
    END
END

-- R9: Giáo viên và giáo viên quản lý chuyên môn thuộc cùng bộ môn
GO
CREATE TRIGGER TRG_CHECK_GIAOVIEN_QLCM_BOMON
ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT G.MAGV
        FROM GIAOVIEN G
        JOIN GIAOVIEN QL ON G.GVQLCM = QL.MAGV
        WHERE G.MABM <> QL.MABM
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50008, 'Giáo viên và quản lý chuyên môn phải thuộc cùng bộ môn', 1
    END
END

-- R10: Mỗi giáo viên chỉ có tối đa 1 vợ/chồng
GO
CREATE TRIGGER TRG_CHECK_VO_CHONG
ON NGUOITHAN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT MAGV
        FROM NGUOITHAN
        GROUP BY MAGV
        HAVING COUNT(CASE WHEN PHAI IN ('Nam', 'Nữ') THEN 1 ELSE NULL END) > 1
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50009, 'Mỗi giáo viên chỉ có tối đa 1 vợ/chồng', 1
    END
END

-- R11: Quan hệ vợ/chồng phải khác giới
GO
CREATE TRIGGER TRG_CHECK_VO_CHONG_GIOITINH
ON NGUOITHAN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT NT.MAGV
        FROM NGUOITHAN NT
        JOIN GIAOVIEN GV ON NT.MAGV = GV.MAGV
        WHERE (GV.PHAI = 'Nam' AND NT.PHAI = 'Nam') OR (GV.PHAI = 'Nữ' AND NT.PHAI = 'Nữ')
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50010, 'Vợ/chồng phải khác giới tính', 1
    END
END

--R12: Nếu "thân nhân" có quan hệ là "con gái" hoặc "con trai" với giáo viên thì năm sinh của giáo viên phải lớn hơn năm sinh của thân nhân.
GO
CREATE TRIGGER check_nam_sinh_gv_nt
ON NGUOITHAN
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MAGV CHAR(3), @NGSINH_GV SMALldatetime, @NGSINH_NT SMALldatetime, @PHAI_NT NVARCHAR(3)
    
    SELECT @MAGV = MAGV, @NGSINH_NT = NGSINH, @PHAI_NT = PHAI FROM inserted
    SELECT @NGSINH_GV = NGSINH FROM GIAOVIEN WHERE MAGV = @MAGV
    
    IF @PHAI_NT IN ('Nam', 'Nữ') AND @NGSINH_GV <= @NGSINH_NT
    BEGIN
        RAISERROR('Năm sinh của giáo viên phải lớn hơn năm sinh của thân nhân', 16, 1)
        ROLLBACK
    END
END

-- R13: Một giáo viên chỉ làm chủ nhiệm tối đa 3 đề tài.
GO
CREATE TRIGGER check_chu_nhiem_3_de_tai
ON DETAI
FOR INSERT
AS
BEGIN
    DECLARE @GVCNDT CHAR(3), @COUNT INT
    
    SELECT @GVCNDT = GVCNDT FROM inserted
    
    SELECT @COUNT = COUNT(*) FROM DETAI WHERE GVCNDT = @GVCNDT
    
    IF @COUNT > 3
    BEGIN
        RAISERROR('Giáo viên không thể làm chủ nhiệm hơn 3 đề tài', 16, 1)
        ROLLBACK
    END
END

-- R14: Một đề tài phải có ít nhất một công việc.
GO
CREATE TRIGGER check_cong_viec_de_tai
ON CONGVIEC
FOR INSERT
AS
BEGIN
    DECLARE @MADT CHAR(3), @COUNT INT
    
    SELECT @MADT = MADT FROM inserted
    
    SELECT @COUNT = COUNT(*) FROM CONGVIEC WHERE MADT = @MADT
    
    IF @COUNT = 0
    BEGIN
        RAISERROR('Đề tài phải có ít nhất một công việc', 16, 1)
        ROLLBACK
    END
END

-- R15: Lương của giáo viên phải nhỏ hơn lương người quản lý của giáo viên đó.
GO
CREATE TRIGGER check_luong_gv_qlcm
ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MAGV CHAR(3), @LUONG_GV INT, @LUONG_GVQLCM INT
   
    SELECT @MAGV = MAGV, @LUONG_GV = LUONG FROM inserted
    SELECT @LUONG_GVQLCM = LUONG FROM GIAOVIEN WHERE MAGV = (SELECT GVQLCM FROM inserted)
    
    IF @LUONG_GV >= @LUONG_GVQLCM
    BEGIN
        RAISERROR('Lương của giáo viên phải nhỏ hơn lương của người quản lý', 16, 1)
        ROLLBACK
    END
END

-- R16: Lương của trưởng bộ môn phải lớn hơn lương của các giáo viên trong bộ môn.
GO
CREATE TRIGGER check_luong_truong_bomon
ON BOMON
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MABM CHAR(4), @MAGV_TRUONGBM CHAR(3), @LUONG_TRUONGBM INT
    
    SELECT @MABM = MABM, @MAGV_TRUONGBM = TRUONGBM FROM inserted
    SELECT @LUONG_TRUONGBM = LUONG FROM GIAOVIEN WHERE MAGV = @MAGV_TRUONGBM
    
    DECLARE @LUONG_GV INT
    DECLARE gv_cursor CURSOR FOR
    SELECT LUONG FROM GIAOVIEN WHERE MABM = @MABM AND MAGV != @MAGV_TRUONGBM
    
    OPEN gv_cursor
    FETCH NEXT FROM gv_cursor INTO @LUONG_GV
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @LUONG_GV >= @LUONG_TRUONGBM
        BEGIN
            RAISERROR('Lương của trưởng bộ môn phải lớn hơn lương của giáo viên trong bộ môn', 16, 1)
            ROLLBACK;
            CLOSE gv_cursor
            DEALLOCATE gv_cursor
            RETURN;
        END
        FETCH NEXT FROM gv_cursor INTO @LUONG_GV
    END
    
    CLOSE gv_cursor
    DEALLOCATE gv_cursor
END

-- R17: Bộ môn ban nào cũng phải có trưởng bộ môn và trưởng bộ môn phải là một giáo viên trong trường.
GO
CREATE TRIGGER check_truong_bomon
ON BOMON
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MABM CHAR(4), @MAGV_TRUONGBM CHAR(3)
    
    SELECT @MABM = MABM, @MAGV_TRUONGBM = TRUONGBM FROM inserted
    
    IF NOT EXISTS (SELECT 1 FROM GIAOVIEN WHERE MAGV = @MAGV_TRUONGBM)
    BEGIN
        RAISERROR('Trưởng bộ môn phải là một giáo viên trong trường', 16, 1)
        ROLLBACK
    END
END

-- R18: Một giáo viên chỉ quản lý tối đa 3 giáo viên khác.
GO
CREATE TRIGGER check_quan_ly_gv
ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MAGV CHAR(3), @COUNT INT
    
    SELECT @MAGV = MAGV FROM inserted
    
    SELECT @COUNT = COUNT(*) FROM GIAOVIEN WHERE GVQLCM = @MAGV
    
    IF @COUNT > 3
    BEGIN
        RAISERROR('Giáo viên chỉ có thể quản lý tối đa 3 giáo viên khác', 16, 1);
        ROLLBACK
    END
END

-- R19: Giáo viên chỉ tham gia những đề tài mà giáo viên chủ nhiệm đề tài là người cùng bộ môn với giáo viên đó.
GO
CREATE TRIGGER trg_ThamGiaDeTai
ON THAMGIADT
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM THAMGIADT t
        JOIN DETAI d ON t.MADT = d.MADT
        JOIN GIAOVIEN g ON t.MAGV = g.MAGV
        WHERE g.MABM <> d.GVCNDT
    )
    BEGIN
        RAISERROR('Giáo viên chỉ tham gia những đề tài mà giáo viên chủ nhiệm đề tài là người cùng bộ môn với giáo viên đó!', 16, 1)
        ROLLBACK
	END
END
