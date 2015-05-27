





























CREATE Procedure [dbo].[Relaciones_T]
@IdRelacion smallint
AS 
SELECT *
FROM Relaciones
where (IdRelacion=@IdRelacion)






























