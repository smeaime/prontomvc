





























CREATE  Procedure [dbo].[Densidades_M]
@IdDensidad int ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update Densidades
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdDensidad=@IdDensidad)
Return(@IdDensidad)






























