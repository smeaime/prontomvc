CREATE Procedure [dbo].[TiposRosca_T]

@IdTipoRosca int

AS 

SELECT*
FROM TiposRosca
WHERE (IdTipoRosca=@IdTipoRosca)