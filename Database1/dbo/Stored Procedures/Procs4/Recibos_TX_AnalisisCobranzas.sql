CREATE PROCEDURE [dbo].[Recibos_TX_AnalisisCobranzas]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int,
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int
SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 (IdDetalleRecibo INTEGER, IdRecibo INTEGER, Importe NUMERIC(18, 2), Procesado VARCHAR(1))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleRecibo) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT DetRec.IdDetalleRecibo, DetRec.IdRecibo, DetRec.Importe, ''
 FROM DetalleRecibos DetRec
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRec.IdRecibo
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and Recibos.Tipo='CC'

CREATE TABLE #Auxiliar2 (IdDetalleReciboValores INTEGER, IdRecibo INTEGER, Importe NUMERIC(18, 2), Procesado VARCHAR(1))
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdDetalleReciboValores) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT DetRec.IdDetalleReciboValores, DetRec.IdRecibo, DetRec.Importe, ''
 FROM DetalleRecibosValores DetRec
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRec.IdRecibo
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and Recibos.Tipo='CC'

CREATE TABLE #Auxiliar3 
			(
			 IdRecibo INTEGER,
			 Fecha DATETIME,
			 Orden INTEGER,
			 IdDetalleRecibo INTEGER,
			 IdDetalleReciboValores INTEGER
			)

DECLARE @Corte INTEGER, @Orden INTEGER, 
	@IdRecibo INTEGER, @IdDetalleRecibo INTEGER, @IdDetalleReciboValores INTEGER, @FechaBase DATETIME, @FechaRecibo DATETIME, 
	@Dias NUMERIC(18,2), @Calculo1 NUMERIC(18,2), @Calculo2 NUMERIC(18,2)

