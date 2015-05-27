





























CREATE Procedure [dbo].[Autorizaciones_TT]
AS 
Select 
Autorizaciones.IdAutorizacion,
Formularios.Descripcion as [Formulario]
FROM Autorizaciones
INNER JOIN Formularios ON Autorizaciones.IdFormulario = Formularios.IdFormulario






























