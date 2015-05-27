CREATE PROCEDURE [dbo].[SalidasMateriales_TX_DatosPorIdDetalle]

@IdSalidaMateriales int = Null,
@IdDetalleSalidaMateriales int = Null

AS 

SET @IdSalidaMateriales=IsNull(@IdSalidaMateriales,0)
SET @IdDetalleSalidaMateriales=IsNull(@IdDetalleSalidaMateriales,0)

SELECT
 DetSal.*,
 SalidasMateriales.IdTransportista1,
 SalidasMateriales.IdProveedor,
 SalidasMateriales.NumeroSalidaMateriales2,
 SalidasMateriales.NumeroSalidaMateriales,
 SalidasMateriales.FechaSalidaMateriales,
 SalidasMateriales.IdDepositoOrigen,
 SalidasMateriales.IdObra as [IdObraDestino],
 ValesSalida.NumeroValeSalida as [Vale],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [NumeroSalida],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Articulos.IdUbicacionStandar,
 Unidades.Abreviatura as [Unidad],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 O1.NumeroObra as [Obra],
 O2.NumeroObra as [ObraDestino],
 DetalleValesSalida.IdDetalleRequerimiento,
 DetalleRequerimientos.NumeroItem,
 Requerimientos.NumeroRequerimiento,
 Requerimientos.FechaRequerimiento,
 Colores.Codigo2 as [CodigoColor],
 Colores.Descripcion as [Color]
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN ValesSalida ON DetalleValesSalida.IdValeSalida = ValesSalida.IdValeSalida
LEFT OUTER JOIN Ubicaciones ON DetSal.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras O1 ON DetSal.IdObra = O1.IdObra
LEFT OUTER JOIN Obras O2 ON SalidasMateriales.IdObra = O2.IdObra
LEFT OUTER JOIN DetalleRequerimientos ON DetalleValesSalida.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Colores ON Colores.IdColor = DetSal.IdColor
WHERE (@IdSalidaMateriales=0 or DetSal.IdSalidaMateriales = @IdSalidaMateriales) and 
	(@IdDetalleSalidaMateriales=0 or DetSal.IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)