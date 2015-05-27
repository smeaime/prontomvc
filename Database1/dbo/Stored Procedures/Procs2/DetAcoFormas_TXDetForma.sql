





























CREATE Procedure [dbo].[DetAcoFormas_TXDetForma]
@IdAcoForma int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoFormas.IdDetalleAcoForma,
DetalleAcoFormas.IdForma,
Formas.Descripcion as Forma,
DetalleAcoFormas.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoFormas
INNER JOIN Formas ON DetalleAcoFormas.IdForma = Formas.IdForma
WHERE (DetalleAcoFormas.IdAcoForma = @IdAcoForma)






























