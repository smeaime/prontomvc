CREATE PROCEDURE [dbo].[DetValesSalida_TXPrimero]

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0001111111111111111133'
SET @vector_T='00019013E0331213333200'

SELECT TOP 1
 DetVal.IdDetalleValeSalida,
 DetVal.IdValeSalida,
 DetVal.IdArticulo,
 LMateriales.NumeroLMateriales as [L.M.],
 DetVal.IdDetalleValeSalida as [IdAux],
 DetalleLMateriales.NumeroItem as [Item],
 Reservas.NumeroReserva as [R.S.],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetVal.Cantidad as [Cant.],
 DetVal.Cantidad1 as [Med.1],
 DetVal.Cantidad2 as [Med.2],
 Substring(Unidades.Descripcion,1,20) as [En :],
 DetVal.Cumplido as [Cumplido],
 DetVal.Estado as [Estado],
 Requerimientos.NumeroRequerimiento as [Nro.Req.],
 DetReq.NumeroItem as [Item RM],
 DetReq.CodigoDistribucion as [Cod.Dist.],
 Requerimientos.TipoRequerimiento as [Tipo RM],
 DetReq.ObservacionesFirmante as [Observaciones firmante],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN Articulos ON DetVal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetVal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleLMateriales ON DetVal.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales 
LEFT OUTER JOIN DetalleReservas ON DetVal.IdDetalleReserva = DetalleReservas.IdDetalleReserva
LEFT OUTER JOIN Reservas ON DetalleReservas.IdReserva= Reservas.IdReserva
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetVal.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento