










CREATE Procedure [dbo].[CoeficientesImpositivos_A]
@IdCoeficienteImpositivo int  output,
@AñoFiscal int,
@Año int,
@Mes int,
@CoeficienteActualizacion numeric(19,6)
As 
Insert into [CoeficientesImpositivos]
(
 AñoFiscal,
 Año,
 Mes,
 CoeficienteActualizacion
)
Values
(
 @AñoFiscal,
 @Año,
 @Mes,
 @CoeficienteActualizacion
)
Select @IdCoeficienteImpositivo=@@identity
Return(@IdCoeficienteImpositivo)











