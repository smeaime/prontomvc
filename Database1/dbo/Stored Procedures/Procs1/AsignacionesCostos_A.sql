






CREATE Procedure [dbo].[AsignacionesCostos_A]
@IdAsignacionCosto int  output,
@IdCostoImportacion int,
@IdDetallePedido int,
@FechaAsignacion datetime
AS 
Insert into [AsignacionesCostos]
(
 IdCostoImportacion,
 IdDetallePedido,
 FechaAsignacion
)
Values
(
 @IdCostoImportacion,
 @IdDetallePedido,
 @FechaAsignacion
)
Select @IdAsignacionCosto=@@identity
Return(@IdAsignacionCosto)







