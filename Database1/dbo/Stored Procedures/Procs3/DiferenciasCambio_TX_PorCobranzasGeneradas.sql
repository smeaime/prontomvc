
CREATE Procedure [dbo].[DiferenciasCambio_TX_PorCobranzasGeneradas]

AS 

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteNotaDebito int, @IdMonedaPesos int, @Cotizacion Numeric(12,4)

SET @IdTipoComprobanteFacturaVenta=IsNull((Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1),0)
SET @IdTipoComprobanteNotaDebito=IsNull((Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1),0)
SET @IdMonedaPesos=IsNull((Select Top 1 IdMoneda From Parametros Where IdParametro=1),1)
SET @Cotizacion=(Select Top 1 CotizacionLibre From Cotizaciones
			Where 	Year(Cotizaciones.Fecha)=Year(GETDATE()) And 
				Month(Cotizaciones.Fecha)=Month(GETDATE()) And 
				Day(Cotizaciones.Fecha)=Day(GETDATE()) And 
				Cotizaciones.IdMoneda=(Select Parametros.IdMonedaDolar From Parametros Where Parametros.IdParametro=1))

DECLARE @vector_X varchar(30),@vector_T varchar(30),@Marca varchar(2)
SET @vector_X='011111111111111111111133'
SET @vector_T='029204344444444422666900'
SET @Marca='NO'

