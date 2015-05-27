





























CREATE  Procedure [dbo].[Autorizaciones_M]
@IdAutorizacion int  output,
@IdFormulario int,
@FechaUltimaActualizacion datetime
AS
Update Autorizaciones
SET
IdFormulario=@IdFormulario,
FechaUltimaActualizacion=@FechaUltimaActualizacion
where (IdAutorizacion=@IdAutorizacion)
Return(@IdAutorizacion)






























