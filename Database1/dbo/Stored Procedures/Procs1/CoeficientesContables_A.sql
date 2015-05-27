










CREATE Procedure [dbo].[CoeficientesContables_A]
@IdCoeficienteContable int  output,
@Año int,
@Mes int,
@CoeficienteActualizacion numeric(19,6)
As 
Insert into [CoeficientesContables]
(
 Año,
 Mes,
 CoeficienteActualizacion
)
Values
(
 @Año,
 @Mes,
 @CoeficienteActualizacion
)
Select @IdCoeficienteContable=@@identity
Return(@IdCoeficienteContable)











