



CREATE PROCEDURE [dbo].[OrdenesPago_TX_ValoresEnConciliacionesPorIdOrdenPago]

@IdOrdenPago int

AS

SELECT Conciliaciones.Numero
FROM DetalleConciliaciones dc
LEFT OUTER JOIN Conciliaciones ON dc.IdConciliacion=Conciliaciones.IdConciliacion
WHERE dc.IdValor IN 
	(Select Valores.IdValor
	 From DetalleOrdenesPagoValores dopv
	 Inner Join Valores On Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
	 Where dopv.IdOrdenPago=@IdOrdenPago)



