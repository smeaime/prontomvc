CREATE PROCEDURE [dbo].[Pedidos_TX_PorEquipoDestino]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdDetallePedido INTEGER, IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetallePedido,IdArticulo) ON [PRIMARY]

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
  BEGIN
	SET @sql1='Select Distinct dp.IdDetallePedido, a.IdArticulo, a.Descripcion, a.NumeroInventario 
			From DetallePedidos dp
			Left Outer Join Pedidos On Pedidos.IdPedido = dp.IdPedido
			Left Outer Join DetalleRequerimientos dr On dp.IdDetalleRequerimiento = dr.IdDetalleRequerimiento
			Left Outer Join Requerimientos On dr.IdRequerimiento = Requerimientos.IdRequerimiento
			Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos a On Requerimientos.IdEquipoDestino = a.IdArticulo
			Where Pedidos.FechaPedido Between Convert(datetime,'+''''+Convert(varchar,@Desde)+''''+',103) and Convert(datetime,'+''''+Convert(varchar,@Hasta)+''''+',103) and a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT DISTINCT dp.IdDetallePedido, a.IdArticulo, a.Descripcion, a.NumeroInventario
	 FROM DetallePedidos dp
	 LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = dp.IdPedido
	 LEFT OUTER JOIN DetalleRequerimientos dr ON dp.IdDetalleRequerimiento = dr.IdDetalleRequerimiento
	 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN Articulos a ON Requerimientos.IdEquipoDestino = a.IdArticulo
	 WHERE Pedidos.FechaPedido Between @Desde and @Hasta and a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
  END

SET NOCOUNT OFF

DECLARE @vector_X varchar(70),@vector_T varchar(70)
SET @vector_X='011111111111111100'
SET @vector_T='01E4D2E30202333200'

SELECT
 DetPed.IdDetallePedido,
 #Auxiliar1.NumeroInventario as [Cod.Eq.Destino],
 #Auxiliar1.Descripcion as [Equipo destino],
 Pedidos.FechaPedido as [Fecha pedido],
 Case When IsNull(Pedidos.PuntoVenta,0)<>0 
	Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
 End as [Pedido],
 Articulos.Codigo as [Cod.Articulo],
 Articulos.Descripcion as [Articulo],
 Proveedores.RazonSocial as [Proveedor],
 DetPed.NumeroItem as [Item],
 DetPed.Cantidad as [Cant.],
 Unidades.Abreviatura as [En],
 DetPed.Precio as [Precio],
 (DetPed.Cantidad*DetPed.Precio) as [Subtotal],
 DetPed.ImporteIVA as [IVA],
 DetPed.ImporteTotalItem as [Importe],
 Monedas.Abreviatura as [Mon.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdDetallePedido=DetPed.IdDetallePedido
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=DetPed.IdUnidad
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Pedidos.IdMoneda
WHERE IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(DetPed.Cumplido,'NO')<>'AN' and Pedidos.FechaPedido Between @Desde and @Hasta and #Auxiliar1.IdDetallePedido is not null
ORDER by #Auxiliar1.NumeroInventario, #Auxiliar1.Descripcion, Pedidos.FechaPedido, Pedidos.PuntoVenta, Pedidos.NumeroPedido

DROP TABLE #Auxiliar1