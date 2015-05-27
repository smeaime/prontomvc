





























CREATE  Procedure [dbo].[Familias_M]
@IdFamilia int ,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@EnviarEmail tinyint
AS
Update Familias
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura,
EnviarEmail=@EnviarEmail
where (IdFamilia=@IdFamilia)
Return(@IdFamilia)






























