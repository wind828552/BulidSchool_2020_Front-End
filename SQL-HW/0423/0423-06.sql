-- 列出每個產品，供應商 (Suppliers) 所賣出的產品總金額

SELECT 
	su.CompanyName,
	SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS TOtal
FROM Suppliers su
INNER JOIN Products p ON p.SupplierID = su.SupplierID
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY su.CompanyName