





























CREATE  Procedure [dbo].[Biselados_M]
@IdBiselado int ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update Biselados
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdBiselado=@IdBiselado)
Return(@IdBiselado)






























