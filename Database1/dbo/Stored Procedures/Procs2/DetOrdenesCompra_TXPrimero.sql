
CREATE Procedure [dbo].[DetOrdenesCompra_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0000111111811881111133'
SET @vector_T='000014E211229122445000'

SELECT TOP 1
 doc.IdDetalleOrdenCompra,
 doc.IdOrdenCompra,
 doc.TipoCancelacion,
 IsNull(doc.FacturacionAutomatica,'NO') as [FacturacionAutomatica],
 doc.NumeroItem as [Item],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Colores.Descripcion as [Color],
 doc.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 doc.Precio as [Precio],
 doc.PorcentajeBonificacion as [% Bon],
 doc.OrigenDescripcion,
 (doc.Cantidad * doc.Precio) * IsNull(doc.PorcentajeBonificacion,0)/100  as [Bonificacion],
 (doc.Cantidad * doc.Precio) * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [Importe],
 (Select Sum(IsNull(Stock.CantidadUnidades,0)) 
	From Stock Where Stock.IdArticulo=doc.IdArticulo)  as [Stock],
 doc.FechaNecesidad as [Fecha nec.],
 doc.FechaEntrega as [Fecha ent.],
 doc.Observaciones,
 doc.Cumplido as [Cum],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON doc.IdColor=Colores.IdColor
