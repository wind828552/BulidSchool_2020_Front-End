-- �C�X�@������S�R���Ȥ�W��

SELECT c.CompanyName
FROM Customers c
WHERE NOT EXISTS(
	SELECT*
	FROM Orders o
	WHERE o.CustomerID = c.CustomerID
)