
-- 列出所有產品名稱與價格，以及該產品與平均產品價格的差價
DECLARE @avg money
SELECT @avg = AVG(UnitPrice) FROM Products
SELECT
	ProductName, UnitPrice, UnitPrice - @avg AS DiffPrice
FROM Products

-- 列出所有客戶的名字，以及客戶的消費總金額
SELECT
	CompanyName, 
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY CompanyName

-- 以下是作業 *************************


-- 列出消費總金額高於所有客戶平均消費總金額的客戶的名字，
-- 以及客戶的消費總金額
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


-- 列出一毛錢都沒買的客戶名稱
SELECT
	CompanyName
FROM Customers c
LEFT OUTER JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL


-- 列出所有產品，以及該產品被購買的總金額
SELECT
	p.ProductName, 
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Products p
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY p.ProductName


-- 列出最熱銷的產品，以及被購買的總金額
SELECT TOP 1
	p.ProductName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Total DESC


-- 列出最少人買的產品
SELECT TOP 1
	p.ProductName, COUNT(*) AS Total
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Total


-- 列出每個產品供應商 (Suppliers) 所賣出的產品總金額
SELECT
	s.CompanyName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Suppliers s
INNER JOIN Products p ON p.SupplierID = s.SupplierID
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY s.CompanyName


-- 列出每一位員工 (Employees) 的業績
SELECT
	e.FirstName, 
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Employees e
INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY e.FirstName


-- 列出銷售總金額最高的城市 (Customers.City)
SELECT TOP 1
	City,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY City
ORDER BY Total DESC

-- 列出最沒人要買的產品類別 (Categories)
SELECT TOP 1
	c.CategoryName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Categories c
INNER JOIN Products p ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY Total

-- 列出跟銷售最好的供應商買最多金額的客戶與購買金額 
-- (不含購買其它供應商的產品)
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

-- 列出跟銷售最好的供應商買最多金額的客戶與購買金額
-- (含購買其它供應商的產品)



-- 列出那些產品沒有人買過
SELECT
	p.ProductName
FROM Products p
LEFT OUTER JOIN [Order Details] od ON od.ProductID = p.ProductID
WHERE od.OrderID IS NULL


-- 列出沒有傳真 (Fax) 的客戶和它的消費總金額
SELECT
	c.CompanyName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE c.Fax IS NULL
GROUP BY c.CompanyName


-- 列出每一個城市消費的產品種類數量
SELECT
	c.City, cat.CategoryName, COUNT(*) Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY c.City, cat.CategoryName
ORDER BY c.City, cat.CategoryName


-- 列出從來沒有打折 (Discount) 出售的產品
SELECT
	od.ProductID, SUM(od.Discount) AS Total
FROM [Order Details] od
GROUP BY od.ProductID
HAVING SUM(od.Discount) = 0


-- 列出最常被客戶選擇的貨運商 (Shippers)
SELECT TOP 1
	s.CompanyName, COUNT(*) No
FROM Shippers s
INNER JOIN Orders o ON o.ShipVia = s.ShipperID
GROUP BY s.CompanyName
ORDER BY COUNT(*) DESC

-- 列出不同國家 (Country) 的客戶消費總金額
SELECT
	c.Country,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) AS Total
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.Country
