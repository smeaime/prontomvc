





























CREATE  Procedure [dbo].[CodigosUniversales_M]
@IdCodigoUniversal smallint ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update CodigosUniversales
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdCodigoUniversal=@IdCodigoUniversal)
Return(@IdCodigoUniversal)






























