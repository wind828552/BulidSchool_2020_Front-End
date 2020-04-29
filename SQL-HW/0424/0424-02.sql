-- �C�X�ثe�S���w�s�����~,�b�L�h�`�@�Q�q�ʪ��ƶq
--����{�b�S���w�s�����~��ܥX��
SELECT
	*
FROM Products P
WHERE P.UnitsInStock = 0 
--�{�b�S���w�s �i��N��h�~�e�~���R�L 
--�ҥH��R�L���ƶq�[�`�_�ӨåB�β��~ID���s
--�M��bod�̭������~id�䦳�S���{�b�O�w�s����0��id

--�ⴿ�g�Ҧ��ʶR���ƶq�[�`�_�� �M������O�{�b�w�s����0�����~�Q��od���~id���s��ܥX��
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