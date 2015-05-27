CREATE Procedure [dbo].[Polizas_TL]

AS 

SELECT 
 IdPoliza,
 Numero as [Titulo]
FROM Polizas
ORDER BY Numero