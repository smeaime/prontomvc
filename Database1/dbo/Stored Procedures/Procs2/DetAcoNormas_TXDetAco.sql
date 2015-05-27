





























CREATE Procedure [dbo].[DetAcoNormas_TXDetAco]
@IdAcoNorma int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoNormas.IdDetalleAcoNorma,
DetalleAcoNormas.IdNorma,
Normas.Descripcion as Norma,
DetalleAcoNormas.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoNormas
INNER JOIN Normas ON DetalleAcoNormas.IdNorma = Normas.IdNorma
WHERE (DetalleAcoNormas.IdAcoNorma = @IdAcoNorma)






























