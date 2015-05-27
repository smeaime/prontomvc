










CREATE Procedure [dbo].[Bancos_TX_HabilitadosParaCobroCuotas]
AS 
SELECT 
 IdBanco,
 Nombre as [Titulo]
FROM Bancos 
WHERE Codigo is not null
ORDER by Nombre










