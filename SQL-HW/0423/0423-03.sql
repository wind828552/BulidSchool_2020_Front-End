-- �C�X�Ҧ����~�A�H�θӲ��~�Q�ʶR���`���B

SELECT
	--��ܲ��~�W�٤έp����B �M���GROUP BY���s
	p.productName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) As total --���O�`���B
FROM [Order Details] od
--��od.ProductID�h�s����p.ProductID
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.productName
