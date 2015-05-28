CREATE Procedure [dbo].[CuboPedidos]

@FechaDesde datetime,
@FechaHasta datetime,
@Dts varchar(200)

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetallePedido INTEGER,
			 Fecha DATETIME,
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetPed.IdDetallePedido,
  --DateAdd(day,IsNull(Tmp.Dias,0),Pedidos.FechaPedido),
  --DetPed.ImporteTotalItem * IsNull(Tmp.Porcentaje,100)/100 * IsNull(Pedidos.CotizacionMoneda,1)
  DetPed.FechaEntrega,
  DetPed.ImporteTotalItem * IsNull(Pedidos.CotizacionMoneda,1)
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido=Pedidos.IdPedido
-- LEFT OUTER JOIN _TempCondicionesCompra Tmp ON Pedidos.IdCondicionCompra=Tmp.IdCondicionCompra
 WHERE (Pedidos.FechaPedido Between @FechaDesde And @FechaHasta) and 
	Pedidos.Aprobo is not null

TRUNCATE TABLE _TempCuboPedidos
INSERT INTO _TempCuboPedidos 
SELECT 
 Proveedores.RazonSocial,
 Obras.NumeroObra+' '+Obras.Descripcion,
 #Auxiliar1.Fecha,
 'Pedido: '+Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)+'-'+
		Substring('00',1,2-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+
		Convert(varchar,IsNull(Pedidos.SubNumero,0))+' del '+
	Convert(varchar,Pedidos.FechaPedido,103)+' '+
	'Cond. '+IsNull(Cond.Descripcion,'S/S'),
 Articulos.Descripcion+'  -  [ Cantidad : '+Convert(varchar,DetPed.Cantidad)+' ]',
 #Auxiliar1.Importe
FROM #Auxiliar1
LEFT OUTER JOIN DetallePedidos DetPed ON #Auxiliar1.IdDetallePedido=DetPed.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN [Condiciones Compra] Cond ON Pedidos.IdCondicionCompra = Cond.IdCondicionCompra

DROP TABLE #Auxiliar1

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF