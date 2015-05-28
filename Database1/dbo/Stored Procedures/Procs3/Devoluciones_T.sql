






























CREATE Procedure [dbo].[Devoluciones_T]
@IdDevolucion int
AS 
SELECT *
FROM Devoluciones
where (IdDevolucion=@IdDevolucion)































