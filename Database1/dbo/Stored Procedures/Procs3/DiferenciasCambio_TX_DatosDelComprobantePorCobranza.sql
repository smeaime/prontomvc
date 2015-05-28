
CREATE Procedure [dbo].[DiferenciasCambio_TX_DatosDelComprobantePorCobranza]

@IdDiferenciaCambio int

AS 

DECLARE @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteNotaDebito int
SET @IdTipoComprobanteFacturaVenta=IsNull((Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1),0)
SET @IdTipoComprobanteNotaDebito=IsNull((Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1),0)

SELECT DetalleRecibos.IdImputacion
FROM DiferenciasCambio 
LEFT OUTER JOIN DetalleRecibos ON DetalleRecibos.IdDetalleRecibo=DiferenciasCambio.IdRegistroOrigen And DiferenciasCambio.IdTipoComprobante=2
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetalleRecibos.IdRecibo
LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetalleRecibos.IdImputacion
LEFT OUTER JOIN Facturas ON CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta and 
				Facturas.IdFactura=CuentasCorrientesDeudores.IdComprobante
LEFT OUTER JOIN NotasDebito ON CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteNotaDebito and 
				NotasDebito.IdNotaDebito=CuentasCorrientesDeudores.IdComprobante
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Recibos.IdCliente
WHERE DiferenciasCambio.IdDiferenciaCambio=@IdDiferenciaCambio and 
	DiferenciasCambio.Estado is null And 
	DiferenciasCambio.IdTipoComprobante=2 And 
	 (Recibos.Cotizacion -	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta 
					Then Facturas.CotizacionDolar
					Else NotasDebito.CotizacionDolar
				End) is not null And
	 (Recibos.Cotizacion -	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta 
					Then Facturas.CotizacionDolar
					Else NotasDebito.CotizacionDolar
				End)<>0
