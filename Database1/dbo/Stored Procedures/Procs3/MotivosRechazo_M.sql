





























CREATE  Procedure [dbo].[MotivosRechazo_M]
@IdMotivoRechazo int ,
@Descripcion varchar(50)
AS
Update MotivosRechazo
SET
Descripcion=@Descripcion
where (IdMotivoRechazo=@IdMotivoRechazo)
Return(@IdMotivoRechazo)






























