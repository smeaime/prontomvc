


CREATE PROCEDURE [dbo].[DetDistribucionesObras_TXPrimero]

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111133'
set @vector_T='05995200'

SELECT TOP 1
 Det.IdDetalleDistribucionObra,
 Obras.NumeroObra as [Numero],
 Det.IdDetalleDistribucionObra as [IdAux1],
 Det.IdObra as [IdAux2],
 Obras.Descripcion as [Obra],
 Det.Porcentaje as [Porcentaje],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDistribucionesObras Det
LEFT OUTER JOIN Obras ON Det.IdObra = Obras.IdObra


