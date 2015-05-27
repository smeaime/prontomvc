CREATE Procedure [dbo].[IBCondiciones_TL]

AS 

SELECT IdIBCondicion, Descripcion as [Titulo]
FROM IBCondiciones
ORDER BY Descripcion