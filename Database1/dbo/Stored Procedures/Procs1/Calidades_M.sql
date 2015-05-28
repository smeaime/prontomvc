





























CREATE  Procedure [dbo].[Calidades_M]
@IdCalidad int ,
@Descripcion varchar(50)
AS
Update Calidades
SET
Descripcion=@Descripcion
where (IdCalidad=@IdCalidad)
Return(@IdCalidad)






























