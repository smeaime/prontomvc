CREATE  Procedure [dbo].[Cargos_M]

@IdCargo int ,
@Descripcion varchar(50)

AS

UPDATE Cargos
SET
 Descripcion=@Descripcion
WHERE (IdCargo=@IdCargo)

RETURN(@IdCargo)