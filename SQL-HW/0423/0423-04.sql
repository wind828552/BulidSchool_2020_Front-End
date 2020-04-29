-- 列出最熱銷的產品，以及被購買的總金額

SELECT Top 1
	p.ProductName,
	SUM(od.UnitPrice*od.Quantity*(1-od.Discount))AS Total
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY p.ProductName 
ORDER BY Total DESC