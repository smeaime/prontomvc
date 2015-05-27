










CREATE Procedure [dbo].[CoeficientesContables_T]
@IdCoeficienteContable int
AS 
SELECT *
FROM CoeficientesContables
WHERE (IdCoeficienteContable=@IdCoeficienteContable)











