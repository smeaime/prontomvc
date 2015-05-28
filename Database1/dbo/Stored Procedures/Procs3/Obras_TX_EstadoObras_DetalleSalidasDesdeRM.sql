
CREATE PROCEDURE [dbo].[Obras_TX_EstadoObras_DetalleSalidasDesdeRM]

@IdDetalleRequerimiento as int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (IdDetalleValeSalida INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleValeSalida) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT IdDetalleValeSalida
 FROM DetalleValesSalida
 WHERE IsNull(IdDetalleRequerimiento,0)>0 and (@IdDetalleRequerimiento=-1 or IdDetalleRequerimiento=@IdDetalleRequerimiento)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111133'
SET @vector_T='034103300'

SELECT
 DetSal.IdDetalleSalidaMateriales,
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [Nro. de salida],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 DetSal.Cantidad as [Cant.],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Un.],
 DetSal.CostoUnitario as [Costo Un.],
 DetSal.Cantidad*DetSal.CostoUnitario as [Costo Total],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN #Auxiliar1 ON DetSal.IdDetalleValeSalida = #Auxiliar1.IdDetalleValeSalida
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and #Auxiliar1.IdDetalleValeSalida is not null
ORDER BY SalidasMateriales.FechaSalidaMateriales, SalidasMateriales.NumeroSalidaMateriales

DROP TABLE #Auxiliar1
