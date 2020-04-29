--�C�X�ثe�S���w�s�����~,�b�L�h���g�Q���ǫȤ�q�ʹL

SELECT
	P.ProductID, O.CustomerID,
	COUNT(O.CustomerID)
FROM Products P
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
WHERE P.UnitsInStock = 0
GROUP BY P.ProductID, O.CustomerID
ORDER BY O.CustomerID ASC

