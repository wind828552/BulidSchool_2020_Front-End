-- �C�X�q�ӨS������ (Discount) �X�⪺���~

--��Ҧ��馩�[�_��
--�b�L�o�� ����0����ܥX��
SELECT
	OD.ProductID, 
	SUM(OD.Discount)
FROM [Order Details] OD
GROUP BY OD.ProductID
HAVING SUM(OD.Discount) = 0
