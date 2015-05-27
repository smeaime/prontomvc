CREATE Procedure [dbo].[Conciliaciones_T]

@IdConciliacion int

AS 

SELECT * 
FROM Conciliaciones
WHERE (IdConciliacion=@IdConciliacion)