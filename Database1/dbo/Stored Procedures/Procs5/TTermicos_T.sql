





























CREATE Procedure [dbo].[TTermicos_T]
@IdTratamiento int
AS 
SELECT *
FROM TratamientosTermicos
where (IdTratamiento=@IdTratamiento)






























