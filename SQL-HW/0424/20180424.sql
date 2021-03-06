-- 列出
--   CustomerID, CompanyName, City, 定單筆數, 定單總金額
SELECT
	CustomerID, CompanyName, City, (
		SELECT COUNT(*) FROM Orders o
		WHERE o.CustomerID = c.CustomerID
	) AS OrderCount, (
		SELECT
			SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
		FROM [Order Details] od
		INNER JOIN Orders o ON od.OrderID = o.OrderID
		WHERE o.CustomerID = c.CustomerID
	) AS Amount
FROM Customers c

-- 列出目前沒有庫存的產品在過去總共被訂購的數量
SELECT
	*, (
		SELECT
			SUM(od.Quantity)
		FROM [Order Details] od
		WHERE od.ProductID = p.ProductID
	) AS Total
FROM Products p
WHERE p.UnitsInStock = 0


SELECT
	od.ProductID, SUM(od.Quantity)
FROM [Order Details] od
WHERE od.ProductID IN (
	SELECT ProductID FROM Products
	WHERE UnitsInStock = 0
)
GROUP BY od.ProductID

-- 列出目前沒有庫存的產品在過去曾經被那些客戶訂購過
SELECT DISTINCT
	p.ProductID, o.CustomerID
FROM Products p
LEFT OUTER JOIN [Order Details] od ON od.ProductID = p.ProductID
LEFT OUTER JOIN Orders o ON od.OrderID = o.OrderID
WHERE p.UnitsInStock = 0


-- 列出每位員工的下屬的業績總金額
SELECT
	e.ReportsTo,
	SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
FROM Employees e
INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY e.ReportsTo
HAVING e.ReportsTo IS NOT NULL

-- 列出每家貨運公司運送最多的那一種產品類別與總數量

-- 列出每一個客戶買最多的產品類別與金額
WITH t1 (CustomerID, CategoryID, Amount, No)
AS
(
	SELECT
		o.CustomerID, p.CategoryID,
		SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Amount,
		ROW_NUMBER() OVER (
			PARTITION BY o.CustomerID
			ORDER BY SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) DESC
		) AS No
	FROM Orders o
	INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
	INNER JOIN Products p ON od.ProductID = p.ProductID
	GROUP BY o.CustomerID, p.CategoryID
)
SELECT 
	CustomerID, CategoryID, Amount
FROM t1
WHERE No = 1
ORDER BY CustomerID, CategoryID

-- 列出每一個客戶買最多的那一個產品與購買數量

-- 按照城市分類，找出每一個城市最近一筆訂單的送貨時間

-- 列出年紀最大的員工最早的一筆訂單的日期

-- 列出每一個客戶所購買的同城市供應商所生產的產品

-- 列出每一個客戶所購買的同城市供應商所生產的產品的總銷售金額

-- 列出平均單價以上的產品在不同城市的銷售量

-- 列出購買每一個產品的客戶數量

-- 列出購買每一類產品的客戶數量

-- 列出業績最差的員工賣最好的產品

-- 列出職稱 (ContactTitle) 是 Sales 開頭的客戶最近一次訂單購買的產品清單

-- 列出公司最資深員工與最資淺員工之間的業績差距

-- 列出不同國家與不同產品類別的銷售量統計

-- 列出每個國家中賣得最好的產品與銷售金額

-- 列出銷售量最多的城市各類型產品的銷售明細