SET @Corte=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdDetalleRecibo, IdRecibo
		FROM #Auxiliar1
		ORDER BY IdDetalleRecibo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRecibo, @IdRecibo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRecibo
	   BEGIN
		SET @Corte=@IdRecibo
		SET @Orden=1
	   END

	SET @IdDetalleReciboValores=IsNull((Select Top 1 IdDetalleReciboValores From #Auxiliar2 Where IdRecibo=@IdRecibo and Procesado=''),0)

	INSERT INTO #Auxiliar3 
	(IdRecibo, Orden, IdDetalleRecibo, IdDetalleReciboValores)
	VALUES
	(@IdRecibo, @Orden, @IdDetalleRecibo, @IdDetalleReciboValores)

	IF @IdDetalleReciboValores>0
		UPDATE #Auxiliar2 SET Procesado='*' WHERE IdDetalleReciboValores=@IdDetalleReciboValores
	UPDATE #Auxiliar1
	SET Procesado='*'
	WHERE CURRENT OF Cur

	SET @Orden=@Orden+1
	FETCH NEXT FROM Cur INTO @IdDetalleRecibo, @IdRecibo
   END
CLOSE Cur
DEALLOCATE Cur

SET @Corte=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdDetalleReciboValores, IdRecibo
		FROM #Auxiliar2
		WHERE Procesado=''
		ORDER BY IdDetalleReciboValores
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleReciboValores, @IdRecibo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRecibo
	   BEGIN
		SET @Corte=@IdRecibo
		SET @Orden=IsNull((Select Top 1 Orden From #Auxiliar3 Where IdRecibo=@IdRecibo Order By IdRecibo, Orden Desc),0)+1
	   END

	INSERT INTO #Auxiliar3 
	(IdRecibo, Orden, IdDetalleRecibo, IdDetalleReciboValores)
	VALUES
	(@IdRecibo, @Orden, 0, @IdDetalleReciboValores)

	UPDATE #Auxiliar2
	SET Procesado='*'
	WHERE CURRENT OF Cur

	SET @Orden=@Orden+1
	FETCH NEXT FROM Cur INTO @IdDetalleReciboValores, @IdRecibo
   END
CLOSE Cur
DEALLOCATE Cur


CREATE TABLE #Auxiliar4 
			(
			 IdRecibo INTEGER,
			 FechaBaseImputaciones DATETIME,
			 DiasImputaciones NUMERIC(18,2),
			 FechaImputaciones DATETIME,
			 FechaBaseValores DATETIME,
			 DiasValores NUMERIC(18,2),
			 FechaValores DATETIME
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdRecibo) ON [PRIMARY]
INSERT INTO #Auxiliar4 
 SELECT Recibos.IdRecibo, Null, Null, Null, Null, Null, Null
 FROM Recibos
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and Recibos.Tipo='CC'

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRecibo
		FROM #Auxiliar4
		ORDER BY IdRecibo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRecibo
WHILE @@FETCH_STATUS = 0
   BEGIN
	-- DETERMINAR FECHA PROMEDIO DE IMPUTACIONES
	SET @FechaRecibo=(Select Top 1 FechaRecibo From Recibos Where IdRecibo=@IdRecibo)
	SET @FechaBase=(Select Min(IsNull(Cta.Fecha,@FechaRecibo))
			From DetalleRecibos D 
			Left Outer Join CuentasCorrientesDeudores Cta On Cta.IdCtaCte=D.IdImputacion
			Where D.IdRecibo=@IdRecibo)
	SET @Calculo1=IsNull((Select Sum(Convert(int,IsNull(Cta.Fecha,@FechaRecibo)) * IsNull(D.Importe,0))
				From DetalleRecibos D 
				Left Outer Join CuentasCorrientesDeudores Cta On Cta.IdCtaCte=D.IdImputacion
				Where D.IdRecibo=@IdRecibo),0)
	SET @Calculo2=IsNull((Select Sum(IsNull(D.Importe,0))
				From DetalleRecibos D 
				Where D.IdRecibo=@IdRecibo),0)
	IF @Calculo2<>0
		SET @Dias=(@Calculo1/@Calculo2)-Convert(int,@FechaBase)
	ELSE
		SET @Dias=0
	IF Abs(@Dias)>10000
		SET @Dias=0

	UPDATE #Auxiliar4
	SET FechaBaseImputaciones=@FechaBase, DiasImputaciones=@Dias, FechaImputaciones=DateAdd(d,@Dias,@FechaBase)
	WHERE CURRENT OF Cur

	-- DETERMINAR FECHA PROMEDIO DE VALORES
	SET @FechaBase=(Select Min(IsNull(D.FechaVencimiento,@FechaRecibo)) From DetalleRecibosValores D Where D.IdRecibo=@IdRecibo)
	SET @Calculo1=IsNull((Select Sum(Convert(int,IsNull(D.FechaVencimiento,@FechaRecibo)) * IsNull(D.Importe,0))
				From DetalleRecibosValores D Where D.IdRecibo=@IdRecibo),0)
	SET @Calculo2=IsNull((Select Sum(IsNull(D.Importe,0)) From DetalleRecibosValores D Where D.IdRecibo=@IdRecibo),0)
	IF @Calculo2<>0
		SET @Dias=(@Calculo1/@Calculo2)-Convert(int,@FechaBase)
	ELSE
		SET @Dias=0
	IF Abs(@Dias)>10000
		SET @Dias=0

	UPDATE #Auxiliar4
	SET FechaBaseValores=@FechaBase, DiasValores=@Dias, FechaValores=DateAdd(d,@Dias,@FechaBase)
	WHERE CURRENT OF Cur

	FETCH NEXT FROM Cur INTO @IdRecibo
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0000111111111111111161633'
SET @vector_T='0000E41303E44452444135200'

SELECT
 #Auxiliar3.IdRecibo as [IdRecibo],
 #Auxiliar3.Orden as [IdAux1],
 Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux2],
 Recibos.FechaRecibo as [IdAux3], 
 Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [Nro.Recibo],
 Recibos.FechaRecibo as [Fecha Recibo], 
 Clientes.CodigoCliente as [Cod.Cli.], 
 Clientes.RazonSocial as [Cliente],
 Monedas.Abreviatura as [Mon.],
 Case When DetalleRecibos.IdImputacion=-1 Then 'PA' Else T1.DescripcionAB End as [Tipo Comp.],
 Case 	When Facturas.NumeroFactura is not null
	 Then Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
	When Devoluciones.NumeroDevolucion is not null
	 Then Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
	When NotasDebito.NumeroNotaDebito is not null
	 Then NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)
	When NotasCredito.NumeroNotaCredito is not null
	 Then NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+
		Convert(varchar,NotasCredito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)
	Else Substring('00000000',1,8-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante)
 End as [Comprobante],
 Cta.Fecha as [Fecha],
 IsNull(Cta.FechaVencimiento,Cta.Fecha) as [Fecha vto.],
 DetalleRecibos.Importe as [Imp.Imputacion],
 Null as [Fecha promedio 1],
 T2.DescripcionAB as [Tipo Valor],
 DetalleRecibosValores.NumeroInterno as [Nro.Interno],
 DetalleRecibosValores.NumeroValor as [Nro.Valor],
 DetalleRecibosValores.FechaVencimiento as [Fecha Vto.],
 Case When Bancos.Nombre is not null Then Bancos.Nombre
	When Cajas.Descripcion is not null Then Cajas.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS
	Else '' 
 End as [Banco / Caja],
 DetalleRecibosValores.Importe as [Imp.Valor],
 Null as [Fecha promedio 2],
 Null as [Dias dif.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN DetalleRecibos ON DetalleRecibos.IdDetalleRecibo=#Auxiliar3.IdDetalleRecibo
LEFT OUTER JOIN DetalleRecibosValores ON DetalleRecibosValores.IdDetalleReciboValores=#Auxiliar3.IdDetalleReciboValores
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar3.IdRecibo
LEFT OUTER JOIN CuentasCorrientesDeudores Cta ON Cta.IdCtaCte=DetalleRecibos.IdImputacion
LEFT OUTER JOIN TiposComprobante T1 ON T1.IdTipoComprobante=Cta.IdTipoComp
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN [Condiciones Compra] cc ON Facturas.IdCondicionVenta=cc.IdCondicionCompra
LEFT OUTER JOIN TiposComprobante T2 ON T2.IdTipoComprobante=DetalleRecibosValores.IdTipoValor
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetalleRecibosValores.IdBanco
LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetalleRecibosValores.IdCaja
LEFT OUTER JOIN Clientes ON Recibos.IdCliente=Clientes.IdCliente 
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda=Monedas.IdMoneda

UNION ALL

SELECT
 #Auxiliar3.IdRecibo as [IdRecibo],
 99998 as [IdAux1],
 Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux2],
 Recibos.FechaRecibo as [IdAux3], 
 Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [Nro.Recibo],
 Recibos.FechaRecibo as [Fecha Recibo], 
 Clientes.CodigoCliente as [Cod.Cli.], 
 Clientes.RazonSocial as [Cliente],
 Monedas.Abreviatura as [Mon.],
 Null as [Comp.],
 Null as [Comprobante],
 Null as [Fecha],
 Null as [Fecha vto.],
 Null as [Imp.Imputacion],
 #Auxiliar4.FechaImputaciones as [Fecha promedio 1],
 Null as [Tipo Valor],
 Null as [Nro.Interno],
 Null as [Nro.Valor],
 Null as [Fecha Vto.],
 Null as [Banco / Caja],
 Null as [Imp.Valor],
 #Auxiliar4.FechaValores as [Fecha promedio 2],
 Datediff(d,#Auxiliar4.FechaImputaciones,#Auxiliar4.FechaValores) as [Dias dif.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN DetalleRecibos ON DetalleRecibos.IdDetalleRecibo=#Auxiliar3.IdDetalleRecibo
LEFT OUTER JOIN DetalleRecibosValores ON DetalleRecibosValores.IdDetalleReciboValores=#Auxiliar3.IdDetalleReciboValores
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar3.IdRecibo
LEFT OUTER JOIN Clientes ON Recibos.IdCliente=Clientes.IdCliente 
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.IdRecibo=#Auxiliar3.IdRecibo
GROUP BY #Auxiliar3.IdRecibo, Recibos.PuntoVenta, Recibos.NumeroRecibo, Recibos.FechaRecibo, Clientes.CodigoCliente, 
	Clientes.RazonSocial, Monedas.Abreviatura, #Auxiliar4.FechaImputaciones, #Auxiliar4.FechaValores

UNION ALL

SELECT
 #Auxiliar3.IdRecibo as [IdRecibo],
 99999 as [IdAux1],
 Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux2],
 Recibos.FechaRecibo as [IdAux3], 
 Null as [Nro.Recibo],
 Null as [Fecha Recibo], 
 Null as [Cod.Cli.], 
 Null as [Cliente],
 Null as [Mon.],
 Null as [Comp.],
 Null as [Comprobante],
 Null as [Fecha],
 Null as [Fecha vto.],
 Null as [Imp.Imputacion],
 Null as [Fecha promedio 1],
 Null as [Tipo Valor],
 Null as [Nro.Interno],
 Null as [Nro.Valor],
 Null as [Fecha Vto.],
 Null as [Banco / Caja],
 Null as [Imp.Valor],
 Null as [Fecha promedio 2],
 Null as [Dias dif.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN DetalleRecibos ON DetalleRecibos.IdDetalleRecibo=#Auxiliar3.IdDetalleRecibo
LEFT OUTER JOIN DetalleRecibosValores ON DetalleRecibosValores.IdDetalleReciboValores=#Auxiliar3.IdDetalleReciboValores
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar3.IdRecibo
LEFT OUTER JOIN Clientes ON Recibos.IdCliente=Clientes.IdCliente 
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda=Monedas.IdMoneda
GROUP BY #Auxiliar3.IdRecibo, Recibos.PuntoVenta, Recibos.NumeroRecibo, Recibos.FechaRecibo

ORDER BY [IdAux3], [IdAux2], [IdAux1]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4