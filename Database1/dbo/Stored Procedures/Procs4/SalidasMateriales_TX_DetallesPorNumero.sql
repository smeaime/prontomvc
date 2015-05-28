
CREATE Procedure [dbo].[SalidasMateriales_TX_DetallesPorNumero]

@NumeroSalidaMateriales2 int,
@NumeroSalidaMateriales int

AS 

SELECT 
 DetSal.IdDetalleSalidaMateriales,
 Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' - '+Articulos.Descripcion as [Titulo]
FROM DetalleSalidasMateriales DetSal 
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
WHERE NumeroSalidaMateriales2=@NumeroSalidaMateriales2 and 
	NumeroSalidaMateriales=@NumeroSalidaMateriales
