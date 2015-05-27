CREATE PROCEDURE [dbo].[Pedidos_TX_DetPendientesTodosVencidos]

@IdLugarEntrega int = Null,
@MostrarCostos varchar(2) = Null

AS

SET NOCOUNT ON

SET @IdLugarEntrega=IsNull(@IdLugarEntrega,0)
SET @MostrarCostos=IsNull(@MostrarCostos,'')

CREATE TABLE #Auxiliar1 
			(
			 IdDetallePedido INTEGER,
			 Entregado NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT DetPed.IdDetallePedido,
	(Select Sum(IsNull(DetRec.Cantidad,0)) From DetalleRecepciones DetRec
	 Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
	 Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI'))
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 WHERE ((DetPed.Cumplido<>'SI' and DetPed.Cumplido<>'AN') or DetPed.Cumplido is null) and 
	(Pedidos.Cumplido is null or Pedidos.Cumplido='NO') and DetPed.FechaEntrega<getdate()

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50), @TomarPedidosSinLiberar varchar(2)
SET @vector_X='011101111111111111111111111118811111133'
IF @MostrarCostos='NO'
	SET @vector_T='0404009991142D211111119211519991E261400'
ELSE
	SET @vector_T='0404009991142D211111119211519331E261400'

SET @TomarPedidosSinLiberar=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Permitir emision de pedido sin liberar'),'')

SELECT
 DetPed.IdDetallePedido,
 Case When Pedidos.SubNumero is not null Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4) Else str(Pedidos.NumeroPedido,8) End as [Pedido],
 DetPed.NumeroItem as [Item],
 Pedidos.FechaPedido as [Fecha],
 Pedidos.IdProveedor,
 Proveedores.RazonSocial as [Proveedor],
 Proveedores.Telefono1,
 Proveedores.Email,
 Proveedores.Contacto,
 E1.Nombre as [Comprador],
 E2.Nombre as [Solicito RM],
 DetPed.FechaEntrega as [F.entrega],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Articulo],
 DetalleRequerimientos.Observaciones as [Observacion item RM],
 DetPed.Cantidad as [Cant.],
 (Select substring(Unidades.Descripcion,1,20) From Unidades Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
 #Auxiliar1.Entregado as [Entregado],
 DetPed.Cantidad - IsNull(#Auxiliar1.Entregado,0) as [Pendiente],
 DetPed.NumeroItem as [It.Ped],
 Requerimientos.NumeroRequerimiento as [Nro.RM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 DetPed.IdPedido,
 DetPed.Cumplido as [Cump.],
 Acopios.NumeroAcopio as [Nro.LA],
 DetalleAcopios.NumeroItem as [It.LA],
 Case When Acopios.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
	When Requerimientos.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
	Else Null
 End as [Obra],
 Equipos.Tag as [Equipo],
 DetPed.IdDetallePedido as [IdAux],
 DetPed.Precio,
 ((DetPed.Cantidad-IsNull(#Auxiliar1.Entregado,0))*DetPed.Precio) as [Subtotal],
 Monedas.Abreviatura as [Mon.],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion From AutorizacionesPorComprobante Aut 
  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento) as [Fecha 2da.Firma],
 IsNull(Requerimientos.TipoRequerimiento,'')+
	Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP' Then IsNull(' - '+A2.NumeroInventario,'')
		When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST' Then Convert(varchar,IsNull(' - '+ot.NumeroOrdenTrabajo,''))
		Else ''
	End as [OT/OP],
 cc.Descripcion as [Condicion compra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetPed.IdArticulo
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetalleRequerimientos.IdEquipoDestino
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Pedidos.IdComprador
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
LEFT OUTER JOIN DetalleLMateriales ON DetalleRequerimientos.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdDetallePedido = DetPed.IdDetallePedido
LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra = Pedidos.IdCondicionCompra
LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
WHERE IsNull(DetPed.Cumplido,'')<>'SI' and IsNull(DetPed.Cumplido,'')<>'AN' and IsNull(Pedidos.Cumplido,'')<>'SI' and 
	DetPed.FechaEntrega<getdate() and 
	(@TomarPedidosSinLiberar='SI' or Pedidos.Aprobo is not null) and 
	(@IdLugarEntrega<=0 or Pedidos.IdLugarEntrega=@IdLugarEntrega)
ORDER BY Proveedores.RazonSocial,Pedidos.NumeroPedido

DROP TABLE #Auxiliar1