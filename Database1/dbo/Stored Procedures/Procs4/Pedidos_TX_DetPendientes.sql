CREATE PROCEDURE [dbo].[Pedidos_TX_DetPendientes]

@IdPedido int = Null,
@NumeroPedido int = Null,
@IdLugarEntrega int = Null

AS

SET @IdPedido=IsNull(@IdPedido,-1)
SET @NumeroPedido=IsNull(@NumeroPedido,-1)
SET @IdLugarEntrega=IsNull(@IdLugarEntrega,0)

DECLARE @vector_X varchar(50), @vector_T varchar(50), @TomarPedidosSinLiberar varchar(2)
SET @vector_X='0111011111111111111111111111133'
SET @vector_T='0314009991420111111111921151900'

SET @TomarPedidosSinLiberar=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Permitir emision de pedido sin liberar'),'')

SELECT
 DetPed.IdDetallePedido,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 DetPed.NumeroItem as [Item],
 Pedidos.FechaPedido as [Fecha],
 Pedidos.IdProveedor,
 Proveedores.RazonSocial as [Proveedor],
 Proveedores.Telefono1,
 Proveedores.Email,
 Proveedores.Contacto,
 Empleados.Nombre as [Comprador],
 DetPed.FechaEntrega as [F.entrega],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPed.Cantidad as [Cant.],
 ( Select substring(Unidades.Descripcion,1,20)
	From Unidades
	Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
 (Select Sum(DetRec.Cantidad)
  From DetalleRecepciones DetRec
  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
  Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and 
	(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [Entregado],
 DetPed.Cantidad - Isnull((Select Sum(DetRec.Cantidad)
 				From DetalleRecepciones DetRec 
				Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
				Where DetRec.IdDetallePedido=DetPed.IdDetallePedido and 
					(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0)
 as [Pendiente],
 DetPed.Cantidad1 as [Med.1],
 DetPed.Cantidad2 as [Med.2],
 DetPed.NumeroItem as [It.Ped],
 Requerimientos.NumeroRequerimiento as [Nro.RM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 DetPed.IdPedido,
 DetPed.Cumplido as [Cump.],
 Acopios.NumeroAcopio as [Nro.LA],
 DetalleAcopios.NumeroItem as [It.LA],
 CASE
	WHEN Acopios.IdObra is not null THEN (Select Top 1 Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
	WHEN Requerimientos.IdObra is not null THEN (Select Top 1 Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
	ELSE Null
 END as [Obra],
 Equipos.Tag as [Equipo],
 DetPed.IdDetallePedido as [IdAux],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Empleados ON Pedidos.IdComprador = Empleados.IdEmpleado
LEFT OUTER JOIN DetalleLMateriales ON DetalleRequerimientos.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
WHERE IsNull(DetPed.Cumplido,'')<>'SI' and IsNull(DetPed.Cumplido,'')<>'AN' and IsNull(Pedidos.Cumplido,'')<>'SI' and 
	(@IdPedido=-1 or DetPed.IdPedido=@IdPedido) and 
	(@NumeroPedido=-1 or Pedidos.NumeroPedido=@NumeroPedido) and 
	(@TomarPedidosSinLiberar='SI' or Pedidos.Aprobo is not null) and 	(@IdLugarEntrega<=0 or Pedidos.IdLugarEntrega=@IdLugarEntrega)
ORDER By Pedidos.NumeroPedido,Pedidos.SubNumero,DetPed.NumeroItem