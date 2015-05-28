


CREATE Procedure [dbo].[EjerciciosContables_A]
@IdEjercicioContable int  output,
@NumeroEjercicio int,
@FechaInicio datetime,
@FechaFinalizacion datetime
AS 
Insert into [EjerciciosContables]
(
 NumeroEjercicio,
 FechaInicio,
 FechaFinalizacion
)
Values
(
 @NumeroEjercicio,
 @FechaInicio,
 @FechaFinalizacion
)
Select @IdEjercicioContable=@@identity
Return(@IdEjercicioContable)


