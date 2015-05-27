CREATE Procedure [dbo].[Pedidos_TX_DetallesPorIdPedido]

@IdPedido int

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
			Where Pedidos.IdPedido='+Convert(varchar,@IdPedido)+' and a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
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
	 WHERE Pedidos.IdPedido=@IdPedido and a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
    END

SET NOCOUNT OFF

SELECT 
 DetPed.FechaEntrega,
 DetPed.NumeroItem,
 DetPed.OrigenDescripcion,
 DetPed.IdArticulo,
 DetPed.Cantidad,
 DetPed.IdUnidad,
 DetPed.Precio,
 IsNull(Monedas.Abreviatura,Monedas.Nombre) as [Moneda],
 DetPed.Cantidad1,
 DetPed.Cantidad2,
 DetPed.PorcentajeIVA,
 DetPed.PorcentajeBonificacion,
 DetPed.ImporteBonificacion,
 DetPed.ImporteIva,
 DetPed.ImporteTotalItem,
 DetPed.FechaEntrega,
 DetPed.FechaNecesidad,
 DetPed.IdControlCalidad,
 DetPed.Cumplido,
 Case 	When Acopios.IdObra is NOT NULL Then  Acopios.IdObra
	When Requerimientos.IdObra is NOT NULL Then Requerimientos.IdObra
	Else null
 End as [IdObra],
 Case	When Acopios.IdObra is NOT NULL Then (Select Obras.Descripcion From Obras Where Acopios.IdObra=Obras.IdObra)
	When Requerimientos.IdObra is NOT NULL Then (Select Obras.Descripcion From Obras Where Requerimientos.IdObra=Obras.IdObra)
	Else null
 End as [Obra],
 Case	When Acopios.IdObra is NOT NULL Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
	When Requerimientos.IdObra is NOT NULL Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
	Else null
 End as [NumeroObra],
 Acopios.NumeroAcopio,
 DetalleAcopios.NumeroItem as [NumeroItemLA],
 Requerimientos.NumeroRequerimiento,
 Case When IsNull(Pedidos.IncluirObservacionesRM,'NO')='SI' Then Requerimientos.Observaciones Else Null End as [ObservacionesRM],
 Requerimientos.DetalleImputacion as [DetalleRM],
 DetalleRequerimientos.NumeroItem as [NumeroItemRM],
 DetPed.Observaciones,
 DetPed.Adjunto,
 Articulos.NumeroInventario as [CodigoEquipoDestino],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+Articulos.Descripcion as [EquipoDestino],
 IsNull(ControlesCalidad.Detalle,'') as [CC_Detalle],
 IsNull(ControlesCalidad.Inspeccion,'') as [CC_Inspecciona],
 Obras.NumeroObra as [Obra],
 #Auxiliar1.NumeroInventario as [Cod.Eq.Destino],
 #Auxiliar1.Descripcion as [Equipo destino],
 IsNull(#Auxiliar1.NumeroInventario+' ','')+#Auxiliar1.Descripcion as [EquipoDestino],
 TiposCompra.Modalidad as [ModalidadRM]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos On DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Monedas On Pedidos.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN DetalleAcopios On DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios On DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos On DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos On DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN ControlesCalidad ON DetalleRequerimientos.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN Articulos On Requerimientos.IdEquipoDestino=Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdDetallePedido=DetPed.IdDetallePedido
LEFT OUTER JOIN TiposCompra On TiposCompra.IdTipoCompra=Requerimientos.IdTipoCompra
WHERE DetPed.IdPedido=@IdPedido
ORDER BY DetPed.NumeroItem

DROP TABLE #Auxiliar1