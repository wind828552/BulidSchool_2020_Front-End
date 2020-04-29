-- 列出目前沒有庫存的產品,在過去總共被訂購的數量
--先把現在沒有庫存的產品顯示出來
SELECT
	*
FROM Products P
WHERE P.UnitsInStock = 0 
--現在沒有庫存 可能代表去年前年有買過 
--所以把買過的數量加總起來並且用產品ID分群
--然後在od裡面的產品id找有沒有現在是庫存等於0的id

--把曾經所有購買的數量加總起來 然後把條件是現在庫存等於0的產品利用od產品id分群顯示出來
SELECT
	OD.ProductID,
	SUM(OD.Quantity) AS Total
FROM [Order Details] OD
WHERE OD.ProductID IN
(
SELECT 
	P.ProductID
FROM Products P
WHERE P.UnitsInStock = 0
)
GROUP BY OD.ProductID