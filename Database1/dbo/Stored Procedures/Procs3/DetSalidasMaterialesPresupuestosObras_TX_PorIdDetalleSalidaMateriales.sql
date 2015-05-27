
CREATE Procedure [dbo].[DetSalidasMaterialesPresupuestosObras_TX_PorIdDetalleSalidaMateriales]

@IdDetalleSalidaMateriales int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111133'
SET @vector_T='0399H00'

SELECT 
 Det.IdDetalleSalidaMaterialesPresupuestosObras as [IdAux],
 Det.Cantidad as [Cantidad], 
 Det.IdDetalleSalidaMaterialesPresupuestosObras as [IdAux1],
 Det.IdPresupuestoObrasNodo as [IdAux2],
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMaterialesPresupuestosObras Det 
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = Det.IdPresupuestoObrasNodo
WHERE Det.IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales
