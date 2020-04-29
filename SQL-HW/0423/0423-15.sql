-- 列出從來沒有打折 (Discount) 出售的產品

--把所有折扣加起來
--在過濾掉 等於0的顯示出來
SELECT
	OD.ProductID, 
	SUM(OD.Discount)
FROM [Order Details] OD
GROUP BY OD.ProductID
HAVING SUM(OD.Discount) = 0
