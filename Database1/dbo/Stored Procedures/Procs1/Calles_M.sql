CREATE  Procedure [dbo].[Calles_M]

@IdCalle int ,
@Nombre varchar(50)

AS

UPDATE Calles
SET
 Nombre=@Nombre
WHERE (IdCalle=@IdCalle)

RETURN(@IdCalle)