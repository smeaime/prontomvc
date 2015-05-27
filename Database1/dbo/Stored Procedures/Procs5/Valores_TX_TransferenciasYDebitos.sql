CREATE  Procedure [dbo].[Valores_TX_TransferenciasYDebitos]

@Fecha datetime,
@IdBanco Int = Null

AS

SET @IdBanco=IsNull(@IdBanco,-1)

SELECT Sum(IsNull(Valores.Importe,0) * Case When Valores.IdDetalleOrdenPagoValores is not null Then -1 Else 1 End) as [Importe]
FROM Valores 
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoValor=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN DetalleRecibosValores drv ON drv.IdDetalleReciboValores=Valores.IdDetalleReciboValores
LEFT OUTER JOIN DetalleRecibosCuentas drc ON drc.IdDetalleReciboCuentas=Valores.IdDetalleReciboCuentas
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=IsNull(drv.IdRecibo,drc.IdRecibo)
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=IsNull(dopv.IdOrdenPago,dopc.IdOrdenPago)
WHERE (@Fecha=0 or IsNull(Valores.FechaConfirmacionBanco,Valores.FechaComprobante)=@Fecha) and IsNull(Valores.Anulado,'NO')<>'SI' and 
	IsNull(OrdenesPago.TipoOperacionOtros,-1)<>0 and IsNull(Recibos.TipoOperacionOtros,-1)<>0 and 
	(IsNull(Valores.IdTipoComprobante,0)=2 or IsNull(Valores.IdTipoComprobante,0)=17) and 
	IsNull(TiposComprobante.Agrupacion1,'')='DEBITOTRANSFERENCIA' and IsNull(Valores.MovimientoConfirmadoBanco,'NO')='SI' and 
	(@IdBanco=-1 or Valores.IdBanco=@IdBanco or Valores.IdBancoDeposito=@IdBanco)