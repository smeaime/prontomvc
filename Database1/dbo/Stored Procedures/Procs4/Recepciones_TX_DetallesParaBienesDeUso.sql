
CREATE PROCEDURE [dbo].[Recepciones_TX_DetallesParaBienesDeUso]

@Desde datetime,
@Hasta datetime

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111111133'
Set @vector_T='0E99214G411G22200'

SELECT
 DetRec.IdDetalleRecepcion,
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
	Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
	Convert(varchar,Recepciones.NumeroRecepcion2) as [Remito],
 DetRec.IdDetalleRecepcion as [IdAux1],
 DetRec.IdArticulo as [IdAux2],
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Proveedores.RazonSocial as [Proveedor],
 Recepciones.FechaRecepcion as [Fecha rec.],
 Case 	When Pedidos.SubNumero is not null 
	 Then Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)+' / '+str(Pedidos.SubNumero,2)
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)
 End as [Pedido],
 Pedidos.FechaPedido [Fecha ped.],
 DetPed.NumeroItem as [Item ped.],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetRec.Cantidad,
 DetPed.Precio,
 Case When (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0))<>0 
		and IsNull(Pedidos.Bonificacion,0)<>0 
	Then ((DetRec.Cantidad*DetPed.Precio)-
		(DetRec.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100)) - 
		(Pedidos.Bonificacion / (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)) * 
		 ((DetRec.Cantidad*DetPed.Precio)-
		  (DetRec.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100)))
	Else (DetRec.Cantidad*DetPed.Precio)-
		(DetRec.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100) 
 End as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
WHERE Recepciones.FechaRecepcion between @Desde and @hasta
ORDER by Pedidos.NumeroPedido,DetPed.NumeroItem
