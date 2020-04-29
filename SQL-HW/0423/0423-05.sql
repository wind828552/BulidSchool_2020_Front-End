-- �C�X�̤֤H�R�����~

SELECT TOP 1
	p.ProductName,
	COUNT(od.Quantity)
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY p.ProductName
ORDER BY COUNT(od.Quantity) ASC