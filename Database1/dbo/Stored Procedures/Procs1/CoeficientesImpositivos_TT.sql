










CREATE Procedure [dbo].[CoeficientesImpositivos_TT]
AS 
SELECT 
 IdCoeficienteImpositivo,
 AñoFiscal as [Año fiscal],
 Año,
 Mes,
 CoeficienteActualizacion as [Coeficiente]
FROM CoeficientesImpositivos
ORDER by Año,Mes










