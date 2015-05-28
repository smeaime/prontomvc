CREATE PROCEDURE [dbo].[wPedidos_TX_DetPendientesTodos]

AS

SET NOCOUNT ON

DECLARE @IdProveedorTransporte int, @CantReg int, @TomarPedidosSinLiberar varchar(2), @Formato int, @IdProveedor int, @IdTransportista int

SET @Formato=IsNull(@Formato,0)
SET @IdProveedor=IsNull(@IdProveedor,0)
SET @IdTransportista=IsNull(@IdTransportista,0)
SET @IdProveedorTransporte=IsNull((Select Top 1 IdProveedor From Transportistas Where IdTransportista=@IdTransportista),0)
SET @TomarPedidosSinLiberar=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Permitir emision de pedido sin liberar'),'')

CREATE TABLE #Auxiliar (IdProveedor INTEGER)
IF @IdProveedor>0
	INSERT INTO #Auxiliar 
	 SELECT IdProveedor FROM Proveedores WHERE IdProveedor=@IdProveedor
IF @IdProveedorTransporte>0
	INSERT INTO #Auxiliar 
	 SELECT IdProveedor FROM Proveedores WHERE IdProveedor=@IdProveedorTransporte

SET @CantReg=(Select Count(*) From #Auxiliar)

SET NOCOUNT OFF

SELECT
 Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 DetPed.NumeroItem as [Item],
 Pedidos.FechaPedido as [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 Proveedores.Telefono1 as [Telefono],
 Proveedores.Email as [Email],
 Proveedores.Contacto as [Contacto],
 Empleados.Nombre as [Comprador],
 DetPed.FechaEntrega as [F.entrega],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPed.Observaciones as [Observaciones],
 DetPed.Cantidad as [Cant.],
 Unidades.Abreviatura as  [Unidad],
 (Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec
  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
  Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [Entregado],
 DetPed.Cantidad - Isnull((Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec 
				Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
				Where DetRec.IdDetallePedido=DetPed.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0) as [Pendiente],
 Requerimientos.NumeroRequerimiento as [NumeroRequerimiento],
 DetalleRequerimientos.NumeroItem as [NumeroItemRM],
 Acopios.NumeroAcopio as [NumeroAcopio],
 DetalleAcopios.NumeroItem as [NumeroItemLA],
 Obras.NumeroObra as [Obra],
 TiposCompra.Descripcion as [TipoCompra],
 DetalleRequerimientos.Observaciones as [ObservacionItemRM]
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
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetPed.IdUnidad
LEFT OUTER JOIN Obras ON Obras.IdObra = IsNull(Requerimientos.IdObra,Acopios.IdObra)
WHERE IsNull(DetPed.Cumplido,'')<>'SI' and IsNull(DetPed.Cumplido,'')<>'AN' and IsNull(Pedidos.Cumplido,'')<>'SI' and 
	(@CantReg=0 or Exists(Select Top 1 IdProveedor From #Auxiliar Where #Auxiliar.IdProveedor=Pedidos.IdProveedor)) and 
	(@TomarPedidosSinLiberar='SI' or Pedidos.Aprobo is not null)
ORDER By Pedidos.NumeroPedido,Pedidos.SubNumero,DetPed.NumeroItem

DROP TABLE #Auxiliar