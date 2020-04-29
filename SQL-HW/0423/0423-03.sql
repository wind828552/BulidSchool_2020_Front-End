-- 列出所有產品，以及該產品被購買的總金額

SELECT
	--顯示產品名稱及計算金額 然後用GROUP BY分群
	p.productName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) As total --消費總金額
FROM [Order Details] od
--讓od.ProductID去連結到p.ProductID
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.productName
