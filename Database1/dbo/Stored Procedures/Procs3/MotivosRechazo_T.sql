





























CREATE Procedure [dbo].[MotivosRechazo_T]
@IdMotivoRechazo int
AS 
SELECT IdMotivoRechazo, Descripcion
FROM MotivosRechazo
where (IdMotivoRechazo=@IdMotivoRechazo)






























