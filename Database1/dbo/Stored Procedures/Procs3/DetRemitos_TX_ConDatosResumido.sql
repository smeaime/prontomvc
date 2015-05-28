CREATE Procedure [dbo].[DetRemitos_TX_ConDatosResumido]

@IdRemito int

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
 SELECT DetalleRemitos.IdArticulo, DetalleRemitos.IdUnidad, DetalleRemitos.IdObra, DetalleRemitos.Partida, Sum(IsNull(DetalleRemitos.Cantidad,0)), count (*), 
	Sum(IsNull(UnidadesEmpaque.Tara,0)), Sum(IsNull(UnidadesEmpaque.PesoBruto,0)), Max(Isnull(DetalleRemitos.NumeroCaja,''))
 FROM DetalleRemitos 
 LEFT OUTER JOIN UnidadesEmpaque ON DetalleRemitos.NumeroCaja = UnidadesEmpaque.NumeroUnidad
 WHERE DetalleRemitos.IdRemito = @IdRemito
 GROUP BY DetalleRemitos.IdArticulo, DetalleRemitos.IdUnidad, DetalleRemitos.IdObra, DetalleRemitos.Partida

SET NOCOUNT OFF

SELECT
 #Auxiliar1.*,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Rtrim(IsNull(Articulos.Caracteristicas,Articulos.Descripcion))+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Caracteristicas],
 Unidades.Abreviatura as [Unidad],
 CalidadesClad.Abreviatura as [Calidad]
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad
LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar1.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor

DROP TABLE #Auxiliar1