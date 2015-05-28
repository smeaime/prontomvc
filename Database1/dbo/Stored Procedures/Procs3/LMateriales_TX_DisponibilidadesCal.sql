





























CREATE  Procedure [dbo].[LMateriales_TX_DisponibilidadesCal]
@IdDetalleLMateriales int
AS 
SELECT 
	SUM(DetRec.Cantidad-(DetRec.CantidadCC+DetRec.CantidadRechazadaCC)) as [Stock en calidad]
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN DetallePedidos ON DetRec.IdDetallePedido = DetallePedidos.IdDetallePedido
WHERE DetallePedidos.IdDetalleLMateriales =@IdDetalleLMateriales and (DetRec.Controlado is null or DetRec.Controlado='PA')
GROUP BY DetallePedidos.IdDetalleLMateriales






























