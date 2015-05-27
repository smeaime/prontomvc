
CREATE  Procedure [dbo].[Clausulas_M]

@IdClausula int ,
@Descripcion varchar(200),
@Orden int

AS

UPDATE Clausulas
SET
 Descripcion=@Descripcion,
 Orden=@Orden
WHERE (IdClausula=@IdClausula)

RETURN(@IdClausula)
