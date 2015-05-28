
CREATE PROCEDURE [dbo].[Recepciones_TX_EntreFechas]

@Desde datetime,
@Hasta datetime,
@IdObra int

AS

SELECT
 FechaRecepcion as [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When Recepciones.SubNumero is not null 
	Then str(NumeroRecepcion1,4)+'-'+str(NumeroRecepcion2,8)+'/'+Recepciones.SubNumero 
 	Else str(NumeroRecepcion1,4)+'-'+str(NumeroRecepcion2,8) 
 End as [Comprobante],
 Obras.NumeroObra as [Obra],
 CentrosCosto.Descripcion as [Centro de costo],
 Pedidos.NumeroPedido as [Pedido],
 Requerimientos.NumeroRequerimiento as [RM],
 Acopios.NumeroAcopio as [Numero LA],
 Acopios.Nombre as [Nombre LA],
 NumeroRecepcionAlmacen as [Nro.Recepcion Interno]
FROM Recepciones
LEFT OUTER JOIN Pedidos ON Recepciones.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Requerimientos ON Recepciones.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Acopios ON Recepciones.IdAcopio=Acopios.IdAcopio
WHERE Recepciones.FechaRecepcion Between @Desde and @Hasta and 
	 (@IdObra=-1 or Requerimientos.IdObra=@IdObra)
ORDER By FechaRecepcion,Proveedores.RazonSocial
