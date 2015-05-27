





























CREATE  Procedure [dbo].[Relaciones_M]
@IdRelacion smallint ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update Relaciones
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdRelacion=@IdRelacion)
Return(@IdRelacion)






























