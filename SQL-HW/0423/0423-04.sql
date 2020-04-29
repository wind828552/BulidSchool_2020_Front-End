-- �C�X�̼��P�����~�A�H�γQ�ʶR���`���B

SELECT Top 1
	p.ProductName,
	SUM(od.UnitPrice*od.Quantity*(1-od.Discount))AS Total
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY p.ProductName 
ORDER BY Total DESC