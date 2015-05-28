
CREATE Procedure [dbo].[Recepciones_TX_PorListaId]

@IdRecepciones varchar(1000)

AS 

SELECT DISTINCT Pedidos.IdProveedor, Proveedores.RazonSocial as [Proveedor]
FROM DetalleRecepciones dr 
LEFT OUTER JOIN DetallePedidos dp ON dp.IdDetallePedido=dr.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=dp.IdPedido
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Pedidos.IdProveedor
WHERE Patindex('%('+Convert(varchar,dr.IdRecepcion)+')%', @IdRecepciones)<>0 and 
	Pedidos.IdProveedor is not null and IsNull(Pedidos.Cumplido,'')<>'AN' and 
	not Exists(Select Top 1 dcp.IdDetalleRecepcion From DetalleComprobantesProveedores dcp Where dcp.IdDetalleRecepcion = dr.IdDetalleRecepcion)
