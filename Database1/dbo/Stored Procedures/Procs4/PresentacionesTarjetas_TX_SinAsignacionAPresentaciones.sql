CREATE  Procedure [dbo].[PresentacionesTarjetas_TX_SinAsignacionAPresentaciones]

@IdReciboAModificar int = Null

AS 

SET @IdReciboAModificar=IsNull(@IdReciboAModificar,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111133'
SET @vector_T='009942211100'

SELECT 
 PresentacionesTarjetas.IdPresentacionTarjeta,
 TarjetasCredito.Nombre as [Tarjeta],
 PresentacionesTarjetas.IdPresentacionTarjeta as [IdAux],
 (Select Top 1 Valores.IdReciboAsignado From DetallePresentacionesTarjetas dpt 
	Left Outer Join Valores On Valores.IdValor=dpt.IdValor
	Where dpt.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta and IsNull(Valores.IdReciboAsignado,0)=@IdReciboAModificar) as [IdReciboAsignado],
 PresentacionesTarjetas.FechaIngreso as [Fecha],
 PresentacionesTarjetas.NumeroPresentacion as [Nro.Pres.],
 (Select Count(*) From DetallePresentacionesTarjetas dpt Where dpt.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta) as [Cupones],
 (Select Top 1 Valores.CantidadCuotas From DetallePresentacionesTarjetas dpt 
	Left Outer Join Valores On Valores.IdValor=dpt.IdValor
	Where dpt.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta) as [Cuotas],
 (Select Sum(Valores.Importe) From DetallePresentacionesTarjetas dpt 
	Left Outer Join Valores On Valores.IdValor=dpt.IdValor
	Where dpt.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta) as [Total],
 (Select Top 1 Depositos.Descripcion From DetallePresentacionesTarjetas dpt 
	Left Outer Join Valores On Valores.IdValor=dpt.IdValor
	Left Outer Join Depositos On Depositos.IdDeposito=Valores.IdOrigen
	Where dpt.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta and Valores.IdOrigen is not null) as [Origen],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PresentacionesTarjetas
LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=PresentacionesTarjetas.IdTarjetaCredito
WHERE Exists(Select Top 1 dpt.IdDetallePresentacionTarjeta 
		From DetallePresentacionesTarjetas dpt 
		Left Outer Join Valores On Valores.IdValor=dpt.IdValor
		Where dpt.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta and 
			(IsNull(Valores.IdReciboAsignado,0)=0 or IsNull(Valores.IdReciboAsignado,0)=@IdReciboAModificar))
ORDER BY TarjetasCredito.Nombre, PresentacionesTarjetas.FechaIngreso, PresentacionesTarjetas.NumeroPresentacion