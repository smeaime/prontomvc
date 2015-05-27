






CREATE  Procedure [dbo].[AsignacionesCostos_M]
@IdAsignacionCosto int ,
@IdCostoImportacion int,
@IdDetallePedido int,
@FechaAsignacion datetime
AS
Update AsignacionesCostos
SET
IdCostoImportacion=@IdCostoImportacion,
IdDetallePedido=@IdDetallePedido,
FechaAsignacion=@FechaAsignacion
WHERE (IdAsignacionCosto=@IdAsignacionCosto)
Return(@IdAsignacionCosto)







