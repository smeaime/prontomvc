CREATE Procedure [dbo].[TiposRosca_E]

@IdTipoRosca int  

AS 

DELETE TiposRosca
WHERE (IdTipoRosca=@IdTipoRosca)