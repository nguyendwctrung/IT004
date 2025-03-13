USE QuanLyGiaoVu_DB

-- 19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT TOP 1 MAKHOA, TENKHOA
FROM KHOA
ORDER BY NGTLap ASC

-- 20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(*) AS So_Giao_Vien
FROM GIAOVIEN
WHERE HOCHAM IN ('GS', 'PGS')

-- 21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT MAKHOA, COUNT(*) AS So_Giao_Vien
FROM GIAOVIEN
WHERE HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS')
GROUP BY MAKHOA

-- 22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT MONHOC.MAMH, MONHOC.TENMH,
       SUM(CASE WHEN KQUA = 'DAT' THEN 1 ELSE 0 END) AS So_Hoc_Vien_Dat,
       SUM(CASE WHEN KQUA = 'KHONG_DAT' THEN 1 ELSE 0 END) AS So_Hoc_Vien_Khong_Dat
FROM KETQUATHI
JOIN MONHOC ON KETQUATHI.MAMH = MONHOC.MAMH
GROUP BY MONHOC.MAMH, MONHOC.TENMH

-- 23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
SELECT DISTINCT GIAOVIEN.MAGV, GIAOVIEN.HOTEN
FROM GIAOVIEN
JOIN LOP ON GIAOVIEN.MAGV = LOP.MAGVCN
JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
WHERE GIANGDAY.MALOP = LOP.MALOP

-- 24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT LOP.TRGLOP
FROM LOP
WHERE SISO = (SELECT MAX(SISO) FROM LOP)

-- 25. Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE KQUA = 'KHONG_DAT'
GROUP BY HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
HAVING COUNT(KQUA) <= 3

-- 26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT TOP 1 HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE DIEM >= 9
GROUP BY HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
ORDER BY COUNT(*) DESC

-- 27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT H.MALOP, H.MAHV, H.HO, H.TEN
FROM HOCVIEN H
JOIN (
    SELECT MALOP, K.MAHV, COUNT(*) AS SoMonDat
    FROM KETQUATHI K
    JOIN HOCVIEN H ON K.MAHV = H.MAHV
    WHERE K.DIEM >= 9
    GROUP BY MALOP, K.MAHV
) AS MonDat ON H.MAHV = MonDat.MAHV
JOIN (
    SELECT MALOP, MAX(SoMonDat) AS MaxSoMonDat
    FROM (
        SELECT MALOP, K.MAHV, COUNT(*) AS SoMonDat
        FROM KETQUATHI K
        JOIN HOCVIEN H ON K.MAHV = H.MAHV
        WHERE K.DIEM >= 9
        GROUP BY MALOP, K.MAHV
    ) AS SubQuery
    GROUP BY MALOP
) AS MaxMonDat ON MonDat.MALOP = MaxMonDat.MALOP AND MonDat.SoMonDat = MaxMonDat.MaxSoMonDat

-- 28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT MAGV, HOCKY, NAM,
       COUNT(DISTINCT MAMH) AS SoMon,
       COUNT(DISTINCT MALOP) AS SoLop
FROM GIANGDAY
GROUP BY MAGV, HOCKY, NAM

-- 29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
SELECT GIAOVIEN.MAGV, GIAOVIEN.HOTEN
FROM GIAOVIEN
JOIN (
    SELECT MAGV, COUNT(*) AS SoMon
    FROM GIANGDAY
    GROUP BY MAGV
    HAVING COUNT(*) = (
        SELECT MAX(SoMon)
        FROM (
            SELECT MAGV, COUNT(*) AS SoMon
            FROM GIANGDAY
            GROUP BY MAGV
        ) AS SubQuery
    )
) AS MaxMon ON GIAOVIEN.MAGV = MaxMon.MAGV

-- 30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT MAMH, TENMH
FROM MONHOC
WHERE MAMH IN (
    SELECT MAMH
    FROM KETQUATHI
    WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
    GROUP BY MAMH
    HAVING COUNT(MAHV) = (
        SELECT MAX(CountKhongDat)
        FROM (
            SELECT MAMH, COUNT(MAHV) AS CountKhongDat
            FROM KETQUATHI
            WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
            GROUP BY MAMH
        ) AS SubQuery
    )
)

-- 31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT MAHV, HO, TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
    SELECT MAHV
    FROM KETQUATHI
    WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
)

-- 32. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT H.MAHV, H.HO, H.TEN
FROM HOCVIEN H
JOIN KETQUATHI K ON H.MAHV = K.MAHV
WHERE K.LANTHI = (
    SELECT MAX(LANTHI)
    FROM KETQUATHI K2
    WHERE K2.MAHV = K.MAHV AND K2.MAMH = K.MAMH
)
GROUP BY H.MAHV, H.HO, H.TEN
HAVING COUNT(CASE WHEN K.KQUA = 'Khong Dat' THEN 1 END) = 0

-- 33. Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).
SELECT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
    SELECT MAHV
    FROM KETQUATHI
    WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
    GROUP BY MAHV
    HAVING COUNT(DISTINCT MAMH) = (SELECT COUNT(DISTINCT MAMH) FROM KETQUATHI))

-- 34. Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi sau cùng).
SELECT H.MAHV, H.HO, H.TEN
FROM HOCVIEN H
JOIN KETQUATHI K ON H.MAHV = K.MAHV
WHERE K.LANTHI = (
    SELECT MAX(LANTHI)
    FROM KETQUATHI K2
    WHERE K2.MAHV = K.MAHV AND K2.MAMH = K.MAMH
)
GROUP BY H.MAHV, H.HO, H.TEN
HAVING COUNT(CASE WHEN K.KQUA = 'Khong Dat' THEN 1 END) = 0
AND COUNT(DISTINCT K.MAMH) = (SELECT COUNT(DISTINCT M.MAMH) FROM MONHOC M)

-- 35. Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
SELECT H.MAHV, H.HO, H.TEN, K.MAMH, K.DIEM
FROM HOCVIEN H
JOIN KETQUATHI K ON H.MAHV = K.MAHV
WHERE K.LANTHI = (
    SELECT MAX(LANTHI)
    FROM KETQUATHI K2
    WHERE K2.MAHV = K.MAHV AND K2.MAMH = K.MAMH
)
AND K.DIEM = (
    SELECT MAX(K3.DIEM)
    FROM KETQUATHI K3
    WHERE K3.MAMH = K.MAMH
)
ORDER BY K.MAMH