CREATE Procedure [dbo].[SalidasMateriales_TX_PorIdDetalle]

@IdDetalleSalidaMateriales int

AS 

SELECT 
 SalidasMateriales.*, 
 DetSal.IdArticulo, 
 DetSal.IdFlete as [IdFlete1],
 DetSal.Cantidad*DetSal.CostoUnitario*IsNull(DetSal.CotizacionMoneda,1) as [Costo]
FROM DetalleSalidasMateriales DetSal 
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
WHERE DetSal.IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales