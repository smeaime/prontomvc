CREATE Procedure [dbo].[DetSalidasMaterialesPresupuestosObras_M]

@IdDetalleSalidaMaterialesPresupuestosObras int,
@IdDetalleSalidaMateriales int,
@IdPresupuestoObrasNodo int,
@Cantidad numeric(18,2),
@IdDetalleSalidaMaterialesKit int,
@IdPresupuestoObrasNodoNoMateriales int = Null

AS

UPDATE [DetalleSalidasMaterialesPresupuestosObras]
SET 
 IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales,
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo,
 Cantidad=@Cantidad,
 IdDetalleSalidaMaterialesKit=@IdDetalleSalidaMaterialesKit,
 IdPresupuestoObrasNodoNoMateriales=@IdPresupuestoObrasNodoNoMateriales
WHERE (IdDetalleSalidaMaterialesPresupuestosObras=@IdDetalleSalidaMaterialesPresupuestosObras)

RETURN(@IdDetalleSalidaMaterialesPresupuestosObras)