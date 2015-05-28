





























CREATE  Procedure [dbo].[Rangos_M]
@IdRango int ,
@Descripcion varchar(50)
AS
Update Rangos
SET
Descripcion=@Descripcion
where (IdRango=@IdRango)
Return(@IdRango)






























