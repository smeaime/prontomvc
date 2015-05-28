










CREATE Procedure [dbo].[CoeficientesContables_TT]
AS 
SELECT 
 IdCoeficienteContable,
 Año,
 Mes,
 CoeficienteActualizacion as [Coeficiente]
FROM CoeficientesContables
ORDER by Año,Mes











