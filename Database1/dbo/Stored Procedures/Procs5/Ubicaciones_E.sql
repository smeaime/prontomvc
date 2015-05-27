
CREATE Procedure [dbo].[Ubicaciones_E]

@IdUbicacion int  

AS 

DELETE Ubicaciones
WHERE (IdUbicacion=@IdUbicacion)
