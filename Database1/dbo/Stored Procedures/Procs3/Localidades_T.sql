






























CREATE Procedure [dbo].[Localidades_T]
@IdLocalidad smallint
AS 
SELECT *
FROM Localidades
where (IdLocalidad=@IdLocalidad)































