CREATE Procedure [dbo].[_TempDetOrd_TX_PorNumeroLote]

@NumeroLote int

AS 

SELECT *
FROM _TempDETORD
WHERE DORNRO=@NumeroLote
