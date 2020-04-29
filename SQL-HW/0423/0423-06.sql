-- �C�X�C�Ӳ��~�A������ (Suppliers) �ҽ�X�����~�`���B

SELECT 
	su.CompanyName,
	SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS TOtal
FROM Suppliers su
INNER JOIN Products p ON p.SupplierID = su.SupplierID
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY su.CompanyName