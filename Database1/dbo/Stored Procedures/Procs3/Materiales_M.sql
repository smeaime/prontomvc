





























CREATE  Procedure [dbo].[Materiales_M]
@IdMaterial int ,
@Descripcion varchar(50)
AS
Update Materiales
SET
Descripcion=@Descripcion
where (IdMaterial=@IdMaterial)
Return(@IdMaterial)






























