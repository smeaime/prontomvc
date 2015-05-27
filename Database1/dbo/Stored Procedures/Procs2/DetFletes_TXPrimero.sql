CREATE Procedure [dbo].[DetFletes_TXPrimero]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0011111133'
SET @vector_T='0086666600'

SELECT TOP 1
 DetalleFletes.IdDetalleFlete,
 DetalleFletes.IdFlete,
 DetalleFletes.Fecha as [Fecha mod.],
 DetalleFletes.Tara as [Tara],
 DetalleFletes.Ancho as [Ancho],
 DetalleFletes.Largo as [Largo],
 DetalleFletes.Alto as [Alto],
 DetalleFletes.Capacidad as [Capacidad],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFletes