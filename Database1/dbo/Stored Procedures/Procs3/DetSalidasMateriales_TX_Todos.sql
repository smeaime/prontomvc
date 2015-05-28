CREATE Procedure [dbo].[DetSalidasMateriales_TX_Todos]

@IdSalidaMateriales int

AS 

SET NOCOUNT ON

DECLARE @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

CREATE TABLE #Auxiliar0 
			(
			 IdDetalleSalidaMateriales INTEGER,
			 CodigoEquipoDestino VARCHAR(20),
			 DescripcionEquipoDestino VARCHAR(256)
			)

SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento From Parametros P Where P.IdParametro=1),'')
SET @sql1='Select name From master.dbo.sysdatabases WHERE name = N'+''''+@BasePRONTOMANT+''''
CREATE TABLE #Auxiliar1 (Descripcion VARCHAR(256))
INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

IF (SELECT COUNT(*) FROM #Auxiliar1)>0
    BEGIN
	SET @sql1='SELECT DetSal.IdDetalleSalidaMateriales, Art.Codigo, Art.Descripcion 
			FROM DetalleSalidasMateriales DetSal 
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Articulos Art ON Art.IdArticulo = DetSal.IdEquipoDestino
			WHERE DetSal.IdSalidaMateriales='+Convert(varchar,@IdSalidaMateriales)
	INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
    END
ELSE
    BEGIN
	INSERT INTO #Auxiliar0
	SELECT DetSal.IdDetalleSalidaMateriales, Art.Codigo, Art.Descripcion 
	FROM DetalleSalidasMateriales DetSal 
	LEFT OUTER JOIN Articulos Art ON Art.IdArticulo = DetSal.IdEquipoDestino
	WHERE DetSal.IdSalidaMateriales=@IdSalidaMateriales
    END

SET NOCOUNT OFF

SELECT 
 DetSal.*,
 Articulos.Codigo as [Codigo],
 Rtrim(Articulos.Descripcion)+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad],
 Obras.NumeroObra as [Obra],
 Requerimientos.NumeroRequerimiento as [RM],
 Requerimientos.TipoRequerimiento,
 Requerimientos.IdOrdenTrabajo as [IdOrdenTrabajoRM],
 IsNull(DetSal.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo) as [IdOrdenTrabajo1],
 DetReq.NumeroItem as [ItemRM],
 DetReq.CodigoDistribucion as [CodigoDistribucion],
 IsNull(#Auxiliar0.CodigoEquipoDestino,'') as [EquipoDestino],
 IsNull(#Auxiliar0.DescripcionEquipoDestino,'') as [EquipoDestinoDescripcion],
 (Select Top 1 Prov.RazonSocial
	From DetallePedidos DetPed
	Left Outer Join Pedidos On DetPed.IdPedido = Pedidos.IdPedido
	Left Outer Join Proveedores Prov On Pedidos.IdProveedor = Prov.IdProveedor
	Where DetPed.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento) as [Proveedor],
 (Select Top 1 Case When Pedidos.SubNumero is not null Then convert(varchar,Pedidos.NumeroPedido)+' / '+convert(varchar,Pedidos.SubNumero) Else convert(varchar,Pedidos.NumeroPedido) End
	From DetallePedidos DetPed
	Left Outer Join Pedidos On DetPed.IdPedido = Pedidos.IdPedido
	Where DetPed.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento) as [Pedido],
 IsNull(Monedas.Abreviatura,'') as [Moneda]
FROM DetalleSalidasMateriales DetSal 
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Monedas ON DetSal.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Obras ON DetSal.IdObra = Obras.IdObra
LEFT OUTER JOIN DetalleValesSalida ON DetalleValesSalida.IdDetalleValeSalida=DetSal.IdDetalleValeSalida
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdDetalleSalidaMateriales = DetSal.IdDetalleSalidaMateriales
LEFT OUTER JOIN UnidadesEmpaque ON DetSal.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
WHERE IdSalidaMateriales=@IdSalidaMateriales

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1