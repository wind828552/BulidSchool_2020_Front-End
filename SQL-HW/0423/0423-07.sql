-- 列出每一位員工 (Employees) 的業績

SELECT 
	e.FirstName,
	SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS Total
FROM Employees e
INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY e.FirstName