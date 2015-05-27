





























CREATE Procedure [dbo].[DetAcoTipos_TXDetAco]
@IdAcoTipo int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoTipos.IdDetalleAcoTipo,
DetalleAcoTipos.IdTipo,
Tipos.Descripcion as Tipo,
DetalleAcoTipos.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoTipos
INNER JOIN Tipos ON DetalleAcoTipos.IdTipo = Tipos.IdTipo
WHERE (DetalleAcoTipos.IdAcoTipo = @IdAcoTipo)






























