































CREATE  Procedure [dbo].[AniosNorma_M]
@IdAnioNorma int ,
@Descripcion varchar(50)
AS
Update AniosNorma
SET
Descripcion=@Descripcion
where (IdAnioNorma=@IdAnioNorma)
Return(@IdAnioNorma)
































