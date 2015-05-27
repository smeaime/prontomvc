






CREATE Procedure [dbo].[AsignacionesCostos_E]
@IdAsignacionCosto int  AS 
Delete AsignacionesCostos
where (IdAsignacionCosto=@IdAsignacionCosto)







