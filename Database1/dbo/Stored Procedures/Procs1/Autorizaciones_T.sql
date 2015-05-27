





























CREATE Procedure [dbo].[Autorizaciones_T]
@IdAutorizacion int
AS 
SELECT *
FROM Autorizaciones
where (IdAutorizacion=@IdAutorizacion)






























