



CREATE PROCEDURE [dbo].[DetValesSalida_TX_DetallesParametrizados]

@IdValeSalida int,
@NivelParametrizacion int

AS

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='00011111111111133'
	Set @vector_T='00099993009912100'
   END
ELSE
   BEGIN
	Set @vector_X='00011111111111133'
	Set @vector_T='00019013003312100'
   END

SELECT
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
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN Articulos ON DetVal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetVal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleLMateriales ON DetVal.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales 
LEFT OUTER JOIN DetalleReservas ON DetVal.IdDetalleReserva = DetalleReservas.IdDetalleReserva
LEFT OUTER JOIN Reservas ON DetalleReservas.IdReserva= Reservas.IdReserva
WHERE (DetVal.IdValeSalida = @IdValeSalida)



