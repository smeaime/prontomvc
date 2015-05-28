CREATE Procedure [dbo].[DetSalidasMateriales_TX_ConDatosResumido]

@IdSalidaMateriales int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER,
			 IdUnidad INTEGER,
			 IdObra INTEGER,
			 Partida VARCHAR(20),
			 Cantidad NUMERIC(18,2),
			 Bultos INTEGER,
			 PesoTara NUMERIC(18,2),
			 PesoBruto NUMERIC(18,2),
			 NumeroCaja INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT dsm.IdArticulo, dsm.IdUnidad, dsm.IdObra, dsm.Partida, Sum(IsNull(dsm.Cantidad,0)), count (*), 
	Sum(IsNull(UnidadesEmpaque.Tara,0)), Sum(IsNull(UnidadesEmpaque.PesoBruto,0)), Max(Isnull(dsm.NumeroCaja,''))
 FROM DetalleSalidasMateriales dsm  
 LEFT OUTER JOIN UnidadesEmpaque ON dsm.NumeroCaja = UnidadesEmpaque.NumeroUnidad
 WHERE dsm.IdSalidaMateriales = @IdSalidaMateriales
 GROUP BY dsm.IdArticulo, dsm.IdUnidad, dsm.IdObra, dsm.Partida

SET NOCOUNT OFF

SELECT
 #Auxiliar1.*,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Rtrim(IsNull(Articulos.Caracteristicas,Articulos.Descripcion))+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Caracteristicas],
 Unidades.Abreviatura as [Unidad]
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar1.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor

DROP TABLE #Auxiliar1