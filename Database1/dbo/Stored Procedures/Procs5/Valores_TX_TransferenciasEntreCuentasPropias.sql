
CREATE  Procedure [dbo].[Valores_TX_TransferenciasEntreCuentasPropias]

@IdBanco Int,
@Fecha datetime,
@Formato varchar(10)

AS

IF @Formato='DETALLE'
  BEGIN
	SELECT Valores.*
	FROM Valores 
	LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
	LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopc.IdOrdenPago
	WHERE Valores.IdDetalleOrdenPagoCuentas is not null and IsNull(OrdenesPago.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI' and 
			Valores.IdTipoValor<>6 and (@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco) and Valores.FechaConfirmacionBanco=@Fecha and Valores.IdCuentaBancaria is not null  

	UNION ALL

	SELECT Valores.*
	FROM Valores 
	LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
	LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopv.IdOrdenPago
	WHERE Valores.IdDetalleOrdenPagoValores is not null and IsNull(OrdenesPago.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI' and 
			Valores.IdTipoValor<>6 and (@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco) and Valores.FechaConfirmacionBanco=@Fecha and Valores.IdCuentaBancaria is not null  
  END

IF @Formato='RESUMEN'
  BEGIN
	SET NOCOUNT ON

	CREATE TABLE #Auxiliar1 (Importe NUMERIC(18,2))
	INSERT INTO #Auxiliar1 
	 SELECT Valores.Importe
	 FROM Valores 
	 LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
	 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopc.IdOrdenPago
	 WHERE Valores.IdDetalleOrdenPagoCuentas is not null and IsNull(OrdenesPago.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI' and 
			Valores.IdTipoValor<>6 and (@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco) and Valores.FechaConfirmacionBanco=@Fecha and Valores.IdCuentaBancaria is not null  

	INSERT INTO #Auxiliar1 
	 SELECT Valores.Importe
	 FROM Valores 
	 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
	 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopv.IdOrdenPago
	 WHERE Valores.IdDetalleOrdenPagoValores is not null and IsNull(OrdenesPago.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI' and 
			Valores.IdTipoValor<>6 and (@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco) and Valores.FechaConfirmacionBanco=@Fecha and Valores.IdCuentaBancaria is not null  

	SET NOCOUNT OFF

	SELECT Sum(IsNull(Importe,0)) as [Importe]
	FROM #Auxiliar1
	
	DROP TABLE #Auxiliar1
  END

