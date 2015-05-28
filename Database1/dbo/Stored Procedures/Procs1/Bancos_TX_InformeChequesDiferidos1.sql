CREATE Procedure [dbo].[Bancos_TX_InformeChequesDiferidos1]

@Fecha datetime,
@IdBanco int,
@RegistrosResumidos varchar(2) = Null

AS

SET NOCOUNT ON

SET @RegistrosResumidos=IsNull(@RegistrosResumidos,'NO')

DECLARE @ActivarCircuitoChequesDiferidos varchar(2)

SET @ActivarCircuitoChequesDiferidos=IsNull((Select ActivarCircuitoChequesDiferidos  From Parametros Where IdParametro=1),'NO')

CREATE TABLE #Auxiliar (IdValor INTEGER, Dias INTEGER, Mes INTEGER, Año INTEGER)
INSERT INTO #Auxiliar 
 SELECT  Valores.IdValor, DATEDIFF(day,@Fecha,Valores.FechaValor), Month(Valores.FechaValor), Year(Valores.FechaValor)
 FROM Valores 
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and 
	@ActivarCircuitoChequesDiferidos='SI' and 
	Valores.IdTipoValor=6 and 
	Valores.IdTipoComprobante=17 and 
	IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
	IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO' and 
	(@IdBanco=-1 or Valores.IdBanco=@IdBanco)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50), @vector_E varchar(1000)
SET @vector_X='0000001111611111111133'
SET @vector_T='000000G2342E4222055900'
SET @vector_E='  |  |  |  | BOL |  |  |  |  |  |  |  '

IF @RegistrosResumidos='SI'
   BEGIN
	SELECT
	 #Auxiliar.IdValor,
	 Bancos.Nombre as [Banco],
	 Valores.NumeroInterno as [Nro.Int.],
	 Valores.NumeroValor as [Numero valor],
	 Valores.FechaValor as [Fecha valor],
	 Valores.Importe as [Importe],
	 Monedas.Abreviatura as [Mon.],
	 Valores.FechaComprobante as [Fec.Comp.],
	 tc1.DescripcionAb as [Tipo Comp.],
	 Valores.NumeroComprobante as [Comp.],
	 Proveedores.RazonSocial as [Proveedor],
	 #Auxiliar.Dias as [Dias],
	 Valores.Detalle as [Detalle],
	 OrdenesPago.Observaciones as [Observaciones],
	 Valores.IdTipoComprobante as [IdTipoComprobante],
	 Case When Valores.Estado='G' Then #Auxiliar.IdValor Else IsNull(dopv.IdOrdenPago,IsNull(dopc.IdOrdenPago,IsNull(drv.IdRecibo,IsNull(drc.IdRecibo,IsNull(da.IdAsiento,0))))) End as [IdComprobante]
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
	LEFT OUTER JOIN TiposComprobante tc1 ON Valores.IdTipoComprobante=tc1.IdTipoComprobante
	LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
	LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
	LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON Valores.IdDetalleOrdenPagoCuentas=dopc.IdDetalleOrdenPagoCuentas
	LEFT OUTER JOIN DetalleAsientos da ON Valores.IdDetalleAsiento=da.IdDetalleAsiento
	LEFT OUTER JOIN DetalleRecibosValores drv ON Valores.IdDetalleReciboValores=drv.IdDetalleReciboValores
	LEFT OUTER JOIN DetalleRecibosCuentas drc ON Valores.IdDetalleReciboCuentas=drc.IdDetalleReciboCuentas
	LEFT OUTER JOIN OrdenesPago ON IsNull(dopv.IdOrdenPago,dopc.IdOrdenPago)=OrdenesPago.IdOrdenPago
	LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
	ORDER BY Bancos.Nombre, Valores.FechaValor, Valores.NumeroComprobante
   END
