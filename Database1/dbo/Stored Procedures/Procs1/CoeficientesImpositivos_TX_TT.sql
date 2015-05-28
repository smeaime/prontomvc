










CREATE Procedure [dbo].[CoeficientesImpositivos_TX_TT]
@IdCoeficienteImpositivo int
AS 
SELECT 
 IdCoeficienteImpositivo,
 AñoFiscal as [Año Fiscal],
 Año,
 Mes,
 CoeficienteActualizacion as [Coeficiente]
FROM CoeficientesImpositivos
WHERE (IdCoeficienteImpositivo=@IdCoeficienteImpositivo)











