





























CREATE  Procedure [dbo].[Grados_M]
@IdGrado int ,
@Descripcion varchar(50)
AS
Update Grados
SET
Descripcion=@Descripcion
where (IdGrado=@IdGrado)
Return(@IdGrado)






























