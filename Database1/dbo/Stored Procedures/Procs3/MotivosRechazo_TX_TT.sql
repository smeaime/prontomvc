





























CREATE Procedure [dbo].[MotivosRechazo_TX_TT]
@IdMotivoRechazo int
AS 
Select IdMotivoRechazo,Descripcion
FROM MotivosRechazo
where (IdMotivoRechazo=@IdMotivoRechazo)






























