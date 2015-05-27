



CREATE Procedure [dbo].[DepositosBancarios_TX_DetallesPorIdValor]
@IdValor int
AS 
SELECT DetDep.*
FROM DetalleDepositosBancarios DetDep
LEFT OUTER JOIN DepositosBancarios ON DetDep.IdDepositoBancario=DepositosBancarios.IdDepositoBancario
WHERE DetDep.IdValor=@IdValor and 
	IsNull(DepositosBancarios.Anulado,'NO')<>'SI'



