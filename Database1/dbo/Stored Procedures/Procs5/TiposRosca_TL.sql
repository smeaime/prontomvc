CREATE Procedure [dbo].[TiposRosca_TL]

AS 

SELECT IdTipoRosca,Descripcion as Titulo
FROM TiposRosca 
ORDER BY Descripcion