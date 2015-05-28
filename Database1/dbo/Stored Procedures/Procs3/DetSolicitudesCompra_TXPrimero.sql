CREATE PROCEDURE [dbo].[DetSolicitudesCompra_TXPrimero]

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111133'
SET @vector_T='02901911000'

SELECT TOP 1
 DetSol.IdDetalleSolicitudCompra,
 Requerimientos.NumeroRequerimiento as [RM],
 DetSol.IdDetalleSolicitudCompra as [IdDet],
 DetalleRequerimientos.NumeroItem as [Item],
 DetalleRequerimientos.Cantidad as [Cant.RM],
 DetSol.Cantidad as [Cant.Sol.Aux.],
 DetSol.Cantidad as [Cant.Sol.],
 Unidades.Abreviatura as [Un.],
 Articulos.Descripcion as [Material],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSolicitudesCompra DetSol
LEFT OUTER JOIN SolicitudesCompra ON DetSol.IdSolicitudCompra = SolicitudesCompra.IdSolicitudCompra
LEFT OUTER JOIN DetalleRequerimientos ON DetSol.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Articulos ON DetalleRequerimientos.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetalleRequerimientos.IdUnidad = Unidades.IdUnidad