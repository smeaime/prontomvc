
CREATE Procedure [dbo].[DetRecibosValores_TX_ValidarCheque]

@IdDetalleReciboValores int,
@IdBanco int,
@NumeroValor numeric(12,0)

AS 

SELECT Recibos.NumeroRecibo, Recibos.FechaRecibo
FROM DetalleRecibosValores
LEFT OUTER JOIN Recibos ON DetalleRecibosValores.IdRecibo=Recibos.IdRecibo
WHERE DetalleRecibosValores.IdDetalleReciboValores<>@IdDetalleReciboValores and 
	DetalleRecibosValores.IdBanco=@IdBanco and 
	DetalleRecibosValores.NumeroValor=@NumeroValor and 
	IsNull(Recibos.Anulado,'NO')<>'SI'
