CREATE PROCEDURE [dbo].[Recibos_TX_Comisiones]

@Desde datetime,
@Hasta datetime,
@IdVendedor int,
@IdVendedorMultizona int = Null

AS

SET NOCOUNT ON

SET @IdVendedorMultizona=IsNull(@IdVendedorMultizona,-1)

DECLARE @IdTipoComprobanteFacturaVenta INTEGER, @IdTipoComprobanteDevoluciones INTEGER, @IdTipoComprobanteNotaDebito INTEGER, @IdTipoComprobanteNotaCredito INTEGER, 
	@IdTipoComprobanteRecibo INTEGER, @IdTipoComprobanteDocumento INTEGER, @IvaLocal NUMERIC(18,2), @IvaRemoto NUMERIC(18,2), @DiasDemoraPago NUMERIC(18,2), 
	@ConsolidacionDeBDs VARCHAR(2), @NombreServidorWeb VARCHAR(100), @UsuarioServidorWeb VARCHAR(50), @PasswordServidorWeb VARCHAR(50), @BaseDeDatosServidorWeb VARCHAR(50), 
	@sql1 NVARCHAR(4000), @sql2 NVARCHAR(4000), @Corte1 INTEGER, @Corte2 INTEGER, @Orden INTEGER, @Origen INTEGER, @IdRecibo INTEGER, @IdDetalleRecibo INTEGER, 
	@IdDetalleReciboValores INTEGER, @FechaBase1 DATETIME, @FechaBase2 DATETIME, @FechaRecibo DATETIME, @Dias1 NUMERIC(18,2), @Dias2 NUMERIC(18,2), @Calculo1 NUMERIC(18,2), 
	@Calculo2 NUMERIC(18,2), @Calculo3 NUMERIC(18,2), @Calculo4 NUMERIC(18,2), @Calculo5 NUMERIC(18,2), @Importe NUMERIC(18,2), @IdAux INTEGER, @IdsVendedoresAsignados VARCHAR(1000), 
	@ImportePagadoComprobante NUMERIC(18,2)

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDocumento=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoComprobanteDocumento'),0)
SET @IvaLocal=IsNull((Select Top 1 Iva1 From Parametros Where IdParametro=1),0)

SET @IdsVendedoresAsignados=''
IF @IdVendedorMultizona>0
	SET @IdsVendedoresAsignados=IsNull((Select Top 1 IdsVendedoresAsignados From Vendedores Where IdVendedor=@IdVendedorMultizona),'')

CREATE TABLE #Auxiliar1 (Origen INTEGER, IdDetalleRecibo INTEGER, IdRecibo INTEGER, Importe NUMERIC(18, 2), Procesado VARCHAR(1))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (Origen, IdDetalleRecibo) ON [PRIMARY]

CREATE TABLE #Auxiliar2 (Origen INTEGER, IdDetalleReciboValores INTEGER, IdRecibo INTEGER, Importe NUMERIC(18, 2), Procesado VARCHAR(1))
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (Origen, IdDetalleReciboValores) ON [PRIMARY]

CREATE TABLE #Auxiliar3 (IdAux INTEGER IDENTITY (1, 1), Origen INTEGER, IdRecibo INTEGER, Fecha DATETIME, Orden INTEGER, IdDetalleRecibo INTEGER, IdDetalleReciboValores INTEGER,
						 FechaValores DATETIME, IdCliente INTEGER, NumeroRecibo VARCHAR(15))
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdAux) ON [PRIMARY]

CREATE TABLE #Auxiliar4 (Origen INTEGER, IdRecibo INTEGER, FechaRecibo DATETIME, FechaBaseImputaciones DATETIME, DiasImputaciones NUMERIC(18,2), 
						 FechaImputaciones DATETIME, FechaBaseValores DATETIME, DiasValores NUMERIC(18,2), FechaValores DATETIME)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (Origen, IdRecibo) ON [PRIMARY]

CREATE TABLE #Auxiliar5 (IdAux INTEGER, IdCliente INTEGER, NumeroRecibo VARCHAR(15), FechaRecibo DATETIME, IdMoneda INTEGER, TipoComprobante VARCHAR(5), Comprobante VARCHAR(15), 
						 FechaComprobante DATETIME, FechaVencimientoComprobante DATETIME, ImportePagadoComprobante NUMERIC(18,2), TipoValor VARCHAR(5), NumeroInternoValor INTEGER, 
						 NumeroValor NUMERIC(18,0), FechaVencimientoValor DATETIME, IdBanco INTEGER, IdCaja INTEGER, ImporteValor NUMERIC(18,2), IdVendedor INTEGER, BaseComision NUMERIC(18,2), 
						 PorcentajeComision NUMERIC(6,2), ImporteComision NUMERIC(18,2), ValorPorFecha NUMERIC(18,2))
CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdAux) ON [PRIMARY]

CREATE TABLE #Auxiliar9 (Fecha DATETIME, Importe NUMERIC(18, 2))


