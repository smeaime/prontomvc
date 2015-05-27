





























CREATE  Procedure [dbo].[Modelos_M]
@IdModelo int ,
@Descripcion varchar(50)
AS
Update Modelos
SET
Descripcion=@Descripcion
where (IdModelo=@IdModelo)
Return(@IdModelo)






























