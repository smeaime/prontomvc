





























CREATE Procedure [dbo].[MotivosRechazo_A]
@IdMotivoRechazo int  output,
@Descripcion varchar(50)
AS 
Insert into [MotivosRechazo]
(Descripcion)
Values(@Descripcion)
Select @IdMotivoRechazo=@@identity
Return(@IdMotivoRechazo)






























