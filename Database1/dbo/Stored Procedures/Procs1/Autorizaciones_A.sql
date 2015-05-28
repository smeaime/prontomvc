





























CREATE Procedure [dbo].[Autorizaciones_A]
@IdAutorizacion int  output,
@IdFormulario int,
@FechaUltimaActualizacion datetime
AS 
Insert into [Autorizaciones]
(
IdFormulario,
FechaUltimaActualizacion
)
Values
(
@IdFormulario,
@FechaUltimaActualizacion
)
Select @IdAutorizacion=@@identity
Return(@IdAutorizacion)






























