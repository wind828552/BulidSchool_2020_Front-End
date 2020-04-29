-- 列出沒有傳真 (Fax) 的客戶和它的消費總金額

SELECT
	c.CompanyName,
	SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS Total
FROM Customers c
INNER JOIN Orders O ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE Fax IS NULL
GROUP BY C.CompanyName