ELSE
   BEGIN
	SELECT
	 #Auxiliar.IdValor,
	 Bancos.Nombre as [Aux1],
	 Valores.IdBanco as [Aux2],
	 1 as [Aux3],
	 Valores.FechaValor as [Aux4],
	 0 as [Aux5],
	 Bancos.Nombre as [Banco],
	 Valores.NumeroInterno as [Nro.Int.],
	 Valores.NumeroValor as [Numero valor],
	 Valores.FechaValor as [Fecha valor],
	 Valores.Importe as [Importe],
	 Monedas.Abreviatura as [Mon.],
	 Valores.FechaComprobante as [Fec.Comp.],
	 tc1.DescripcionAb as [Tipo Comp.],
	 Valores.NumeroComprobante as [Comp.],
	 Proveedores.RazonSocial as [Proveedor],
	 #Auxiliar.Dias as [Dias],
	 Valores.Detalle as [Detalle],
	 OrdenesPago.Observaciones as [Observaciones],
	 '  |  |  |  |  |  |  |  |  |  |  |  ' as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
	LEFT OUTER JOIN TiposComprobante tc1 ON Valores.IdTipoComprobante=tc1.IdTipoComprobante
	LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
	LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
	LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago=OrdenesPago.IdOrdenPago
	LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
	
	UNION ALL
	
	SELECT
	 0,
	 Bancos.Nombre as [Aux1],
	 Valores.IdBanco as [Aux2],
	 1 as [Aux3],
	 Valores.FechaValor as [Aux4],
	 1 as [Aux5],
	 IsNull(Bancos.Nombre+' - ','')+'TOTAL '+Convert(varchar,Valores.FechaValor,103) as [Banco],
	 Null as [Nro.Int.],
	 Null as [Numero valor],
	 Valores.FechaValor as [Fecha valor],
	 SUM(Valores.Importe) as [Importe],
	 Null as [Mon.],
	 Null as [Fec.Comp.],
	 Null as [Tipo Comp.],
	 Null as [Comp.],
	 Null as [Proveedor],
	 Null as [Dias],
	 Null as [Detalle],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	GROUP BY Bancos.Nombre, Valores.IdBanco, Valores.FechaValor
	
	UNION ALL
	
	SELECT
	 0,
	 Bancos.Nombre as [Aux1],
	 Valores.IdBanco as [Aux2],
	 1 as [Aux3],
	 dateadd(d,-1,Dateadd(m,1,Convert(datetime,'01/'+Convert(varchar,#Auxiliar.Mes)+'/'+Convert(varchar,#Auxiliar.Año),103))),
	 2 as [Aux5],
	 IsNull(Bancos.Nombre+' - ','')+'TOTAL MES '+Convert(varchar,#Auxiliar.Mes)+'/'+
		Convert(varchar,#Auxiliar.Año) as [Banco],
	 Null as [Nro.Int.],
	 Null as [Numero valor],
	 Null as [Fecha valor],
	 SUM(Valores.Importe) as [Importe],
	 Null as [Mon.],
	 Null as [Fec.Comp.],
	 Null as [Tipo Comp.],
	 Null as [Comp.],
	 Null as [Proveedor],
	 Null as [Dias],
	 Null as [Detalle],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	GROUP BY Bancos.Nombre, Valores.IdBanco, #Auxiliar.Mes, #Auxiliar.Año
	
	UNION ALL
	
	SELECT
	 0,
	 Bancos.Nombre as [Aux1],
	 Valores.IdBanco as [Aux2],
	 1 as [Aux3],
	 dateadd(d,-1,Dateadd(m,1,Convert(datetime,'01/'+Convert(varchar,#Auxiliar.Mes)+'/'+Convert(varchar,#Auxiliar.Año),103))),
	 3 as [Aux5],
	 Null as [Banco],
	 Null as [Nro.Int.],
	 Null as [Numero valor],
	 Null as [Fecha valor],
	 Null as [Importe],
	 Null as [Mon.],
	 Null as [Fec.Comp.],
	 Null as [Tipo Comp.],
	 Null as [Comp.],
	 Null as [Proveedor],
	 Null as [Dias],
	 Null as [Detalle],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	GROUP BY Bancos.Nombre, Valores.IdBanco, #Auxiliar.Mes, #Auxiliar.Año
	
	UNION ALL
	
	SELECT
	 0,
	 Bancos.Nombre as [Aux1],
	 Valores.IdBanco as [Aux2],
	 3 as [Aux3],
	 0 as [Aux4],
	 0 as [Aux5],
	 'TOTAL BANCO' as [Banco],
	 Null as [Nro.Int.],
	 Null as [Numero valor],
	 Null as [Fecha valor],
	 SUM(Valores.Importe) as [Importe],
	 Null as [Mon.],
	 Null as [Fec.Comp.],
	 Null as [Tipo Comp.],
	 Null as [Comp.],
	 Null as [Proveedor],
	 Null as [Dias],
	 Null as [Detalle],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	GROUP BY Bancos.Nombre, Valores.IdBanco
	
	UNION ALL
	
	SELECT
	 0,
	 Bancos.Nombre as [Aux1],
	 Valores.IdBanco as [Aux2],
	 4 as [Aux3],
	 0 as [Aux4],
	 0 as [Aux5],
	 Null as [Banco],
	 Null as [Nro.Int.],
	 Null as [Numero valor],
	 Null as [Fecha valor],
	 Null as [Importe],
	 Null as [Mon.],
	 Null as [Fec.Comp.],
	 Null as [Tipo Comp.],
	 Null as [Comp.],
	 Null as [Proveedor],
	 Null as [Dias],
	 Null as [Detalle],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	GROUP BY Bancos.Nombre, Valores.IdBanco
	
	UNION ALL
	
	SELECT
	 0,
	 'zzzzz' as [Aux1],
	 0 as [Aux2],
	 5 as [Aux3],
	 0 as [Aux4],
	 0 as [Aux5],
	 'TOTAL GENERAL' as [Banco],
	 Null as [Nro.Int.],
	 Null as [Numero valor],
	 Null as [Fecha valor],
	 SUM(Valores.Importe) as [Importe],
	 Null as [Mon.],
	 Null as [Fec.Comp.],
	 Null as [Tipo Comp.],
	 Null as [Comp.],
	 Null as [Proveedor],
	 Null as [Dias],
	 Null as [Detalle],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	
	ORDER BY [Aux1], [Aux3], [Aux4], [Aux5], [Comp.]
   END

DROP TABLE #Auxiliar