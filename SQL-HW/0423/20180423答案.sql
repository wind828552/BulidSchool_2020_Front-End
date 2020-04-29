
-- �C�X�Ҧ����~�W�ٻP����A�H�θӲ��~�P�������~���檺�t��
DECLARE @avg money
SELECT @avg = AVG(UnitPrice) FROM Products
SELECT
	ProductName, UnitPrice, UnitPrice - @avg AS DiffPrice
FROM Products

-- �C�X�Ҧ��Ȥ᪺�W�r�A�H�ΫȤ᪺���O�`���B
SELECT
	CompanyName, 
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY CompanyName

-- �H�U�O�@�~ *************************


-- �C�X���O�`���B����Ҧ��Ȥᥭ�����O�`���B���Ȥ᪺�W�r�A
-- �H�ΫȤ᪺���O�`���B
DECLARE @sum money
SELECT @sum = SUM(UnitPrice * Quantity * (1-Discount)) 
FROM [Order Details]

DECLARE @count int
SELECT @count = COUNT(*) FROM Customers

DECLARE @avg money
SET @avg = @sum / @count

SELECT
	CompanyName, 
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY CompanyName
HAVING SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) > @avg


-- �C�X�@������S�R���Ȥ�W��
SELECT
	CompanyName
FROM Customers c
LEFT OUTER JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL


-- �C�X�Ҧ����~�A�H�θӲ��~�Q�ʶR���`���B
SELECT
	p.ProductName, 
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Products p
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY p.ProductName


-- �C�X�̼��P�����~�A�H�γQ�ʶR���`���B
SELECT TOP 1
	p.ProductName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Total DESC


-- �C�X�̤֤H�R�����~
SELECT TOP 1
	p.ProductName, COUNT(*) AS Total
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Total


-- �C�X�C�Ӳ��~������ (Suppliers) �ҽ�X�����~�`���B
SELECT
	s.CompanyName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Suppliers s
INNER JOIN Products p ON p.SupplierID = s.SupplierID
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY s.CompanyName


-- �C�X�C�@����u (Employees) ���~�Z
SELECT
	e.FirstName, 
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Employees e
INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY e.FirstName


-- �C�X�P���`���B�̰������� (Customers.City)
SELECT TOP 1
	City,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY City
ORDER BY Total DESC

-- �C�X�̨S�H�n�R�����~���O (Categories)
SELECT TOP 1
	c.CategoryName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Categories c
INNER JOIN Products p ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY Total

-- �C�X��P��̦n�������ӶR�̦h���B���Ȥ�P�ʶR���B 
-- (���t�ʶR�䥦�����Ӫ����~)
DECLARE @sid int
SELECT TOP 1
	@sid = s.SupplierID
FROM Suppliers s
INNER JOIN Products p ON p.SupplierID = s.SupplierID
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY s.SupplierID
ORDER BY SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) DESC

SELECT TOP 1
	c.CompanyName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierID = @sid
GROUP BY c.CompanyName
ORDER BY Total DESC

-- �C�X��P��̦n�������ӶR�̦h���B���Ȥ�P�ʶR���B
-- (�t�ʶR�䥦�����Ӫ����~)



-- �C�X���ǲ��~�S���H�R�L
SELECT
	p.ProductName
FROM Products p
LEFT OUTER JOIN [Order Details] od ON od.ProductID = p.ProductID
WHERE od.OrderID IS NULL


-- �C�X�S���ǯu (Fax) ���Ȥ�M�������O�`���B
SELECT
	c.CompanyName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE c.Fax IS NULL
GROUP BY c.CompanyName


-- �C�X�C�@�ӫ������O�����~�����ƶq
SELECT
	c.City, cat.CategoryName, COUNT(*) Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY c.City, cat.CategoryName
ORDER BY c.City, cat.CategoryName


-- �C�X�q�ӨS������ (Discount) �X�⪺���~
SELECT
	od.ProductID, SUM(od.Discount) AS Total
FROM [Order Details] od
GROUP BY od.ProductID
HAVING SUM(od.Discount) = 0


-- �C�X�̱`�Q�Ȥ��ܪ��f�B�� (Shippers)
SELECT TOP 1
	s.CompanyName, COUNT(*) No
FROM Shippers s
INNER JOIN Orders o ON o.ShipVia = s.ShipperID
GROUP BY s.CompanyName
ORDER BY COUNT(*) DESC

-- �C�X���P��a (Country) ���Ȥ���O�`���B
SELECT
	c.Country,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.Country
