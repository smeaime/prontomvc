





























CREATE  Procedure [dbo].[CentrosCosto_M]
@IdCentroCosto int,
@Codigo varchar(10),
@Descripcion varchar(50)
AS
Update CentrosCosto
SET
Codigo=@Codigo,
Descripcion=@Descripcion
where (IdCentroCosto=@IdCentroCosto)
Return(@IdCentroCosto)






























