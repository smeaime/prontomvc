
CREATE Procedure [dbo].[wProvincias_E]

@IdProvincia int  

AS 

DELETE Provincias
WHERE (IdProvincia=@IdProvincia)