SELECT 
 DiferenciasCambio.IdDiferenciaCambio as [IdDiferenciaCambio],
 Clientes.Codigo as [Codigo],
 DiferenciasCambio.IdDiferenciaCambio as [IdAux],
 Clientes.RazonSocial as [Cliente],
 'RE ' + Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [Recibo],
 Recibos.FechaRecibo as [Fecha recibo],
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then Substring('FA '+Facturas.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),1,30)
	Else Substring('ND '+NotasDebito.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),1,30)
 End as [Comprobante],
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then Facturas.FechaFactura 
	Else NotasDebito.FechaNotaDebito 
 End as [Fecha comp.],
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then Round(Facturas.ImporteTotal*Facturas.CotizacionMoneda/
			Case When IsNull(Facturas.CotizacionDolar,0)<>0 Then Facturas.CotizacionDolar Else 1000000 End,2) 
	Else Round(NotasDebito.ImporteTotal*NotasDebito.CotizacionMoneda/
			Case When IsNull(NotasDebito.CotizacionDolar,0)<>0 Then NotasDebito.CotizacionDolar Else 1000000 End,2) 
 End as [Imp.u$s Comp.],
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then Facturas.CotizacionDolar 
	Else NotasDebito.CotizacionDolar 
 End as [Cot.u$s vta.],
 Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda / Case When IsNull(Recibos.Cotizacion,0)<>0 Then Recibos.Cotizacion Else 1000000 End,2) as [Imp.u$s cobrado],
 Recibos.Cotizacion as [Cot.u$s cobro],
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then Recibos.Cotizacion-Facturas.CotizacionDolar
	Else Recibos.Cotizacion-NotasDebito.CotizacionDolar
 End as [Dif.Cot.u$s],
 Case When Recibos.IdMoneda=@IdMonedaPesos 
	Then 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End,2) * 
					(Recibos.Cotizacion-Facturas.CotizacionDolar) *
					(Recibos.Cotizacion/Case When IsNull(Facturas.CotizacionDolar,0)<>0
									Then Facturas.CotizacionDolar Else 1000000 End) / 
					Case When IsNull(Recibos.Cotizacion,0)<>0 Then Recibos.Cotizacion Else 1000000 End 
			Else Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0 Then Recibos.Cotizacion Else 1000000 End ,2) * 
					(Recibos.Cotizacion-NotasDebito.CotizacionDolar) *
					(Recibos.Cotizacion/Case When IsNull(NotasDebito.CotizacionDolar,0)<>0
								Then NotasDebito.CotizacionDolar Else 1000000 End) / 
					Case When IsNull(Recibos.Cotizacion,0)<>0 Then Recibos.Cotizacion Else 1000000 End 
		End
	Else 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End,2) * 
					(Recibos.Cotizacion-Facturas.CotizacionDolar) / 
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End 
			Else Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End,2) * 
					(Recibos.Cotizacion-NotasDebito.CotizacionDolar) / 
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End 
		End
 End as [Dif.cambio u$s],
 Case When Recibos.IdMoneda=@IdMonedaPesos 
	Then 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End,2) * 
					(Recibos.Cotizacion-Facturas.CotizacionDolar) *
					(Recibos.Cotizacion/Case When IsNull(Facturas.CotizacionDolar,0)<>0
									Then Facturas.CotizacionDolar Else 1000000 End) 
			Else Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End,2) * 
					(Recibos.Cotizacion-NotasDebito.CotizacionDolar) *
					(Recibos.Cotizacion/Case When IsNull(NotasDebito.CotizacionDolar,0)<>0
									Then NotasDebito.CotizacionDolar Else 1000000 End) 
		End
	Else 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End,2) * 
					(Recibos.Cotizacion-Facturas.CotizacionDolar) 
			Else Round(DetalleRecibos.Importe*Recibos.CotizacionMoneda/
					Case When IsNull(Recibos.Cotizacion,0)<>0
						Then Recibos.Cotizacion Else 1000000 End,2) * 
					(Recibos.Cotizacion-NotasDebito.CotizacionDolar) 
		End
 End as [Dif.cambio $],
 @Cotizacion as [Cot.u$s dia],
 Case 	When DiferenciasCambio.Estado is null or DiferenciasCambio.Estado='NO'
	 Then 'NO'
	Else DiferenciasCambio.Estado
 End as [Generado],
 @Marca as [Marcado],
 Case 	When DiferenciasCambio.IdTipoComprobanteGenerado is null
	 Then null
 	When TiposComprobante.Coeficiente=1
	 Then 'N.Debito'
 	When TiposComprobante.Coeficiente=-1
	 Then 'N.Credito'
 End as [Tipo comp.gen.],
 Case 	When DiferenciasCambio.IdTipoComprobanteGenerado is null
	 Then null
 	When TiposComprobante.Coeficiente=1
	 Then (Select Top 1 nd.NumeroNotaDebito
		From NotasDebito nd 
		Where DiferenciasCambio.IdComprobanteGenerado=nd.IdNotaDebito)
 	When TiposComprobante.Coeficiente=-1
	 Then (Select Top 1 nc.NumeroNotaCredito
		From NotasCredito nc 
		Where DiferenciasCambio.IdComprobanteGenerado=nc.IdNotaCredito)
 End as [Nro.comp.gen.],
 Case 	When DiferenciasCambio.IdTipoComprobanteGenerado is null
	 Then null
 	When TiposComprobante.Coeficiente=1
	 Then (Select Top 1 nd.FechaNotaDebito
		From NotasDebito nd 
		Where DiferenciasCambio.IdComprobanteGenerado=nd.IdNotaDebito)
 	When TiposComprobante.Coeficiente=-1
	 Then (Select Top 1 nc.FechaNotaCredito
		From NotasCredito nc 
		Where DiferenciasCambio.IdComprobanteGenerado=nc.IdNotaCredito)
 End as [Fecha comp.gen.],
 Recibos.IdCliente,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DiferenciasCambio 
LEFT OUTER JOIN DetalleRecibos ON DetalleRecibos.IdDetalleRecibo=DiferenciasCambio.IdRegistroOrigen And DiferenciasCambio.IdTipoComprobante=2
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetalleRecibos.IdRecibo
LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetalleRecibos.IdImputacion
LEFT OUTER JOIN Facturas ON CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta and 
				Facturas.IdFactura=CuentasCorrientesDeudores.IdComprobante
LEFT OUTER JOIN NotasDebito ON CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteNotaDebito and 
				NotasDebito.IdNotaDebito=CuentasCorrientesDeudores.IdComprobante
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Recibos.IdCliente
LEFT OUTER JOIN TiposComprobante ON  DiferenciasCambio.IdTipoComprobanteGenerado = TiposComprobante.IdTipoComprobante
WHERE DiferenciasCambio.Estado is not null And 
	 DiferenciasCambio.IdTipoComprobante=2 And 
	 (Recibos.Cotizacion -	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta 
					Then Facturas.CotizacionDolar
					Else NotasDebito.CotizacionDolar
				End) is not null And
	 (Recibos.Cotizacion -	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta 
					Then Facturas.CotizacionDolar
					Else NotasDebito.CotizacionDolar
				End)<>0
ORDER by Recibos.FechaRecibo,Recibos.NumeroRecibo
