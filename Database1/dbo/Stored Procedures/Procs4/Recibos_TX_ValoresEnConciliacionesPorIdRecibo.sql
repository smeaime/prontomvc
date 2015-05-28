



CREATE PROCEDURE [dbo].[Recibos_TX_ValoresEnConciliacionesPorIdRecibo]

@IdRecibo int

AS

SELECT Conciliaciones.Numero
FROM DetalleConciliaciones dc
LEFT OUTER JOIN Conciliaciones ON dc.IdConciliacion=Conciliaciones.IdConciliacion
WHERE dc.IdValor IN 
	(Select Valores.IdValor
	 From DetalleRecibosValores drv
	 Inner Join Valores On Valores.IdDetalleReciboValores=drv.IdDetalleReciboValores
	 Where drv.IdRecibo=@IdRecibo)




