CREATE PROCEDURE [dbo].[Recepciones_TX_AsignacionTarifasFletes]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111111133'
SET @vector_T='0492D01E2112H222E2222200'

SELECT
 dr.IdDetalleRecepcion,
 Recepciones.FechaRecepcion as [Fecha],
 dr.IdDetalleRecepcion as [IdAux1],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Material],
 Unidades.Abreviatura as [Un.],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When Recepciones.SubNumero is not null 
	 Then Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,Recepciones.SubNumero)
	 Else Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)
 End as [Recepcion],
 dr.CantidadEnOrigen as [Cant.S/Rto.],
 Transportistas.RazonSocial as [Transportista],
 Recepciones.Chofer as [Chofer],
 Recepciones.Patente as [Patente],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Recepciones.NumeroRemitoTransporte1,0))))+Convert(varchar,IsNull(Recepciones.NumeroRemitoTransporte1,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Recepciones.NumeroRemitoTransporte2,0))))+Convert(varchar,IsNull(Recepciones.NumeroRemitoTransporte2,0)) as [Remito transporte],
 Recepciones.PesoBruto as [Bruto],
 Recepciones.Tara as [Tara],
 dr.Cantidad as [Neto],
 Case 	When Pedidos.SubNumero is not null 
	Then Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+'/'+Convert(varchar,Pedidos.SubNumero)
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)
 End as [Pedido],
 Recepciones.CodigoTarifador as [Cod. tarifador],
 TarifasFletes.Descripcion as [Tarifa a aplicar],
 Recepciones.DistanciaRecorrida as [Distancia],
 Recepciones.TarifaFlete as [Valor Un.],
 dr.Cantidad*Recepciones.TarifaFlete as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones dr
LEFT OUTER JOIN Recepciones ON dr.IdRecepcion=Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos A1 ON dr.IdArticulo=A1.IdArticulo
LEFT OUTER JOIN Transportistas ON Recepciones.IdTransportista=Transportistas.IdTransportista
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleRequerimientos ON dr.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetallePedidos ON dr.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN ArchivosATransmitirDestinos atd ON atd.IdArchivoATransmitirDestino = dr.IdOrigenTransmision
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = dr.IdUnidad
LEFT OUTER JOIN TarifasFletes ON TarifasFletes.IdTarifaFlete = Recepciones.IdTarifaFlete
WHERE Controlado is not null and IsNull(Recepciones.Anulada,'NO')<>'SI' and 
	dr.IdOrigenTransmision is not null and IsNull(atd.Sistema,'')='BALANZA'
ORDER BY Recepciones.FechaRecepcion, Recepciones.NumeroRecepcion1, Recepciones.NumeroRecepcion2