-- �C�X���O�`���B�A����Ҧ��Ȥᥭ�����O�`���B�A���Ȥ᪺�W�r�A�H�ΡA�Ȥ᪺���O�`���B

SELECT
	c.CompanyName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) As total --���O�`���B
	--( SELECT COUNT(c.CustomerID) FROM Customers c ) �Ȥ�ƶq
FROM [Order Details] od
INNER JOIN Orders o ON o.OrderID = od.OrderID
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY C.CompanyName --�ΫȤ�W�ٰ����s �o�˷|�H�Ȥ�W�ٰ����s�p����B
HAVING SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) > 
(	SELECT
		SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) / (SELECT COUNT(c.CustomerID) FROM Customers c)
	FROM
		[Order Details] od
)
--�������B
	SELECT
		SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) / (SELECT COUNT(c.CustomerID) FROM Customers c)
	FROM
		[Order Details] od
	