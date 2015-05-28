CREATE  Procedure [dbo].[InformeMayorDetalladoCompleto_TX_1]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int,
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int,
	@IdTipoComprobanteDeposito int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDeposito=(Select Top 1 IdTipoComprobanteDeposito From Parametros Where IdParametro=1)


CREATE TABLE #Auxiliar0
			(
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			)
INSERT INTO #Auxiliar0
 SELECT Cuentas.IdCuenta, 0, 0
 FROM Cuentas

INSERT INTO #Auxiliar0
 SELECT DetAsi.IdCuenta, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.FechaAsiento<@FechaDesde

INSERT INTO #Auxiliar0
 SELECT Subdiarios.IdCuenta, IsNull(Subdiarios.Debe,0), IsNull(Subdiarios.Haber,0)
 FROM Subdiarios 
 WHERE Subdiarios.FechaComprobante<@FechaDesde

CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			)
INSERT INTO #Auxiliar1
 SELECT #Auxiliar0.IdCuenta, Sum(IsNull(#Auxiliar0.Debe,0)), Sum(IsNull(#Auxiliar0.Haber,0))
 FROM #Auxiliar0 
 GROUP BY #Auxiliar0.IdCuenta


CREATE TABLE #Auxiliar2
			(
			 IdCuenta INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 NumeroComprobante VARCHAR(30),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  DetAsi.IdCuenta,
  Asientos.FechaAsiento,
  38,
  Asientos.IdAsiento,
  'AS '+Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento),
  IsNull(DetAsi.Debe,0),
  IsNull(DetAsi.Haber,0)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta) 

INSERT INTO #Auxiliar2 
 SELECT 
  Subdiarios.IdCuenta,
  Subdiarios.FechaComprobante,
  Subdiarios.IdTipoComprobante,
  Subdiarios.IdComprobante,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta 
		Then TiposComprobante.DescripcionAb+' '+Facturas.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones 
		Then TiposComprobante.DescripcionAb+' '+Devoluciones.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito 
		Then TiposComprobante.DescripcionAb+' '+NotasDebito.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito 
		Then TiposComprobante.DescripcionAb+' '+NotasCredito.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo 
		Then TiposComprobante.DescripcionAb+' '+
			Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago 
		Then TiposComprobante.DescripcionAb+' '+
			Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito 
		Then TiposComprobante.DescripcionAb+' '+
			Substring('00000000',1,8-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+Convert(varchar,DepositosBancarios.NumeroDeposito)
	Else 
		Case When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES'  
			Then TiposComprobante.DescripcionAb+' '+cp.Letra +'-'+
				Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
			Else Null 
		End
  End,
  IsNull(Subdiarios.Debe,0),
  IsNull(Subdiarios.Haber,0)
 FROM Subdiarios
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
 LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES'
 LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
 WHERE Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta)


CREATE TABLE #Auxiliar3
			(
			 IdAux INTEGER IDENTITY (1, 1),
			 Codigo INTEGER,
			 IdCuenta INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 NumeroComprobante VARCHAR(30),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2), 
			 Saldo NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX_Auxiliar3 ON #Auxiliar3 (Codigo, IdCuenta, IdAux) ON [PRIMARY]
CREATE NONCLUSTERED INDEX PK_Auxiliar3 ON #Auxiliar3 (IdAux) ON [PRIMARY]
INSERT INTO #Auxiliar3 
 SELECT Cuentas.Codigo, #Auxiliar1.IdCuenta, @FechaDesde, 0, 0, 'SALDO INICIAL', #Auxiliar1.Debe, #Auxiliar1.Haber, 0
 FROM #Auxiliar1
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar1.IdCuenta
 ORDER BY Cuentas.Codigo
 
INSERT INTO #Auxiliar3 
 SELECT Cuentas.Codigo, #Auxiliar2.IdCuenta, #Auxiliar2.Fecha , #Auxiliar2.IdTipoComprobante, #Auxiliar2.IdComprobante, 
		#Auxiliar2.NumeroComprobante, #Auxiliar2.Debe, #Auxiliar2.Haber, 0
 FROM #Auxiliar2
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar2.IdCuenta
 ORDER BY Cuentas.Codigo, #Auxiliar2.Fecha , #Auxiliar2.IdTipoComprobante, #Auxiliar2.IdComprobante, #Auxiliar2.NumeroComprobante


/*  CURSOR  */
DECLARE @IdAux int, @IdCuenta int, @Debe numeric(18,2), @Haber numeric(18,2), @Saldo numeric(18,2), @Corte int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdAux, IdCuenta, Debe, Haber FROM #Auxiliar3 ORDER BY Codigo, IdCuenta, IdAux
OPEN Cur
FETCH NEXT FROM Cur INTO @IdAux, @IdCuenta, @Debe, @Haber
SET @Corte=-1
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdCuenta
	   BEGIN
		SET @Saldo=0
		SET @Corte=@IdCuenta
	   END
	SET @Saldo=@Saldo+(IsNull(@Debe,0)-IsNull(@Haber,0))
	UPDATE #Auxiliar3
	SET Saldo = @Saldo
	WHERE IdAux=@IdAux
	
	FETCH NEXT FROM Cur INTO @IdAux, @IdCuenta, @Debe, @Haber
   END
CLOSE Cur
DEALLOCATE Cur


CREATE TABLE #Auxiliar4	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_Descripcion VARCHAR(50),
			 A_NombreAnterior VARCHAR(50),
			 A_CodigoAnterior INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (A_IdCuenta) ON [PRIMARY]
INSERT INTO #Auxiliar4 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  (Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio),
  (Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio)
 FROM Cuentas 

SET NOCOUNT ON


select * from #Auxiliar3
order by Codigo, Fecha , IdTipoComprobante, IdComprobante, NumeroComprobante



DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4