IF LEN(@NombreServidorWeb)>0
   BEGIN
	TRUNCATE TABLE #Auxiliar9
	SET @sql1='Select Null, IsNull(a.Iva1,0) 
			From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Parametros a
			Where a.IdParametro=1'
	INSERT INTO #Auxiliar9 EXEC sp_executesql @sql1
	SET @IvaRemoto=IsNull((Select Top 1 Importe From #Auxiliar9),0)

	SET @sql1='Select 1, a.IdDetalleRecibo, a.IdRecibo, a.Importe, '+''''+''+''''+' 
			From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibos a
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Recibos b On b.IdRecibo=a.IdRecibo
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Vendedores v On v.IdVendedor=b.IdVendedor
			Where b.FechaRecibo between Convert(datetime,'+''''+Convert(varchar,@Desde,103)+''''+') and Convert(datetime,'+''''+Convert(varchar,@Hasta,103)+''''+') and IsNull(b.Anulado,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and b.Tipo='+''''+'CC'+''''+' and 
				('+Convert(varchar,@IdVendedor)+'=-1 or b.IdVendedor='+Convert(varchar,@IdVendedor)+' or ('+Convert(varchar,@IdVendedorMultizona)+'>0 and Patindex('+''''+'%('+''''+'+Convert(varchar,b.IdVendedor)+'+''''+')%'+''''+', '+''''+@IdsVendedoresAsignados+''''+')<>0)) and 
				(IsNull(v.EmiteComision,'+''''+'NO'+''''+')='+''''+'SI'+''''+' or '+Convert(varchar,@IdVendedorMultizona)+'>0)'
 	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

	SET @sql1='Select 1, a.IdDetalleReciboValores, a.IdRecibo, a.Importe, '+''''+''+''''+' 
			From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibosValores a
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Recibos b On b.IdRecibo=a.IdRecibo
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Vendedores v On v.IdVendedor=b.IdVendedor
			Where b.FechaRecibo between Convert(datetime,'+''''+Convert(varchar,@Desde,103)+''''+') and Convert(datetime,'+''''+Convert(varchar,@Hasta,103)+''''+') and IsNull(b.Anulado,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and b.Tipo='+''''+'CC'+''''+' and 
				('+Convert(varchar,@IdVendedor)+'=-1 or b.IdVendedor='+Convert(varchar,@IdVendedor)+' or ('+Convert(varchar,@IdVendedorMultizona)+'>0 and Patindex('+''''+'%('+''''+'+Convert(varchar,b.IdVendedor)+'+''''+')%'+''''+', '+''''+@IdsVendedoresAsignados+''''+')<>0)) and 
				(IsNull(v.EmiteComision,'+''''+'NO'+''''+')='+''''+'SI'+''''+' or '+Convert(varchar,@IdVendedorMultizona)+'>0)'
	INSERT INTO #Auxiliar2 EXEC sp_executesql @sql1

	SET @sql1='Select 1, b.IdRecibo, b.FechaRecibo, Null, Null, Null, Null, Null, Null 
			From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Recibos b 
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Vendedores v On v.IdVendedor=b.IdVendedor
			Where b.FechaRecibo between Convert(datetime,'+''''+Convert(varchar,@Desde,103)+''''+') and Convert(datetime,'+''''+Convert(varchar,@Hasta,103)+''''+') and IsNull(b.Anulado,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and b.Tipo='+''''+'CC'+''''+' and 
				('+Convert(varchar,@IdVendedor)+'=-1 or b.IdVendedor='+Convert(varchar,@IdVendedor)+' or ('+Convert(varchar,@IdVendedorMultizona)+'>0 and Patindex('+''''+'%('+''''+'+Convert(varchar,b.IdVendedor)+'+''''+')%'+''''+', '+''''+@IdsVendedoresAsignados+''''+')<>0)) and 
				(IsNull(v.EmiteComision,'+''''+'NO'+''''+')='+''''+'SI'+''''+' or '+Convert(varchar,@IdVendedorMultizona)+'>0)'
	INSERT INTO #Auxiliar4 EXEC sp_executesql @sql1
   END

INSERT INTO #Auxiliar1 
 SELECT 2, a.IdDetalleRecibo, a.IdRecibo, a.Importe, ''
 FROM DetalleRecibos a
 LEFT OUTER JOIN Recibos b ON b.IdRecibo=a.IdRecibo
 LEFT OUTER JOIN Vendedores v ON v.IdVendedor=b.IdVendedor
 WHERE b.FechaRecibo between @Desde and @hasta and IsNull(b.Anulado,'NO')<>'SI' and b.Tipo='CC' and 
	(@IdVendedor=-1 or b.IdVendedor=@IdVendedor or (@IdVendedorMultizona>0 and Patindex('%('+Convert(varchar,b.IdVendedor)+')%', @IdsVendedoresAsignados)<>0)) and 
	(IsNull(v.EmiteComision,'NO')='SI' or @IdVendedorMultizona>0)

INSERT INTO #Auxiliar2 
 SELECT 2, a.IdDetalleReciboValores, a.IdRecibo, a.Importe, ''
 FROM DetalleRecibosValores a 
 LEFT OUTER JOIN Recibos b ON b.IdRecibo=a.IdRecibo
 LEFT OUTER JOIN Vendedores v ON v.IdVendedor=b.IdVendedor
 WHERE b.FechaRecibo between @Desde and @hasta and IsNull(b.Anulado,'NO')<>'SI' and b.Tipo='CC' and 
	(@IdVendedor=-1 or b.IdVendedor=@IdVendedor or (@IdVendedorMultizona>0 and Patindex('%('+Convert(varchar,b.IdVendedor)+')%', @IdsVendedoresAsignados)<>0)) and 
	(IsNull(v.EmiteComision,'NO')='SI' or @IdVendedorMultizona>0)

INSERT INTO #Auxiliar4 
 SELECT 2, b.IdRecibo, b.FechaRecibo, Null, Null, Null, Null, Null, Null
 FROM Recibos b
 LEFT OUTER JOIN Vendedores v ON v.IdVendedor=b.IdVendedor
 WHERE b.FechaRecibo between @Desde and @hasta and IsNull(b.Anulado,'NO')<>'SI' and b.Tipo='CC' and 
	(@IdVendedor=-1 or b.IdVendedor=@IdVendedor or (@IdVendedorMultizona>0 and Patindex('%('+Convert(varchar,b.IdVendedor)+')%', @IdsVendedoresAsignados)<>0)) and 
	(IsNull(v.EmiteComision,'NO')='SI' or @IdVendedorMultizona>0)


SET @Corte1=0
SET @Corte2=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Origen, IdDetalleRecibo, IdRecibo FROM #Auxiliar1 ORDER BY Origen, IdDetalleRecibo
OPEN Cur
FETCH NEXT FROM Cur INTO @Origen, @IdDetalleRecibo, @IdRecibo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte1<>@Origen or @Corte2<>@IdRecibo
	   BEGIN
		SET @Corte1=@Origen
		SET @Corte2=@IdRecibo
		SET @Orden=1
	   END

	SET @IdDetalleReciboValores=IsNull((Select Top 1 IdDetalleReciboValores From #Auxiliar2 Where Origen=@Origen and IdRecibo=@IdRecibo and Procesado=''),0)

	INSERT INTO #Auxiliar3 
	(Origen, IdRecibo, Orden, IdDetalleRecibo, IdDetalleReciboValores)
	VALUES
	(@Origen, @IdRecibo, @Orden, @IdDetalleRecibo, @IdDetalleReciboValores)

	IF @IdDetalleReciboValores>0
		UPDATE #Auxiliar2 SET Procesado='*' WHERE Origen=@Origen and IdDetalleReciboValores=@IdDetalleReciboValores
	UPDATE #Auxiliar1
	SET Procesado='*'
	WHERE CURRENT OF Cur

	SET @Orden=@Orden+1
	FETCH NEXT FROM Cur INTO @Origen, @IdDetalleRecibo, @IdRecibo
   END
CLOSE Cur
DEALLOCATE Cur

SET @Corte1=0
SET @Corte2=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Origen, IdDetalleReciboValores, IdRecibo FROM #Auxiliar2 WHERE Procesado='' ORDER BY Origen, IdDetalleReciboValores
OPEN Cur
FETCH NEXT FROM Cur INTO @Origen, @IdDetalleReciboValores, @IdRecibo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte1<>@Origen or @Corte2<>@IdRecibo
	   BEGIN
		SET @Corte1=@Origen
		SET @Corte2=@IdRecibo
		SET @Orden=IsNull((Select Top 1 Orden From #Auxiliar3 Where Origen=@Origen and IdRecibo=@IdRecibo Order By Origen, IdRecibo, Orden Desc),0) + 1
	   END

	INSERT INTO #Auxiliar3 
	(Origen, IdRecibo, Orden, IdDetalleRecibo, IdDetalleReciboValores)
	VALUES
	(@Origen, @IdRecibo, @Orden, 0, @IdDetalleReciboValores)

	UPDATE #Auxiliar2
	SET Procesado='*'
	WHERE CURRENT OF Cur

	SET @Orden=@Orden+1
	FETCH NEXT FROM Cur INTO @Origen, @IdDetalleReciboValores, @IdRecibo
   END
CLOSE Cur
DEALLOCATE Cur

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdAux, Origen, IdRecibo, IdDetalleRecibo, IdDetalleReciboValores FROM #Auxiliar3 WHERE Origen=1 ORDER BY IdAux
OPEN Cur
FETCH NEXT FROM Cur INTO @IdAux, @Origen, @IdRecibo, @IdDetalleRecibo, @IdDetalleReciboValores
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @sql1='Select 
				'+Convert(varchar,@IdAux)+', 
				r.IdCliente, 
				Substring('+''''+'0000'+''''+',1,4-Len(Convert(varchar,r.PuntoVenta)))+Convert(varchar,r.PuntoVenta)+'+''''+'-'+''''+'+Substring('+''''+'00000000'+''''+',1,8-Len(Convert(varchar,r.NumeroRecibo)))+Convert(varchar,r.NumeroRecibo),
				r.FechaRecibo,
				r.IdMoneda,
				Case When dr.IdImputacion=-1 Then '+''''+'PA'+''''+' Else Substring(IsNull(t1.DescripcionAB,'+''''+''+''''+'),1,5) End,
				Case When fa.NumeroFactura is not null
						Then fa.TipoABC+'+''''+'-'+''''+'+Substring('+''''+'0000'+''''+',1,4-Len(Convert(varchar,fa.PuntoVenta)))+Convert(varchar,fa.PuntoVenta)+'+''''+'-'+''''+'+Substring('+''''+'00000000'+''''+',1,8-Len(Convert(varchar,fa.NumeroFactura)))+Convert(varchar,fa.NumeroFactura)
					When dv.NumeroDevolucion is not null
						Then dv.TipoABC+'+''''+'-'+''''+'+Substring('+''''+'0000'+''''+',1,4-Len(Convert(varchar,dv.PuntoVenta)))+Convert(varchar,dv.PuntoVenta)+'+''''+'-'+''''+'+Substring('+''''+'00000000'+''''+',1,8-Len(Convert(varchar,dv.NumeroDevolucion)))+Convert(varchar,dv.NumeroDevolucion)
					When nd.NumeroNotaDebito is not null
						Then nd.TipoABC+'+''''+'-'+''''+'+Substring('+''''+'0000'+''''+',1,4-Len(Convert(varchar,nd.PuntoVenta)))+Convert(varchar,nd.PuntoVenta)+'+''''+'-'+''''+'+Substring('+''''+'00000000'+''''+',1,8-Len(Convert(varchar,nd.NumeroNotaDebito)))+Convert(varchar,nd.NumeroNotaDebito)
					When nc.NumeroNotaCredito is not null
						Then nc.TipoABC+'+''''+'-'+''''+'+Substring('+''''+'0000'+''''+',1,4-Len(Convert(varchar,nc.PuntoVenta)))+Convert(varchar,nc.PuntoVenta)+'+''''+'-'+''''+'+Substring('+''''+'00000000'+''''+',1,8-Len(Convert(varchar,nc.NumeroNotaCredito)))+Convert(varchar,nc.NumeroNotaCredito)
					Else Substring('+''''+'00000000'+''''+',1,8-Len(Convert(varchar,cc.NumeroComprobante)))+Convert(varchar,cc.NumeroComprobante)
				End,
				cc.Fecha,
				IsNull(cc.FechaVencimiento,cc.Fecha),
				dr.Importe * IsNull(r.CotizacionMoneda,1),
				Substring(IsNull(t2.DescripcionAB,'+''''+''+''''+'),1,5),
				drv.NumeroInterno,
				drv.NumeroValor,
				IsNull(drv.FechaVencimiento,r.FechaRecibo),
				drv.IdBanco,
				drv.IdCaja,
				drv.Importe * IsNull(r.CotizacionMoneda,1),
				r.IdVendedor,
				Case When fa.NumeroFactura is not null
						Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
							((fa.ImporteTotal-fa.ImporteIva1-fa.ImporteIva2-fa.RetencionIBrutos1-fa.RetencionIBrutos2-fa.RetencionIBrutos3-IsNull(fa.PercepcionIVA,0)-IsNull(fa.OtrasPercepciones1,0)-IsNull(fa.OtrasPercepciones2,0)-IsNull(fa.OtrasPercepciones3,0)) / 
								Case When fa.TipoABC='+''''+'B'+''''+' and IsNull(fa.IdCodigoIva,1)<>8 and fa.PorcentajeIva1<>0 Then (1+(fa.PorcentajeIva1/100)) Else 1 End * fa.CotizacionMoneda) / (fa.ImporteTotal * fa.CotizacionMoneda)
					When dv.NumeroDevolucion is not null
						Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
							((dv.ImporteTotal-dv.ImporteIva1-dv.ImporteIva2-dv.RetencionIBrutos1-dv.RetencionIBrutos2-dv.RetencionIBrutos3-IsNull(dv.PercepcionIVA,0)-IsNull(dv.OtrasPercepciones1,0)-IsNull(dv.OtrasPercepciones2,0)) / 
								Case When dv.TipoABC='+''''+'B'+''''+' and IsNull(dv.IdCodigoIva,1)<>8 and dv.PorcentajeIva1<>0 Then (1+(dv.PorcentajeIva1/100)) Else 1 End * dv.CotizacionMoneda) / (dv.ImporteTotal * dv.CotizacionMoneda)
					When nd.NumeroNotaDebito is not null
						 Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
							IsNull((Select Sum(IsNull(dnd.Importe,0) - IsNull(dnd.IvaNoDiscriminado,0)) 
									From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleNotasDebito dnd 
									Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Conceptos c On c.IdConcepto=dnd.IdConcepto
									Where dnd.IdNotaDebito=nd.IdNotaDebito and IsNull(c.GeneraComision,'+''''+''+''''+')='+''''+'SI'+''''+'),0)  * nd.CotizacionMoneda / (nd.ImporteTotal * nd.CotizacionMoneda)'
	SET @sql2='		When nc.NumeroNotaCredito is not null
						 Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
							IsNull((Select Sum(IsNull(dnc.Importe,0) - IsNull(dnc.IvaNoDiscriminado,0)) 
									From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleNotasCredito dnc 
									Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Conceptos c On c.IdConcepto=dnc.IdConcepto
									Where dnc.IdNotaCredito=nc.IdNotaCredito and IsNull(c.GeneraComision,'+''''+''+''''+')='+''''+'SI'+''''+'),0)  * nc.CotizacionMoneda / (nc.ImporteTotal * nc.CotizacionMoneda) 
					When cc.IdTipoComp='+Convert(varchar,@IdTipoComprobanteDocumento)+' Then (dr.Importe * IsNull(r.CotizacionMoneda,1))
					When dr.IdDetalleRecibo is null Then Null
					Else Case When '+Convert(varchar,@IvaRemoto)+'<>0 Then Round(dr.Importe * IsNull(r.CotizacionMoneda,1) / (1+('+Convert(varchar,@IvaRemoto)+'/100)),2) Else (dr.Importe * IsNull(r.CotizacionMoneda,1)) End
				End,
				Case When '+Convert(varchar,@IdVendedorMultizona)+'>0 Then IsNull(v.Comision,0)
					When dr.IdDetalleRecibo is null Then Null
					When IsNull(fa.ComisionDiferenciada,0)<>0 Then fa.ComisionDiferenciada
					When IsNull(cl.ComisionDiferenciada,0)<>0 Then cl.ComisionDiferenciada
					Else IsNull(v.Comision,0)
				End,
				0, 
				0
			From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Recibos r
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibos dr On dr.IdDetalleRecibo='+Convert(varchar,@IdDetalleRecibo)+'
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibosValores drv On drv.IdDetalleReciboValores='+Convert(varchar,@IdDetalleReciboValores)+'
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.CuentasCorrientesDeudores cc On cc.IdCtaCte=dr.IdImputacion
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.TiposComprobante t1 On t1.IdTipoComprobante=cc.IdTipoComp
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Facturas fa ON fa.IdFactura=cc.IdComprobante and cc.IdTipoComp='+Convert(varchar,@IdTipoComprobanteFacturaVenta)+'
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Devoluciones dv ON dv.IdDevolucion=cc.IdComprobante and cc.IdTipoComp='+Convert(varchar,@IdTipoComprobanteDevoluciones)+'
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.NotasDebito nd ON nd.IdNotaDebito=cc.IdComprobante and cc.IdTipoComp='+Convert(varchar,@IdTipoComprobanteNotaDebito)+'
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.NotasCredito nc ON nc.IdNotaCredito=cc.IdComprobante and cc.IdTipoComp='+Convert(varchar,@IdTipoComprobanteNotaCredito)+'
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.TiposComprobante t2 ON t2.IdTipoComprobante=drv.IdTipoValor
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Vendedores v ON v.IdVendedor=Case When '+Convert(varchar,@IdVendedorMultizona)+'>0 Then '+Convert(varchar,@IdVendedorMultizona)+' Else r.IdVendedor End
			Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.Clientes cl ON cl.IdCliente=r.IdCliente
			Where r.IdRecibo='+Convert(varchar,@IdRecibo)
/*
print len(@sql1)
print len(@sql2)
print @sql1
print @sql2
*/
	INSERT INTO #Auxiliar5 EXEC (@sql1 + @sql2)

	FETCH NEXT FROM Cur INTO @IdAux, @Origen, @IdRecibo, @IdDetalleRecibo, @IdDetalleReciboValores
   END
CLOSE Cur
DEALLOCATE Cur

INSERT INTO #Auxiliar5 
 SELECT 
  a.IdAux, 
  r.IdCliente, 
  Substring('0000',1,4-Len(Convert(varchar,r.PuntoVenta)))+Convert(varchar,r.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,r.NumeroRecibo)))+Convert(varchar,r.NumeroRecibo),
  r.FechaRecibo,
  r.IdMoneda,
  Case When dr.IdImputacion=-1 Then 'PA' Else Substring(IsNull(t1.DescripcionAB,''),1,5) End,
  Case When fa.NumeroFactura is not null
	 Then fa.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,fa.PuntoVenta)))+Convert(varchar,fa.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,fa.NumeroFactura)))+Convert(varchar,fa.NumeroFactura)
	When dv.NumeroDevolucion is not null
	 Then dv.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,dv.PuntoVenta)))+Convert(varchar,dv.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,dv.NumeroDevolucion)))+Convert(varchar,dv.NumeroDevolucion)
	When nd.NumeroNotaDebito is not null
	 Then nd.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,nd.PuntoVenta)))+Convert(varchar,nd.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,nd.NumeroNotaDebito)))+Convert(varchar,nd.NumeroNotaDebito)
	When nc.NumeroNotaCredito is not null
	 Then nc.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,nc.PuntoVenta)))+Convert(varchar,nc.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,nc.NumeroNotaCredito)))+Convert(varchar,nc.NumeroNotaCredito)
	Else Substring('00000000',1,8-Len(Convert(varchar,cc.NumeroComprobante)))+Convert(varchar,cc.NumeroComprobante)
  End,
  cc.Fecha,
  IsNull(cc.FechaVencimiento,cc.Fecha),
  dr.Importe * IsNull(r.CotizacionMoneda,1),
  Substring(IsNull(t2.DescripcionAB,''),1,5),
  drv.NumeroInterno,
  drv.NumeroValor,
  IsNull(drv.FechaVencimiento,r.FechaRecibo),
  drv.IdBanco,
  drv.IdCaja,
  drv.Importe * IsNull(r.CotizacionMoneda,1),
  r.IdVendedor,
  Case When fa.NumeroFactura is not null
			Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
				((fa.ImporteTotal-fa.ImporteIva1-fa.ImporteIva2-fa.RetencionIBrutos1-fa.RetencionIBrutos2-fa.RetencionIBrutos3-IsNull(fa.PercepcionIVA,0)-IsNull(fa.OtrasPercepciones1,0)-IsNull(fa.OtrasPercepciones2,0)-IsNull(fa.OtrasPercepciones3,0)) / 
				Case When fa.TipoABC='B' and IsNull(fa.IdCodigoIva,1)<>8 and fa.PorcentajeIva1<>0 Then (1+(fa.PorcentajeIva1/100)) Else 1 End * fa.CotizacionMoneda) / (fa.ImporteTotal * fa.CotizacionMoneda)
		When dv.NumeroDevolucion is not null
			Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
				((dv.ImporteTotal-dv.ImporteIva1-dv.ImporteIva2-dv.RetencionIBrutos1-dv.RetencionIBrutos2-dv.RetencionIBrutos3-IsNull(dv.PercepcionIVA,0)-IsNull(dv.OtrasPercepciones1,0)-IsNull(dv.OtrasPercepciones2,0)) / 
				Case When dv.TipoABC='B' and IsNull(dv.IdCodigoIva,1)<>8 and dv.PorcentajeIva1<>0 Then (1+(dv.PorcentajeIva1/100)) Else 1 End * dv.CotizacionMoneda) / (dv.ImporteTotal * dv.CotizacionMoneda)
		When nd.NumeroNotaDebito is not null
			 Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
				IsNull((Select Sum(IsNull(dnd.Importe,0) - IsNull(dnd.IvaNoDiscriminado,0)) 
						From DetalleNotasDebito dnd 
						Left Outer Join Conceptos c On c.IdConcepto=dnd.IdConcepto
						Where dnd.IdNotaDebito=nd.IdNotaDebito and IsNull(c.GeneraComision,'')='SI'),0)  * nd.CotizacionMoneda / (nd.ImporteTotal * nd.CotizacionMoneda)
		When nc.NumeroNotaCredito is not null
			 Then (dr.Importe * IsNull(r.CotizacionMoneda,1)) * 
				IsNull((Select Sum(IsNull(dnc.Importe,0) - IsNull(dnc.IvaNoDiscriminado,0)) 
						From DetalleNotasCredito dnc 
						Left Outer Join Conceptos c On c.IdConcepto=dnc.IdConcepto
						Where dnc.IdNotaCredito=nc.IdNotaCredito and IsNull(c.GeneraComision,'')='SI'),0)  * nc.CotizacionMoneda / (nc.ImporteTotal * nc.CotizacionMoneda)
		When cc.IdTipoComp=@IdTipoComprobanteDocumento Then (dr.Importe * IsNull(r.CotizacionMoneda,1))
		When dr.IdDetalleRecibo is null Then Null
		Else Case When @IvaLocal<>0 Then Round(dr.Importe * IsNull(r.CotizacionMoneda,1) / (1+(@IvaLocal/100)),2) Else (dr.Importe * IsNull(r.CotizacionMoneda,1)) End
  End,
  Case When @IdVendedorMultizona>0 Then IsNull(v.Comision,0)
	When dr.IdDetalleRecibo is null Then Null
	When IsNull(fa.ComisionDiferenciada,0)<>0 Then fa.ComisionDiferenciada
	When IsNull(cl.ComisionDiferenciada,0)<>0 Then cl.ComisionDiferenciada
	Else IsNull(v.Comision,0)
  End,
  0,
  0
 FROM #Auxiliar3 a
 LEFT OUTER JOIN DetalleRecibos dr ON dr.IdDetalleRecibo=a.IdDetalleRecibo
 LEFT OUTER JOIN DetalleRecibosValores drv ON drv.IdDetalleReciboValores=a.IdDetalleReciboValores
 LEFT OUTER JOIN Recibos r ON r.IdRecibo=a.IdRecibo
 LEFT OUTER JOIN CuentasCorrientesDeudores cc ON cc.IdCtaCte=dr.IdImputacion
 LEFT OUTER JOIN TiposComprobante t1 ON t1.IdTipoComprobante=cc.IdTipoComp
 LEFT OUTER JOIN Facturas fa ON fa.IdFactura=cc.IdComprobante and cc.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones dv ON dv.IdDevolucion=cc.IdComprobante and cc.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito nd ON nd.IdNotaDebito=cc.IdComprobante and cc.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito nc ON nc.IdNotaCredito=cc.IdComprobante and cc.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN TiposComprobante t2 ON t2.IdTipoComprobante=drv.IdTipoValor
 LEFT OUTER JOIN Vendedores v ON v.IdVendedor=Case When @IdVendedorMultizona>0 Then @IdVendedorMultizona Else r.IdVendedor End
 LEFT OUTER JOIN Clientes cl ON cl.IdCliente=r.IdCliente
 WHERE a.Origen=2

