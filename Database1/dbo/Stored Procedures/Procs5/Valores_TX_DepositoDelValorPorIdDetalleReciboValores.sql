



CREATE Procedure [dbo].[Valores_TX_DepositoDelValorPorIdDetalleReciboValores]

@IdDetalleReciboValores int

AS 

Declare @IdValor int
Set @IdValor=IsNull((Select Top 1 Valores.IdValor 
			From Valores
			Where IdDetalleReciboValores=@IdDetalleReciboValores),0)

SELECT DetDep.*
FROM DetalleDepositosBancarios DetDep
LEFT OUTER JOIN DepositosBancarios ON DetDep.IdDepositoBancario=DepositosBancarios.IdDepositoBancario
WHERE DetDep.IdValor=@IdValor and 
	IsNull(DepositosBancarios.Anulado,'NO')<>'SI'



