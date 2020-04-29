-- 列出最當被客戶選擇的貨運商 (Shippers)

SELECT TOP 1
	SH.CompanyName,
	COUNT(O.ShipVia)
FROM Shippers SH
INNER JOIN Orders O ON O.ShipVia = SH.ShipperID
GROUP BY SH.CompanyName
ORDER BY COUNT(O.ShipVia) DESC