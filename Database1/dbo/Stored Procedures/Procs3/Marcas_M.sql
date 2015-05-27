CREATE  Procedure [dbo].[Marcas_M]

@IdMarca int ,
@Descripcion varchar(50),
@Codigo int 

AS

UPDATE Marcas
SET
 Descripcion=@Descripcion,
 Codigo=@Codigo
WHERE (IdMarca=@IdMarca)

RETURN(@IdMarca)