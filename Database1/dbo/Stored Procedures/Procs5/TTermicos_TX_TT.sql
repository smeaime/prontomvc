





























CREATE Procedure [dbo].[TTermicos_TX_TT]
@IdTratamiento int
AS 
Select *
FROM TratamientosTermicos
where (IdTratamiento=@IdTratamiento)
order by Descripcion






























