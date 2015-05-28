










CREATE  Procedure [dbo].[CoeficientesImpositivos_M]
@IdCoeficienteImpositivo int,
@AñoFiscal int,
@Año int,
@Mes int,
@CoeficienteActualizacion numeric(19,6)
As
Update CoeficientesImpositivos
Set
 AñoFiscal=@AñoFiscal,
 Año=@Año,
 Mes=@Mes,
 CoeficienteActualizacion=@CoeficienteActualizacion
Where (IdCoeficienteImpositivo=@IdCoeficienteImpositivo)
Return(@IdCoeficienteImpositivo)











