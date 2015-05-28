CREATE PROCEDURE [dbo].[DetValesSalida_TX_TodosLosItemsConFormato]

@IdValeSalida int

AS

SELECT
 DetVal.IdDetalleValeSalida,
 DetVal.IdValeSalida,
 DetVal.IdDetalleLMateriales,
 DetVal.IdArticulo,
 LMateriales.NumeroLMateriales,
 DetalleLMateriales.NumeroItem as [NumeroItemLMateriales],
 Reservas.NumeroReserva,
 Articulos.Codigo,
 Articulos.Descripcion as [Articulo],
 DetVal.Cantidad,
 DetVal.Cantidad1,
 DetVal.Cantidad2,
 DetVal.IdUnidad,
 Substring(Unidades.Descripcion,1,20) as [En :],
 DetVal.Cumplido,
 DetVal.Estado,
 ValesSalida.NumeroValeSalida,
 ValesSalida.Cumplido
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN ValesSalida ON DetVal.IdValeSalida = ValesSalida.IdValeSalida
LEFT OUTER JOIN Articulos ON DetVal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetVal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleLMateriales ON DetVal.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales 
LEFT OUTER JOIN DetalleReservas ON DetVal.IdDetalleReserva = DetalleReservas.IdDetalleReserva
LEFT OUTER JOIN Reservas ON DetalleReservas.IdReserva= Reservas.IdReserva
WHERE (DetVal.IdValeSalida = @IdValeSalida)
