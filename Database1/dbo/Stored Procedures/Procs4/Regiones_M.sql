CREATE  Procedure [dbo].[Regiones_M]

@IdRegion int ,
@Descripcion varchar(50),
@Codigo int

AS

UPDATE Regiones
SET
 Descripcion=@Descripcion,
 Codigo=@Codigo
WHERE (IdRegion=@IdRegion)

RETURN(@IdRegion)