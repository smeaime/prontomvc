CREATE Procedure [dbo].[DetSalidasMaterialesPresupuestosObras_A]

@IdDetalleSalidaMaterialesPresupuestosObras int  output,
@IdDetalleSalidaMateriales int,
@IdPresupuestoObrasNodo int,
@Cantidad numeric(18,2),
@IdDetalleSalidaMaterialesKit int,
@IdPresupuestoObrasNodoNoMateriales int = Null

AS 

INSERT INTO [DetalleSalidasMaterialesPresupuestosObras]
(
 IdDetalleSalidaMateriales,
 IdPresupuestoObrasNodo,
 Cantidad,
 IdDetalleSalidaMaterialesKit,
 IdPresupuestoObrasNodoNoMateriales
)
VALUES 
(
 @IdDetalleSalidaMateriales,
 @IdPresupuestoObrasNodo,
 @Cantidad,
 @IdDetalleSalidaMaterialesKit,
 @IdPresupuestoObrasNodoNoMateriales
 )

SELECT @IdDetalleSalidaMaterialesPresupuestosObras=@@identity
RETURN(@IdDetalleSalidaMaterialesPresupuestosObras)