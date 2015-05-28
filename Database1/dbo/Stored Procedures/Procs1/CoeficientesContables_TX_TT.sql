










CREATE Procedure [dbo].[CoeficientesContables_TX_TT]
@IdCoeficienteContable int
AS 
SELECT 
 IdCoeficienteContable,
 Año,
 Mes,
 CoeficienteActualizacion as [Coeficiente]
FROM CoeficientesContables
WHERE (IdCoeficienteContable=@IdCoeficienteContable)











