CREATE Procedure [dbo].[PresupuestoObrasNodosDatos_A]

@IdPresupuestoObrasNodoDatos int output,
@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int,
@Importe numeric(18,8),
@Cantidad numeric(18,8),
@CantidadBase numeric(18,2),
@Rendimiento numeric(18,2),
@Incidencia numeric(18,8),
@Costo numeric(18,8),
@PrecioVentaUnitario numeric(18,2)

AS 

INSERT INTO [PresupuestoObrasNodosDatos]
(
 IdPresupuestoObrasNodo,
 CodigoPresupuesto ,
 Importe,
 Cantidad,
 CantidadBase,
 Rendimiento,
 Incidencia,
 Costo,
 PrecioVentaUnitario
)
VALUES
(
 @IdPresupuestoObrasNodo,
 @CodigoPresupuesto ,
 @Importe,
 @Cantidad,
 @CantidadBase,
 @Rendimiento,
 @Incidencia,
 @Costo,
 @PrecioVentaUnitario
)

SELECT @IdPresupuestoObrasNodoDatos=@@identity

RETURN(@IdPresupuestoObrasNodoDatos)