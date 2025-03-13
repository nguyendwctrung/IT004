USE QuanLyBanHang_DB

-- 1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NSX = 'Trung Quoc'
AND MASP NOT IN (
    SELECT MASP
    FROM CTHD
    JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
    WHERE YEAR(NGHD) = 2006
)

-- 2. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua? 
SELECT COUNT(DISTINCT SOHD)
FROM HOADON
WHERE MAKH IS NULL

-- 3. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT MASP)
FROM CTHD
JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(NGHD) = 2006

-- 4. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA) AS MaxInvoice, MIN(TRIGIA) AS MinInvoice
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 5. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS AverageInvoice
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 6. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) AS TotalRevenue
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 7. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT COUNT(SOHD) AS MaxInvoiceCount
FROM HOADON
WHERE YEAR(NGHD) = 2006
AND TRIGIA = (SELECT MAX(TRIGIA) FROM HOADON WHERE YEAR(NGHD) = 2006)

-- 8. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT KH.HOTEN
FROM KHACHHANG KH
JOIN HOADON H ON KH.MAKH = H.MAKH
WHERE H.TRIGIA = (SELECT MAX(TRIGIA) FROM HOADON WHERE YEAR(NGHD) = 2006)
AND YEAR(H.NGHD) = 2006

-- 9. In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số giảm dần.
SELECT TOP 3 KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
JOIN HOADON H ON KH.MAKH = H.MAKH
WHERE YEAR(H.NGHD) = 2006
GROUP BY KH.MAKH, KH.HOTEN
ORDER BY SUM(H.TRIGIA) DESC

-- 10. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE GIA IN (
    SELECT TOP 3 GIA
    FROM SANPHAM
    ORDER BY GIA DESC
)

-- 11. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NSX = 'Thai Lan'
AND GIA IN (
    SELECT TOP 3 GIA
    FROM SANPHAM
    ORDER BY GIA DESC
)

-- 12. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NSX = 'Trung Quoc'
AND GIA IN (
    SELECT TOP 3 GIA
    FROM SANPHAM
    WHERE NSX = 'Trung Quoc'
    ORDER BY GIA DESC
)

-- 13. In ra danh sách khách hàng nằm trong 3 hạng cao nhất (xếp hạng theo doanh số).
SELECT TOP 3 KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
JOIN HOADON H ON KH.MAKH = H.MAKH
WHERE YEAR(H.NGHD) = 2006
GROUP BY KH.MAKH, KH.HOTEN
ORDER BY SUM(H.TRIGIA) DESC

-- 14. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT SUM(CTHD.SL) AS TotalQuantity
FROM CTHD
JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
WHERE SP.NSX = 'Trung Quoc'

-- 15. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT SP.NSX, SUM(CTHD.SL) AS TotalQuantity
FROM CTHD
JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
GROUP BY SP.NSX

-- 16. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NSX, MAX(GIA) AS MaxPrice, MIN(GIA) AS MinPrice, AVG(GIA) AS AvgPrice
FROM SANPHAM
GROUP BY NSX

-- 17. Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA) AS DailyRevenue
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY NGHD

-- 18. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT MASP, SUM(CTHD.SL) AS TotalQuantity
FROM CTHD
JOIN HOADON H ON CTHD.SOHD = H.SOHD
WHERE MONTH(H.NGHD) = 10 AND YEAR(H.NGHD) = 2006
GROUP BY MASP

-- 19. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) AS Month, SUM(TRIGIA) AS MonthlyRevenue
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY Month

-- 20. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT SOHD
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) >= 4

-- 21. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT HOADON.SOHD
FROM HOADON
JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
WHERE SANPHAM.NSX = 'Viet Nam'
GROUP BY HOADON.SOHD
HAVING COUNT(DISTINCT CTHD.MASP) = 3


-- 22. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT TOP 1 KHACHHANG.MAKH, HOTEN
FROM KHACHHANG 
JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
GROUP BY KHACHHANG.MAKH, HOTEN
ORDER BY COUNT(SOHD) DESC

-- 23. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?
SELECT TOP 1 MONTH(NGHD) AS Month, SUM(TRIGIA) AS MonthlyRevenue
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY MonthlyRevenue DESC

-- 24. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT TOP 1 CTHD.MASP, SANPHAM.TENSP
FROM CTHD
JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(HOADON.NGHD) = 2006
GROUP BY CTHD.MASP, SANPHAM.TENSP
ORDER BY SUM(CTHD.SL) ASC

-- 25. Mỗi nước sản xuất, tìm sản phẩm (MASP, TENSP) có giá bán cao nhất.
SELECT MASP, TENSP, NSX
FROM SANPHAM AS S1
WHERE GIA = (
    SELECT MAX(GIA)
    FROM SANPHAM AS S2
    WHERE S1.NSX = S2.NSX
)
ORDER BY NSX

-- 26. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT NSX
FROM SANPHAM
GROUP BY NSX
HAVING COUNT(DISTINCT GIA) >= 3

-- 27. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
WITH Top10KhachHang AS (
    SELECT TOP 10 MAKH, SUM(TRIGIA) AS DoanhSo
    FROM HOADON
    GROUP BY MAKH
    ORDER BY DoanhSo DESC
)
SELECT TOP 1 KH.MAKH, KH.HOTEN
FROM KHACHHANG AS KH
JOIN (
    SELECT MAKH, COUNT(SOHD) AS SoLanMua
    FROM HOADON
    WHERE MAKH IN (SELECT MAKH FROM Top10KhachHang)
    GROUP BY MAKH
) AS T ON KH.MAKH = T.MAKH
ORDER BY T.SoLanMua DESC
