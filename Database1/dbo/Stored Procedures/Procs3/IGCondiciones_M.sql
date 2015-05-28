
CREATE  Procedure [dbo].[IGCondiciones_M]

@IdIGCondicion int ,
@Descripcion varchar(50)

AS

UPDATE IGCondiciones
SET
 Descripcion=@Descripcion
WHERE (IdIGCondicion=@IdIGCondicion)

RETURN(@IdIGCondicion)
