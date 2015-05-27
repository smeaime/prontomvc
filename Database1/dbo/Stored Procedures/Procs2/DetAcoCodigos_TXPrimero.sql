





























CREATE Procedure [dbo].[DetAcoCodigos_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoCodigos.IdDetalleAcoCodigo,
DetalleAcoCodigos.IdCodigo,
Codigos.Descripcion as Codigo,
DetalleAcoCodigos.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoCodigos
INNER JOIN Codigos ON DetalleAcoCodigos.IdCodigo = Codigos.IdCodigo






























