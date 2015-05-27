
CREATE PROCEDURE [dbo].[Requerimientos_TX_DatosPorNumeroItem]

@NumeroRequerimiento int = Null,
@NumeroItem int = Null

AS

SET NOCOUNT ON

SET @NumeroRequerimiento=IsNull(@NumeroRequerimiento,-1)
SET @NumeroItem=IsNull(@NumeroItem,-1)

SET NOCOUNT OFF

SELECT Det.*, 
	IsNull((Select Top 1 dp.IdDetallePedido From DetallePedidos dp 
		Left Outer Join Pedidos On Pedidos.IdPedido=dp.IdPedido
		Where dp.IdDetalleRequerimiento=Det.IdDetalleRequerimiento Order By Pedidos.FechaPedido Desc),0) as [IdDetallePedido],
	IsNull((Select Top 1 dr.IdDetalleRecepcion From DetalleRecepciones dr 
		Left Outer Join Recepciones On Recepciones.IdRecepcion=dr.IdRecepcion
		Where dr.IdDetalleRequerimiento=Det.IdDetalleRequerimiento Order By Recepciones.FechaRecepcion Desc),0) as [IdDetalleRecepcion]
FROM DetalleRequerimientos Det
LEFT OUTER JOIN Requerimientos ON Det.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (@NumeroRequerimiento<=0 or (Requerimientos.NumeroRequerimiento=@NumeroRequerimiento and Det.NumeroItem=@NumeroItem))
