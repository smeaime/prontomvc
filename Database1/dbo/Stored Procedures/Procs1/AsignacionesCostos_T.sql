






CREATE Procedure [dbo].[AsignacionesCostos_T]
@IdAsignacionCosto int
AS 
SELECT *
FROM AsignacionesCostos
WHERE (IdAsignacionCosto=@IdAsignacionCosto)







