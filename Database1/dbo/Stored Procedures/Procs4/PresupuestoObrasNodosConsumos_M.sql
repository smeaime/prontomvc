
CREATE Procedure [dbo].[PresupuestoObrasNodosConsumos_M]

@IdPresupuestoObrasNodoConsumo int,
@IdPresupuestoObrasNodo int,
@Fecha datetime,
@Numero int,
@Detalle varchar(100),
@Importe numeric(18,2),
@Origen varchar(10),
@IdEntidad int,
@Cantidad numeric(18,2),
@IdObraOrigen int

AS

UPDATE PresupuestoObrasNodosConsumos
SET
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo,
 Fecha=@Fecha,
 Numero=@Numero,
 Detalle=@Detalle,
 Importe=@Importe,
 Origen=@Origen,
 IdEntidad=@IdEntidad,
 Cantidad=@Cantidad,
 IdObraOrigen=@IdObraOrigen
WHERE (IdPresupuestoObrasNodoConsumo=@IdPresupuestoObrasNodoConsumo)

RETURN(@IdPresupuestoObrasNodoConsumo)
