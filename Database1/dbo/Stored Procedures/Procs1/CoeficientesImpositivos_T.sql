










CREATE Procedure [dbo].[CoeficientesImpositivos_T]
@IdCoeficienteImpositivo int
AS 
SELECT *
FROM CoeficientesImpositivos
WHERE (IdCoeficienteImpositivo=@IdCoeficienteImpositivo)