UPDATE #Auxiliar5
SET ImporteComision=Round(BaseComision*PorcentajeComision/100,2), ValorPorFecha=IsNull(ImporteValor,0)*IsNull(Convert(int,FechaVencimientoValor),0)

SET @ImportePagadoComprobante=IsNull((Select Sum(IsNull(ImportePagadoComprobante,0)) From #Auxiliar5),0)

SET @DiasDemoraPago=0
IF @ImportePagadoComprobante<>0
	SET @DiasDemoraPago=(IsNull((Select Sum(IsNull(ValorPorFecha,0)) From #Auxiliar5),0) / @ImportePagadoComprobante) - Convert(int,@Hasta)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Origen, IdRecibo, FechaRecibo FROM #Auxiliar4 ORDER BY Origen, IdRecibo
OPEN Cur
FETCH NEXT FROM Cur INTO @Origen, @IdRecibo, @FechaRecibo
WHILE @@FETCH_STATUS = 0
   BEGIN
	-- DETERMINAR FECHA PROMEDIO DE IMPUTACIONES Y FECHA PROMEDIO DE VALORES
	IF @Origen=1
	   BEGIN
		TRUNCATE TABLE #Auxiliar9
		SET @sql1='Select Min(IsNull(b.Fecha,Convert(datetime,'+''''+Convert(varchar,@FechaRecibo,103)+''''+'))), Null 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibos a
				Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.CuentasCorrientesDeudores b On b.IdCtaCte=a.IdImputacion
				Where a.IdRecibo='+Convert(varchar,@IdRecibo)
		INSERT INTO #Auxiliar9 EXEC sp_executesql @sql1
		SET @FechaBase1=IsNull((Select Top 1 Fecha From #Auxiliar9),0)

		TRUNCATE TABLE #Auxiliar9
		SET @sql1='Select Null, Sum(Convert(int,IsNull(b.Fecha,Convert(datetime,'+''''+Convert(varchar,@FechaRecibo,103)+''''+'))) * IsNull(a.Importe,0)) 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibos a
				Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.CuentasCorrientesDeudores b On b.IdCtaCte=a.IdImputacion
				Where a.IdRecibo='+Convert(varchar,@IdRecibo)
		INSERT INTO #Auxiliar9 EXEC sp_executesql @sql1
		SET @Calculo1=IsNull((Select Top 1 Importe From #Auxiliar9),0)

		TRUNCATE TABLE #Auxiliar9
		SET @sql1='Select Null, Sum(IsNull(a.Importe,0)) 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibos a
				Where a.IdRecibo='+Convert(varchar,@IdRecibo)
		INSERT INTO #Auxiliar9 EXEC sp_executesql @sql1
		SET @Calculo2=IsNull((Select Top 1 Importe From #Auxiliar9),0)

		TRUNCATE TABLE #Auxiliar9
		SET @sql1='Select Min(IsNull(a.FechaVencimiento,Convert(datetime,'+''''+Convert(varchar,@FechaRecibo,103)+''''+'))), Null 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibosValores a
				Where a.IdRecibo='+Convert(varchar,@IdRecibo)
		INSERT INTO #Auxiliar9 EXEC sp_executesql @sql1
		SET @FechaBase2=IsNull((Select Top 1 Fecha From #Auxiliar9),0)

		TRUNCATE TABLE #Auxiliar9
		SET @sql1='Select Null, Sum(Convert(int,IsNull(a.FechaVencimiento,Convert(datetime,'+''''+Convert(varchar,@FechaRecibo,103)+''''+'))) * IsNull(a.Importe,0)) 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibosValores a
				Where a.IdRecibo='+Convert(varchar,@IdRecibo)
		INSERT INTO #Auxiliar9 EXEC sp_executesql @sql1
		SET @Calculo3=IsNull((Select Top 1 Importe From #Auxiliar9),0)

		TRUNCATE TABLE #Auxiliar9
		SET @sql1='Select Null, Sum(IsNull(a.Importe,0)) 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetalleRecibosValores a
				Where a.IdRecibo='+Convert(varchar,@IdRecibo)
		INSERT INTO #Auxiliar9 EXEC sp_executesql @sql1
		SET @Calculo4=IsNull((Select Top 1 Importe From #Auxiliar9),0)
	   END
	ELSE
	   BEGIN
		SET @FechaBase1=(Select Min(IsNull(c.Fecha,@FechaRecibo)) From DetalleRecibos d Left Outer Join CuentasCorrientesDeudores c On c.IdCtaCte=d.IdImputacion Where d.IdRecibo=@IdRecibo)
		SET @Calculo1=IsNull((Select Sum(Convert(int,IsNull(c.Fecha,@FechaRecibo)) * IsNull(d.Importe,0)) From DetalleRecibos d Left Outer Join CuentasCorrientesDeudores c On c.IdCtaCte=d.IdImputacion Where d.IdRecibo=@IdRecibo),0)
		SET @Calculo2=IsNull((Select Sum(IsNull(d.Importe,0)) From DetalleRecibos d Where d.IdRecibo=@IdRecibo),0)

		SET @FechaBase2=(Select Min(IsNull(d.FechaVencimiento,@FechaRecibo)) From DetalleRecibosValores d Where d.IdRecibo=@IdRecibo)
		SET @Calculo3=IsNull((Select Sum(Convert(int,IsNull(d.FechaVencimiento,@FechaRecibo)) * IsNull(d.Importe,0)) From DetalleRecibosValores d Where d.IdRecibo=@IdRecibo),0)
		SET @Calculo4=IsNull((Select Sum(IsNull(d.Importe,0)) From DetalleRecibosValores d Where d.IdRecibo=@IdRecibo),0)
	   END

	IF @Calculo2>@Calculo4
		SET @Calculo3=@Calculo3+((@Calculo2-@Calculo4)*Convert(int,@FechaRecibo))

	IF @Calculo2<>0
		SET @Dias1=(@Calculo1/@Calculo2)-Convert(int,@FechaBase1)
	ELSE
		SET @Dias1=0

	IF @Calculo2<>0
		SET @Dias2=(@Calculo3/@Calculo2)-Convert(int,@Hasta)
	ELSE
		SET @Dias2=0

	IF @Dias1<-1000
		SET @Dias1=0

	IF @Dias2<-1000
		SET @Dias2=0

	UPDATE #Auxiliar4
	SET FechaBaseImputaciones=@FechaBase1, DiasImputaciones=@Dias1, FechaImputaciones=DateAdd(d,@Dias1,@FechaBase1), FechaBaseValores=@FechaBase2, DiasValores=@Dias2, FechaValores=DateAdd(d,@Dias2,@FechaBase2)
	WHERE CURRENT OF Cur

	FETCH NEXT FROM Cur INTO @Origen, @IdRecibo, @FechaRecibo
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF


DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='00000001111111111111111111111133'
SET @vector_T='0000000F0HH903035502755422352300'

SELECT
 a.IdAux as [IdAux0],
 v.CodigoVendedor as [IdAux1],
 v.Nombre as [IdAux2],
 a.Orden as [IdAux3],
 a5.NumeroRecibo as [IdAux4],
 a5.FechaRecibo as [IdAux5], 
 a.Origen as [IdAux6],

 a.Origen as [O],
 cl.CodigoCliente as [Cod.Cli.], 
 cl.RazonSocial as [Cliente],
 v.CodigoVendedor as [Ven],
 Null as [Pro.Impu.],
 Null as [Pro.Val.],
 a5.BaseComision as [Base Com.],
 a5.PorcentajeComision as [% Com.],
 a5.ImporteComision as [Comision],
 a5.NumeroRecibo as [Nro.Recibo],
 a5.FechaRecibo as [Fecha Recibo], 
 m.Abreviatura as [Mon.],

 a5.TipoComprobante as [Tipo Comp.],
 a5.Comprobante as [Comprobante],
 a5.FechaComprobante as [Fecha],
 a5.FechaVencimientoComprobante as [Fecha vto.],
 a5.ImportePagadoComprobante as [Imp. Imputacion],

 a5.TipoValor as [Tipo Valor],
 a5.NumeroInternoValor as [Nro.Int.],
 a5.NumeroValor as [Nro.Valor],
 a5.FechaVencimientoValor as [Fecha],
 Case When b.Nombre is not null Then b.Nombre When c.Descripcion is not null Then c.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS Else '' End as [Banco / Caja],
 a5.ImporteValor as [Imp.Valor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 a
LEFT OUTER JOIN #Auxiliar5 a5 ON a5.IdAux=a.IdAux
LEFT OUTER JOIN Bancos b ON b.IdBanco=a5.IdBanco
LEFT OUTER JOIN Cajas c ON c.IdCaja=a5.IdCaja
LEFT OUTER JOIN Clientes cl ON cl.IdCliente=a5.IdCliente
LEFT OUTER JOIN Monedas m ON m.IdMoneda=a5.IdMoneda
LEFT OUTER JOIN Vendedores v ON v.IdVendedor=a5.IdVendedor

UNION ALL

SELECT
 0 as [IdAux0],
 v.CodigoVendedor as [IdAux1],
 v.Nombre as [IdAux2],
 999999 as [IdAux3],
 a5.NumeroRecibo as [IdAux4],
 a5.FechaRecibo as [IdAux5], 
 a.Origen as [IdAux6],

 a.Origen as [O],
 cl.CodigoCliente as [Cod.Cli.], 
 cl.RazonSocial as [Cliente],
 v.CodigoVendedor as [Ven],
 a4.DiasImputaciones as [Pro.Impu.],
 a4.DiasValores as [Pro.Val.],
 Null as [Base Com.],
 Null as [% Com.],
 Null as [Comision], --Sum(IsNull(a5.ImporteComision,0)) as [Comision],
 a5.NumeroRecibo as [Nro.Recibo],
 a5.FechaRecibo as [Fecha Recibo], 
 m.Abreviatura as [Mon.],

 Null as [Tipo Comp.],
 Null as [Comprobante],
 Null as [Fecha],
 Null as [Fecha vto.],
 --Sum(IsNull(a5.ImportePagadoComprobante,0)) as [Imp. Imputacion],
 Null as [Imp. Imputacion],

 Null as [Tipo Valor],
 Null as [Nro.Int.],
 Null as [Nro.Valor],
 Null as [Fecha],
 Null as [Banco / Caja],
 --Sum(IsNull(a5.ImporteValor,0)) as [Imp.Valor],
 Null as [Imp.Valor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 a
LEFT OUTER JOIN #Auxiliar4 a4 ON a4.Origen=a.Origen and a4.IdRecibo=a.IdRecibo
LEFT OUTER JOIN #Auxiliar5 a5 ON a5.IdAux=a.IdAux
LEFT OUTER JOIN Bancos b ON b.IdBanco=a5.IdBanco
LEFT OUTER JOIN Cajas c ON c.IdCaja=a5.IdCaja
LEFT OUTER JOIN Clientes cl ON cl.IdCliente=a5.IdCliente
LEFT OUTER JOIN Monedas m ON m.IdMoneda=a5.IdMoneda
LEFT OUTER JOIN Vendedores v ON v.IdVendedor=a5.IdVendedor
GROUP BY a.IdRecibo, v.CodigoVendedor, v.Nombre, a5.NumeroRecibo, a5.FechaRecibo, a.Origen, cl.CodigoCliente, cl.RazonSocial, a4.DiasImputaciones, a4.DiasValores, m.Abreviatura

UNION ALL

SELECT
 0 as [IdAux0],
 999999 as [IdAux1],
 Null as [IdAux2],
 999999 as [IdAux3],
 Null as [IdAux4],
 Null as [IdAux5], 
 9 as [IdAux6],

 9 as [O],
 Null as [Cod.Cli.], 
 Null as [Cliente],
 Null as [Ven],
 Null as [Pro.Impu.],
 @DiasDemoraPago as [Pro.Val.],
 Null as [Base Com.],
 Null as [% Com.],
 Sum(IsNull(a5.ImporteComision,0)) as [Comision],
 Null as [Nro.Recibo],
 Null as [Fecha Recibo], 
 Null as [Mon.],

 Null as [Tipo Comp.],
 Null as [Comprobante],
 Null as [Fecha],
 Null as [Fecha vto.],
 Sum(IsNull(a5.ImportePagadoComprobante,0)) as [Imp. Imputacion],

 Null as [Tipo Valor],
 Null as [Nro.Int.],
 Null as [Nro.Valor],
 Null as [Fecha],
 Null as [Banco / Caja],
 --Sum(IsNull(a5.ImporteValor,0)) as [Imp.Valor],
 Null as [Imp.Valor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 a
LEFT OUTER JOIN #Auxiliar5 a5 ON a5.IdAux=a.IdAux

ORDER BY [IdAux6], [IdAux1], [IdAux5], [IdAux4], [IdAux3]

/*
select a5.* from #Auxiliar5 a5
LEFT OUTER JOIN #Auxiliar3 a ON a.IdAux=a5.IdAux
LEFT OUTER JOIN Vendedores v ON v.IdVendedor=a5.IdVendedor
order by a.Origen, v.CodigoVendedor, a5.FechaRecibo, a5.NumeroRecibo
*/

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar9