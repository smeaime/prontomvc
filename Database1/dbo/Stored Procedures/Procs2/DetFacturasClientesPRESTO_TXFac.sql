




















CREATE PROCEDURE [dbo].[DetFacturasClientesPRESTO_TXFac]

@IdFacturaClientePRESTO int

As

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000111133'
set @vector_T='000555500'

SELECT
 DetFac.IdDetalleFacturaClientePRESTO,
 DetFac.IdFacturaClientePRESTO,
 DetFac.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetFac.Cantidad as [Cantidad],
 DetFac.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFacturasClientesPRESTO DetFac
LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo
WHERE (DetFac.IdFacturaClientePRESTO = @IdFacturaClientePRESTO)





















