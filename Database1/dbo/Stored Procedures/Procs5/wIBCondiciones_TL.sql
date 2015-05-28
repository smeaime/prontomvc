
CREATE Procedure [dbo].[wIBCondiciones_TL]
AS 
SELECT IdIBCondicion, Descripcion as [Titulo]
FROM IBCondiciones
ORDER BY Descripcion

