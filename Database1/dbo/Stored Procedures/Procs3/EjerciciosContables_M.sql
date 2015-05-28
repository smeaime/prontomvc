
CREATE  Procedure [dbo].[EjerciciosContables_M]

@IdEjercicioContable int ,
@NumeroEjercicio int,
@FechaInicio datetime,
@FechaFinalizacion datetime

AS

UPDATE EjerciciosContables
SET
 NumeroEjercicio=@NumeroEjercicio,
 FechaInicio=@FechaInicio,
 FechaFinalizacion=@FechaFinalizacion
WHERE (IdEjercicioContable=@IdEjercicioContable)

RETURN(@IdEjercicioContable)
