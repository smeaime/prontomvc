
CREATE Procedure [dbo].[Bancos_TL]

AS 

SELECT 
 IdBanco,
 Nombre as [Titulo]
FROM Bancos 
ORDER BY Nombre
