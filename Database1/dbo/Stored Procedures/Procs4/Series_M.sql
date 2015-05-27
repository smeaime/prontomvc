





























CREATE  Procedure [dbo].[Series_M]
@IdSerie smallint ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update Series
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdSerie=@IdSerie)
Return(@IdSerie)






























