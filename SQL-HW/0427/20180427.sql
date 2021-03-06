-- 列出價格高於平均價格的產品

-- 寫一支預存程序，用來新增一筆供應商 (Suppliers) 資料

-- 列出銷售數量最高的產品是那些客戶訂的，每年度分別訂多少

-- 建立 PIVOT 表，統計銷售金額如下：
-- City, [Beverages], [Condiments], [Seafood]
SELECT  City, [Beverages], [Condiments], [Seafood]
FROM (
	SELECT  c.City, cat.CategoryName, od.Quantity * od.UnitPrice * (1-od.Discount) AS Total
	FROM [Order Details] od
	INNER JOIN Orders o ON o.OrderID = od.OrderID
	INNER JOIN Products p ON od.ProductID = p.ProductID
	INNER JOIN Categories cat ON p.CategoryID = cat.CategoryID
	INNER JOIN Customers c ON o.CustomerID = c.CustomerID
) AS t
PIVOT(SUM(t.Total) FOR t.CategoryName
	IN ([Beverages], [Condiments], [Seafood])
) AS pvt
ORDER BY City



-- 寫一個 Table Value Functuon (TVF) 可以帶入城市名稱，
-- 得到該城市的資料 (如上一題)

-- 使用 NTILE window 函數，以銷售金額分成 5 等分，
-- 統計不同國家的客戶在這 5 個級距的平均銷售金額
-- Country, [1], [2], [3], [4], [5]

-- 將上一題的結果放到一個新的表格中，表格名稱: SalesRange

-- 按照 UnitPrice 由大排到小，找出與前一筆產品價格相差 5 元以上的產品

-- 寫一個 TVF 可以帶入上一題所要過濾的價格差 @diff_price，
-- 傳回與前一筆價格相差 @diff_price 的產品

-- 列出購買金額第五名與第十名的客戶，以及兩個客戶的金額差距








