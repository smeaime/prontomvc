





























CREATE Procedure [dbo].[Planos_T]
@IdPlano int
AS 
SELECT *
FROM Planos
where (IdPlano=@IdPlano)






























