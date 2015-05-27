CREATE Procedure [dbo].[ListasPrecios_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111133'
SET @vector_T='039241F200'

SELECT 
 lp.IdListaPrecios as [IdListaPrecios],
 lp.Descripcion as [Descripcion lista de precios],
 lp.IdListaPrecios as [IdAux1],
 lp.NumeroLista as [Numero],
 lp.FechaVigencia as [Fecha vig.],
 lp.Activa as [Activa?],
 Monedas.Nombre as [Moneda],
 Obras.Descripcion as [Sucursal asociada],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ListasPrecios lp 
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=lp.IdMoneda
LEFT OUTER JOIN Obras ON Obras.IdObra=lp.IdObra
ORDER by lp.Descripcion