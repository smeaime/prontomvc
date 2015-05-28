





























CREATE  Procedure [dbo].[Normas_M]
@IdNorma int ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update Normas
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdNorma=@IdNorma)
Return(@IdNorma)






























