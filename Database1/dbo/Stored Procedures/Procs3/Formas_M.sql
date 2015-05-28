





























CREATE  Procedure [dbo].[Formas_M]
@IdForma smallint ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update Formas
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdForma=@IdForma)
Return(@IdForma)






























