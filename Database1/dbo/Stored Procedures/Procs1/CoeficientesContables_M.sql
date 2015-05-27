










CREATE  Procedure [dbo].[CoeficientesContables_M]
@IdCoeficienteContable int,
@Año int,
@Mes int,
@CoeficienteActualizacion numeric(19,6)
As
Update CoeficientesContables
Set
 Año=@Año,
 Mes=@Mes,
 CoeficienteActualizacion=@CoeficienteActualizacion
Where (IdCoeficienteContable=@IdCoeficienteContable)
Return(@IdCoeficienteContable)











