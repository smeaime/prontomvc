CREATE Procedure [dbo].[PresupuestoObrasNodosDatos_M]

@IdPresupuestoObrasNodoDatos int,
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

UPDATE PresupuestoObrasNodosDatos
SET
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo,
 CodigoPresupuesto=@CodigoPresupuesto,
 Importe=@Importe,
 Cantidad=@Cantidad,
 CantidadBase=@CantidadBase,
 Rendimiento=@Rendimiento,
 Incidencia=@Incidencia,
 Costo=@Costo,
 PrecioVentaUnitario=@PrecioVentaUnitario
WHERE (IdPresupuestoObrasNodoDatos=@IdPresupuestoObrasNodoDatos)

RETURN(@IdPresupuestoObrasNodoDatos)