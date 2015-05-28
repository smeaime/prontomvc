


CREATE Procedure [dbo].[Requerimientos_TX_EntregasConcretadas]

@IdRequerimiento int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='005553300'

SELECT
 DetReq.IdDetalleRequerimiento,
 DetReq.NumeroItem as [Item],
 Case
	When Recepciones.NumeroRecepcion1 is not null Then str(Recepciones.NumeroRecepcion1,4)+'-'+str(Recepciones.NumeroRecepcion2,8)
	Else Null
 End as [Numero remito],
 Recepciones.FechaRecepcion as [Fecha remito],
 Proveedores.RazonSocial as [Proveedor],
 Pedidos.NumeroPedido as [Pedido],
 DetalleRecepciones.Cantidad as [Cantidad],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos On Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
LEFT OUTER JOIN DetallePedidos On DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleRecepciones On DetalleRecepciones.IdDetallePedido=DetallePedidos.IdDetallePedido
LEFT OUTER JOIN Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
WHERE DetReq.IdRequerimiento=@IdRequerimiento and DetalleRecepciones.Cantidad is not null and 
	 (Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO')
ORDER BY DetReq.NumeroItem


