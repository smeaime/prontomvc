





























CREATE  Procedure [dbo].[Formularios_M]
@IdFormulario int ,
@Descripcion varchar(50)
AS
Update Formularios
SET
Descripcion=@Descripcion
where (IdFormulario=@IdFormulario)
Return(@IdFormulario)






























