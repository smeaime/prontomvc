





























CREATE Procedure [dbo].[Relaciones_TX_TT]
@IdRelacion smallint
AS 
Select 
IdRelacion,
Descripcion,
Abreviatura
FROM Relaciones
where (IdRelacion=@IdRelacion)
order by Descripcion






























