
CREATE Procedure [dbo].[Ubicaciones_T]

@IdUbicacion int

AS 

SELECT *
FROM Ubicaciones
WHERE (IdUbicacion=@IdUbicacion)
