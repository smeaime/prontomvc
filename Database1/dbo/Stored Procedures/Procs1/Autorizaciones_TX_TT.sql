





























CREATE Procedure [dbo].[Autorizaciones_TX_TT]
@IdAutorizacion int
AS 
Select 
Autorizaciones.IdAutorizacion,
Formularios.Descripcion as [Formulario]
FROM Autorizaciones
INNER JOIN Formularios ON Autorizaciones.IdFormulario = Formularios.IdFormulario
where (IdAutorizacion=@IdAutorizacion)






























