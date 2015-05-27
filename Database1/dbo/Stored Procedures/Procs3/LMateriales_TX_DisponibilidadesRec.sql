





























CREATE  Procedure [dbo].[LMateriales_TX_DisponibilidadesRec]
@IdDetalleLMateriales int
AS 
SELECT 
	SUM(DetRec.Cantidad) as [Cant.recibida],
	Recepciones.FechaRecepcion as [Fec.recepcion]
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN recepciones ON DetRec.IdRecepcion=recepciones.IdRecepcion
LEFT OUTER JOIN DetallePedidos ON DetRec.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN DetalleRequerimientos ON DetRec.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
WHERE DetallePedidos.IdDetalleLMateriales=@IdDetalleLMateriales OR DetalleRequerimientos.IdDetalleLMateriales=@IdDetalleLMateriales
GROUP BY DetallePedidos.IdDetalleLMateriales,DetalleRequerimientos.IdDetalleLMateriales,Recepciones.FechaRecepcion






























