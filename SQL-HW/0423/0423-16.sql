-- �C�X�̷�Q�Ȥ��ܪ��f�B�� (Shippers)

SELECT TOP 1
	SH.CompanyName,
	COUNT(O.ShipVia)
FROM Shippers SH
INNER JOIN Orders O ON O.ShipVia = SH.ShipperID
GROUP BY SH.CompanyName
ORDER BY COUNT(O.ShipVia) DESC