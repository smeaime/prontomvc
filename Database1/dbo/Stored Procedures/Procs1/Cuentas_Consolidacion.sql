CREATE Procedure [dbo].[Cuentas_Consolidacion]

@FechaHasta datetime

AS 

DECLARE @FechaInicioGeneracionAsientos datetime
SET @FechaInicioGeneracionAsientos=Convert(datetime,'01/07/2006')

CREATE TABLE #Auxiliar10 (Identificador INTEGER, Aux1 VARCHAR(50), Aux2 NUMERIC(6,2))
CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (Identificador) ON [PRIMARY]

CREATE TABLE #Auxiliar0 (Orden INTEGER, BaseDatos VARCHAR(50), Numeral INTEGER)
INSERT INTO #Auxiliar0 SELECT * FROM _TempBasesConciliacion
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (Orden,BaseDatos,Numeral) ON [PRIMARY]

CREATE TABLE #Auxiliar00 (BaseDatos VARCHAR(50))
INSERT INTO #Auxiliar00 SELECT BaseDatos FROM _TempBasesConciliacion GROUP BY BaseDatos
CREATE NONCLUSTERED INDEX IX__Auxiliar00 ON #Auxiliar00 (BaseDatos) ON [PRIMARY]

CREATE TABLE #Auxiliar30 (MesRegistro INTEGER, AñoRegistro INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar30 ON #Auxiliar30 (MesRegistro,AñoRegistro) ON [PRIMARY]

CREATE TABLE #Auxiliar1
			(
			 BaseDatos VARCHAR(50),
			 Numeral INTEGER,
			 CodigoCuenta INTEGER,
			 Cuenta VARCHAR(50),
			 CodigoCuentaMadre INTEGER,
			 CuentaMadre VARCHAR(50),
			 Detalle VARCHAR(50),
			 BaseConsolidadaHija VARCHAR(50),
			 FechaGeneracionConsolidado DATETIME,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Cotizacion NUMERIC(18, 4),
			 FechaMovimiento DATETIME,
			 MesRegistro INTEGER,
			 AñoRegistro INTEGER
			)
CREATE TABLE #Auxiliar20
			(
			 BaseDatos VARCHAR(50),
			 CodigoCuenta INTEGER,
			 Cuenta VARCHAR(50),
			 CodigoCuentaMadre INTEGER,
			 CuentaMadre VARCHAR(50),
			 Detalle VARCHAR(50),
			 BaseConsolidadaHija VARCHAR(50),
			 FechaGeneracionConsolidado DATETIME,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 MesRegistro INTEGER,
			 AñoRegistro INTEGER
			)
CREATE TABLE #Auxiliar2
			(
			 BaseDatos VARCHAR(50),
			 Numeral INTEGER,
			 CodigoCuenta INTEGER,
			 Cuenta VARCHAR(50),
			 CodigoCuentaMadre INTEGER,
			 CuentaMadre VARCHAR(50),
			 Detalle VARCHAR(50),
			 BaseConsolidadaHija VARCHAR(50),
			 FechaGeneracionConsolidado DATETIME,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Cotizacion NUMERIC(18, 4),
			 FechaMovimiento DATETIME,
			 MesRegistro INTEGER,
			 AñoRegistro INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (CodigoCuenta) ON [PRIMARY]
CREATE TABLE #Auxiliar3
			(
			 BaseDatos VARCHAR(50),
			 Numeral INTEGER,
			 BaseDatosHija VARCHAR(50),
			 CodigoCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 MesRegistro INTEGER,
			 AñoRegistro INTEGER
			)
CREATE TABLE #Auxiliar4
			(
			 IdCuenta INTEGER,
			 CodigoCuenta INTEGER,
			 CodigoCuentaMadre INTEGER
			)
CREATE TABLE #Auxiliar5
			(
			 CodigoCuenta INTEGER,
			 Debe1 NUMERIC(18, 2),
			 Haber1 NUMERIC(18, 2),
			 Debe2 NUMERIC(18, 2),
			 Haber2 NUMERIC(18, 2),
			 MesRegistro INTEGER,
			 AñoRegistro INTEGER
			)
CREATE TABLE #Auxiliar6
			(
			 CodigoCuenta INTEGER,
			 Debe1 NUMERIC(18, 2),
			 Haber1 NUMERIC(18, 2),
			 Debe2 NUMERIC(18, 2),
			 Haber2 NUMERIC(18, 2),
			 MesRegistro INTEGER,
			 AñoRegistro INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar6 ON #Auxiliar6 (CodigoCuenta) ON [PRIMARY]

DECLARE @Orden int, @BaseDatos varchar(50), @Numeral int, @BaseDatosMadre varchar(50), @sql1 nvarchar(4000), @sql2 varchar(8000), @Porcentaje numeric(6,2), @NumeroAsiento int, 
	@IdAsiento int, @CodigoCuenta int, @Debe1 numeric(18,2), @Haber1 numeric(18,2), @Debe2 numeric(18,2), @Haber2 numeric(18,2), @Debe3 numeric(18,2), @Haber3 numeric(18,2), 
	@Item int, @IdCuenta int, @Registros int, @IdCuentaAjusteConsolidacion int, @Identificador int, @SaldoDebe numeric(18,2), @SaldoHaber numeric(18,2), @OrdenBase varchar(1), 
	@CodigoCuentaAjusteConsolidacion int, @ControlError int, @MonedaHija varchar(15), @FechaMovimiento datetime, @FechaRegistroAsiento datetime, @MesRegistro int, @AñoRegistro int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT BaseDatos FROM #Auxiliar00 ORDER BY BaseDatos
OPEN Cur
FETCH NEXT FROM Cur INTO @BaseDatos
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @sql2='Select '''+@BaseDatos+''', Cta.Codigo, Cta.Descripcion, Null, Null, 
			'''+'AS '+'''+Substring('''+'00000000'+''',1,8-Len(Convert(varchar,Asi.NumeroAsiento)))+Convert(varchar,Asi.NumeroAsiento),
			Asi.BaseConsolidadaHija, Asi.FechaGeneracionConsolidado, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0), Month(Asi.FechaAsiento), Year(Asi.FechaAsiento) 
		From '+@BaseDatos+'.dbo.DetalleAsientos DetAsi 
		Left Outer Join '+@BaseDatos+'.dbo.Asientos Asi On DetAsi.IdAsiento = Asi.IdAsiento
		Left Outer Join '+@BaseDatos+'.dbo.Cuentas Cta On DetAsi.IdCuenta = Cta.IdCuenta
		Where Asi.IdCuentaSubdiario is null and 
			Substring(IsNull(Asi.Tipo,'''+'   '+'''),1,3)<>'''+'CIE'+''' and 
			Substring(IsNull(Asi.Tipo,'''+'   '+'''),1,3)<>'''+'APE'+''' and 
			Asi.FechaAsiento<=Convert(datetime,'''+Convert(varchar,@FechaHasta,103)+''',103) and 
			Asi.BaseConsolidadaHija is not null'
	INSERT INTO #Auxiliar20 EXEC (@sql2)
	FETCH NEXT FROM Cur INTO @BaseDatos
   END
CLOSE Cur
DEALLOCATE Cur

SET @ControlError=0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Orden, BaseDatos, Numeral FROM #Auxiliar0 ORDER BY Orden, BaseDatos, Numeral
OPEN Cur
FETCH NEXT FROM Cur INTO @Orden, @BaseDatos, @Numeral
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF IsNull(@Numeral,1)=1
	   BEGIN
		SET @sql1='Select Null, P.BasePRONTOConsolidacion, P.PorcentajeConsolidacion From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
		SET @OrdenBase=''
	   END
	ELSE 
		IF IsNull(@Numeral,1)=2
		   BEGIN
			SET @sql1='Select Null, P.BasePRONTOConsolidacion2, P.PorcentajeConsolidacion2 From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
			SET @OrdenBase='2'
		   END
		ELSE
		   BEGIN
			SET @sql1='Select Null, P.BasePRONTOConsolidacion3, P.PorcentajeConsolidacion3 From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
			SET @OrdenBase='3'
		   END
	TRUNCATE TABLE #Auxiliar10
	INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
	SET @BaseDatosMadre=IsNull((Select Top 1 Aux1 From #Auxiliar10),'')

	--Buscar la moneda de la base hija
	SET @sql1='Select Null, Mon.Abreviatura, Null 
			From '+@BaseDatos+'.dbo.Parametros P 
			Left Outer Join '+@BaseDatos+'.dbo.Monedas Mon On P.IdMonedaPrincipal = Mon.IdMoneda
			Where P.IdParametro=1'
	TRUNCATE TABLE #Auxiliar10
	INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
	SET @MonedaHija=IsNull((Select Top 1 Aux1 From #Auxiliar10),'S/D')

	IF Len(@BaseDatosMadre)=0
		SET @sql2='
			Declare @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int,
				@IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int 
			
			Set @IdTipoComprobanteFacturaVenta=(Select Top 1 P.IdTipoComprobanteFacturaVenta From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteDevoluciones=(Select Top 1 P.IdTipoComprobanteDevoluciones From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteNotaDebito=(Select Top 1 P.IdTipoComprobanteNotaDebito From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteNotaCredito=(Select Top 1 P.IdTipoComprobanteNotaCredito From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteRecibo=(Select Top 1 P.IdTipoComprobanteRecibo From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteOrdenPago=(Select Top 1 P.IdTipoComprobanteOrdenPago From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)

			Select '''+@BaseDatos+''', '+Convert(varchar,@Numeral)+', Cta.Codigo, Cta.Descripcion, Null, Null, 
				'''+'AS '+'''+Substring('''+'00000000'+''',1,8-Len(Convert(varchar,Asi.NumeroAsiento)))+Convert(varchar,Asi.NumeroAsiento),
				Asi.BaseConsolidadaHija, Asi.FechaGeneracionConsolidado, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0), 1, Asi.FechaAsiento, Null, Null 
			From '+@BaseDatos+'.dbo.DetalleAsientos DetAsi 
			Left Outer Join '+@BaseDatos+'.dbo.Asientos Asi On DetAsi.IdAsiento = Asi.IdAsiento
			Left Outer Join '+@BaseDatos+'.dbo.Cuentas Cta On DetAsi.IdCuenta = Cta.IdCuenta
			Where Asi.IdCuentaSubdiario is null and 
				Substring(IsNull(Asi.Tipo,'''+'   '+'''),1,3)<>'''+'CIE'+''' and 
				Substring(IsNull(Asi.Tipo,'''+'   '+'''),1,3)<>'''+'APE'+''' and 
				Asi.FechaAsiento<=Convert(datetime,'''+Convert(varchar,@FechaHasta,103)+''',103) 
			Union All 
			Select '''+@BaseDatos+''', '+Convert(varchar,@Numeral)+', Cta.Codigo, Cta.Descripcion, Null, Null, 
				Case 	When Fa.IdFactura is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+Fa.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,Fa.PuntoVenta)))+Convert(varchar,Fa.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,Fa.NumeroFactura)))+Convert(varchar,Fa.NumeroFactura)
					When De.IdDevolucion is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+De.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,De.PuntoVenta)))+Convert(varchar,De.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,De.NumeroDevolucion)))+Convert(varchar,De.NumeroDevolucion)
					When ND.IdNotaDebito is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+ND.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,ND.PuntoVenta)))+Convert(varchar,ND.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,ND.NumeroNotaDebito)))+Convert(varchar,ND.NumeroNotaDebito)
					When NC.IdNotaCredito is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+NC.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,NC.PuntoVenta)))+Convert(varchar,NC.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,NC.NumeroNotaCredito)))+Convert(varchar,NC.NumeroNotaCredito)
					When Re.IdRecibo is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,Re.NumeroRecibo)))+Convert(varchar,Re.NumeroRecibo)
					When OP.IdOrdenPago is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,OP.NumeroOrdenPago)))+Convert(varchar,OP.NumeroOrdenPago)
					When CP.IdComprobanteProveedor is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+CP.Letra+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,CP.NumeroComprobante1)))+Convert(varchar,CP.NumeroComprobante1)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,CP.NumeroComprobante2)))+Convert(varchar,CP.NumeroComprobante2)
					Else Null
				End, Null, Null, IsNull(Sub.Debe,0), IsNull(Sub.Haber,0), 1, Sub.FechaComprobante, Null, Null 
			From '+@BaseDatos+'.dbo.Subdiarios Sub 
			Left Outer Join '+@BaseDatos+'.dbo.Cuentas Cta On Sub.IdCuenta = Cta.IdCuenta 
			Left Outer Join '+@BaseDatos+'.dbo.TiposComprobante TC On Sub.IdTipoComprobante = TC.IdTipoComprobante 
			Left Outer Join '+@BaseDatos+'.dbo.Facturas Fa On Sub.IdComprobante = Fa.IdFactura and Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			Left Outer Join '+@BaseDatos+'.dbo.Devoluciones De On Sub.IdComprobante = De.IdDevolucion and Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones			Left Outer Join '+@BaseDatos+'.dbo.NotasDebito ND On Sub.IdComprobante = ND.IdNotaDebito and Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			Left Outer Join '+@BaseDatos+'.dbo.NotasCredito NC On Sub.IdComprobante = NC.IdNotaCredito and Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			Left Outer Join '+@BaseDatos+'.dbo.Recibos Re On Sub.IdComprobante = Re.IdRecibo and Sub.IdTipoComprobante=@IdTipoComprobanteRecibo
			Left Outer Join '+@BaseDatos+'.dbo.OrdenesPago OP On Sub.IdComprobante = OP.IdOrdenPago and Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago
			Left Outer Join '+@BaseDatos+'.dbo.ComprobantesProveedores CP On Sub.IdComprobante = CP.IdComprobanteProveedor and IsNull(TC.Agrupacion1,'''+' '+''')='''+'PROVEEDORES'+''' 
			Where Sub.FechaComprobante<=Convert(datetime,'''+Convert(varchar,@FechaHasta,103)+''',103)'
	ELSE
	   BEGIN
		SET @sql2='
			Declare @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int,
				@IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int, @MonedaMadre varchar(15), @IdMonedaMadre int, @IdMonedaHija int
			
			Set @IdTipoComprobanteFacturaVenta=(Select Top 1 P.IdTipoComprobanteFacturaVenta From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteDevoluciones=(Select Top 1 P.IdTipoComprobanteDevoluciones From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteNotaDebito=(Select Top 1 P.IdTipoComprobanteNotaDebito From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteNotaCredito=(Select Top 1 P.IdTipoComprobanteNotaCredito From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteRecibo=(Select Top 1 P.IdTipoComprobanteRecibo From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdTipoComprobanteOrdenPago=(Select Top 1 P.IdTipoComprobanteOrdenPago From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1)
			Set @IdMonedaMadre=IsNull((Select Top 1 P.IdMonedaPrincipal From '+@BaseDatosMadre+'.dbo.Parametros P Where P.IdParametro=1),0)
			Set @MonedaMadre=IsNull((Select Top 1 Mon.Abreviatura From '+@BaseDatosMadre+'.dbo.Monedas Mon Where Mon.IdMoneda=@IdMonedaMadre),'''+' '+''')
			Set @IdMonedaHija=IsNull((Select Top 1 Mon.IdMoneda From '+@BaseDatosMadre+'.dbo.Monedas Mon Where Mon.Abreviatura='''+@MonedaHija+'''),0) 

			Select '''+@BaseDatos+''', '+Convert(varchar,@Numeral)+', Cta.Codigo, Cta.Descripcion, Cta1.Codigo, Cta1.Descripcion, 
				'''+'AS '+'''+Substring('''+'00000000'+''',1,8-Len(Convert(varchar,Asi.NumeroAsiento)))+Convert(varchar,Asi.NumeroAsiento),
				Asi.BaseConsolidadaHija, Asi.FechaGeneracionConsolidado, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0), 
				Case When @IdMonedaMadre=@IdMonedaHija 
					Then 1 
					Else IsNull((Select Top 1 Cot.CotizacionLibre From '+@BaseDatosMadre+'.dbo.Cotizaciones Cot Where Cot.IdMoneda=@IdMonedaHija and Cot.Fecha=Asi.FechaAsiento),0)
				End, Asi.FechaAsiento, Null, Null 
			From '+@BaseDatos+'.dbo.DetalleAsientos DetAsi 
			Left Outer Join '+@BaseDatos+'.dbo.Asientos Asi On DetAsi.IdAsiento = Asi.IdAsiento
			Left Outer Join '+@BaseDatos+'.dbo.Cuentas Cta On DetAsi.IdCuenta = Cta.IdCuenta
			Left Outer Join '+@BaseDatosMadre+'.dbo.Cuentas Cta1 On Cta.IdCuentaConsolidacion'+@OrdenBase+' = Cta1.IdCuenta
			Where Asi.IdCuentaSubdiario is null and 
				Substring(IsNull(Asi.Tipo,'''+'   '+'''),1,3)<>'''+'CIE'+''' and 
				Substring(IsNull(Asi.Tipo,'''+'   '+'''),1,3)<>'''+'APE'+''' and 
				Asi.FechaAsiento<=Convert(datetime,'''+Convert(varchar,@FechaHasta,103)+''',103) 
			Union All 
			Select '''+@BaseDatos+''', '+Convert(varchar,@Numeral)+', Cta.Codigo, Cta.Descripcion, Cta1.Codigo, Cta1.Descripcion, 
				Case 	When Fa.IdFactura is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+Fa.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,Fa.PuntoVenta)))+Convert(varchar,Fa.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,Fa.NumeroFactura)))+Convert(varchar,Fa.NumeroFactura)
					When De.IdDevolucion is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+De.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,De.PuntoVenta)))+Convert(varchar,De.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,De.NumeroDevolucion)))+Convert(varchar,De.NumeroDevolucion)
					When ND.IdNotaDebito is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+ND.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,ND.PuntoVenta)))+Convert(varchar,ND.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,ND.NumeroNotaDebito)))+Convert(varchar,ND.NumeroNotaDebito)
					When NC.IdNotaCredito is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+NC.TipoABC+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,NC.PuntoVenta)))+Convert(varchar,NC.PuntoVenta)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,NC.NumeroNotaCredito)))+Convert(varchar,NC.NumeroNotaCredito)
					When Re.IdRecibo is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,Re.NumeroRecibo)))+Convert(varchar,Re.NumeroRecibo)
					When OP.IdOrdenPago is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,OP.NumeroOrdenPago)))+Convert(varchar,OP.NumeroOrdenPago)
					When CP.IdComprobanteProveedor is not null
					 Then IsNull(TC.DescripcionAb,+'''+' '+''')+'''+' '+'''+CP.Letra+'''+'-'+'''+
						Substring('''+'0000'+''',1,8-Len(Convert(varchar,CP.NumeroComprobante1)))+Convert(varchar,CP.NumeroComprobante1)+'''+'-'+'''+
						Substring('''+'00000000'+''',1,8-Len(Convert(varchar,CP.NumeroComprobante2)))+Convert(varchar,CP.NumeroComprobante2)
					Else Null
				End, Null, Null, IsNull(Sub.Debe,0), IsNull(Sub.Haber,0), 
				Case When @IdMonedaMadre=@IdMonedaHija 
					Then 1 
					Else IsNull((Select Top 1 Cot.CotizacionLibre From '+@BaseDatosMadre+'.dbo.Cotizaciones Cot Where Cot.IdMoneda=@IdMonedaHija and Cot.Fecha=Sub.FechaComprobante),0)
				End, Sub.FechaComprobante, Null, Null 
			From '+@BaseDatos+'.dbo.Subdiarios Sub 
			Left Outer Join '+@BaseDatos+'.dbo.Cuentas Cta On Sub.IdCuenta = Cta.IdCuenta
			Left Outer Join '+@BaseDatosMadre+'.dbo.Cuentas Cta1 On Cta.IdCuentaConsolidacion'+@OrdenBase+' = Cta1.IdCuenta
			Left Outer Join '+@BaseDatos+'.dbo.TiposComprobante TC On Sub.IdTipoComprobante = TC.IdTipoComprobante 
			Left Outer Join '+@BaseDatos+'.dbo.Facturas Fa On Sub.IdComprobante = Fa.IdFactura and Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			Left Outer Join '+@BaseDatos+'.dbo.Devoluciones De On Sub.IdComprobante = De.IdDevolucion and Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones
			Left Outer Join '+@BaseDatos+'.dbo.NotasDebito ND On Sub.IdComprobante = ND.IdNotaDebito and Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			Left Outer Join '+@BaseDatos+'.dbo.NotasCredito NC On Sub.IdComprobante = NC.IdNotaCredito and Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			Left Outer Join '+@BaseDatos+'.dbo.Recibos Re On Sub.IdComprobante = Re.IdRecibo and Sub.IdTipoComprobante=@IdTipoComprobanteRecibo
			Left Outer Join '+@BaseDatos+'.dbo.OrdenesPago OP On Sub.IdComprobante = OP.IdOrdenPago and Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago
			Left Outer Join '+@BaseDatos+'.dbo.ComprobantesProveedores CP On Sub.IdComprobante = CP.IdComprobanteProveedor and IsNull(TC.Agrupacion1,'''+' '+''')='''+'PROVEEDORES'+''' 
			Where Sub.FechaComprobante<=Convert(datetime,'''+Convert(varchar,@FechaHasta,103)+''',103)'
		--Print @sql2
	   END
	INSERT INTO #Auxiliar1 EXEC (@sql2)

	UPDATE #Auxiliar1 
	SET MesRegistro=Case When FechaMovimiento<@FechaInicioGeneracionAsientos Then Month(@FechaInicioGeneracionAsientos) Else Month(FechaMovimiento) End,
	    AñoRegistro=Case When FechaMovimiento<@FechaInicioGeneracionAsientos Then Year(@FechaInicioGeneracionAsientos) Else Year(FechaMovimiento) End

	-- Controlar que todas las cuentas con movimiento tengan definida la cuenta en la base de datos madre.
	IF Len(@BaseDatosMadre)>0
	   BEGIN
		TRUNCATE TABLE #Auxiliar2
		INSERT INTO #Auxiliar2 
		 SELECT @BaseDatosMadre, Null, CodigoCuenta, Null, CodigoCuentaMadre, Null, Null, @BaseDatos, Null, Sum(IsNull(Debe,0)), Sum(IsNull(Haber,0)), 1, Null, Null, Null 
		 FROM #Auxiliar1 
		 WHERE BaseDatos=@BaseDatos 
		 GROUP BY CodigoCuenta, CodigoCuentaMadre

		IF EXISTS(SELECT TOP 1 CodigoCuenta FROM #Auxiliar2 WHERE Debe-Haber<>0 and CodigoCuentaMadre is null)
		   BEGIN
			DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT CodigoCuenta FROM #Auxiliar2 WHERE Debe-Haber<>0 and CodigoCuentaMadre is null ORDER BY CodigoCuenta
			OPEN Cur1
			FETCH NEXT FROM Cur1 INTO @CodigoCuenta 
			WHILE @@FETCH_STATUS = 0
			   BEGIN
				SET @ControlError=1
				SET @sql1='Select E.IdEmpleado, Null, Null From '+@BaseDatos+'.dbo.Empleados E Where E.Administrador='+'''SI'''
				TRUNCATE TABLE #Auxiliar10
				INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1

				DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT Identificador FROM #Auxiliar10 ORDER BY Identificador
				OPEN Cur2
				FETCH NEXT FROM Cur2 INTO @Identificador 
				WHILE @@FETCH_STATUS = 0
				   BEGIN
					SET @sql1='Insert Into '+@BaseDatos+'.dbo.NovedadesUsuarios 
							(IdEmpleado, IdEventoDelSistema, FechaEvento, Detalle)
							Values 
							('+Convert(varchar,@Identificador)+', '+Convert(varchar,100)+', '''+Convert(varchar,GetDate())+''', 
							 ''La cuenta '+Convert(varchar,@CodigoCuenta)+' no tiene definida la cuenta de la base de datos madre '+@BaseDatos+''')'
					EXEC sp_executesql @sql1
					FETCH NEXT FROM Cur2 INTO @Identificador 
				   END
				CLOSE Cur2
				DEALLOCATE Cur2

				FETCH NEXT FROM Cur1 INTO @CodigoCuenta 
			   END
			CLOSE Cur1
			DEALLOCATE Cur1
		   END
			
		--Determina si existen las cotizaciones de la moneda de la base madre a la moneda de la base hija
		TRUNCATE TABLE #Auxiliar2
		INSERT INTO #Auxiliar2 
		 SELECT @BaseDatosMadre, Null, Null, Null, Null, Null, Null, @BaseDatos, Null, Null, Null, 0, FechaMovimiento, Null, Null
		 FROM #Auxiliar1 
		 WHERE BaseDatos=@BaseDatos and Cotizacion=0 
		 GROUP BY FechaMovimiento

		DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT FechaMovimiento FROM #Auxiliar2 ORDER BY FechaMovimiento
		OPEN Cur1
		FETCH NEXT FROM Cur1 INTO @FechaMovimiento 
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			SET @ControlError=1
			SET @sql1='Select E.IdEmpleado, Null, Null From '+@BaseDatos+'.dbo.Empleados E Where E.Administrador='+'''SI'''
			TRUNCATE TABLE #Auxiliar10
			INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1

			DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT Identificador FROM #Auxiliar10 ORDER BY Identificador
			OPEN Cur2
			FETCH NEXT FROM Cur2 INTO @Identificador 
			WHILE @@FETCH_STATUS = 0
			   BEGIN
				SET @sql1='Insert Into '+@BaseDatos+'.dbo.NovedadesUsuarios 
						(IdEmpleado, IdEventoDelSistema, FechaEvento, Detalle)
						Values 
						('+Convert(varchar,@Identificador)+', '+Convert(varchar,100)+', '''+Convert(varchar,GetDate())+''', 
						 ''El dia '+Convert(varchar,@FechaMovimiento,103)+' no hay cotizacion en la base '+@BaseDatos+' para la moneda '+@MonedaHija+''')'
				EXEC sp_executesql @sql1
				FETCH NEXT FROM Cur2 INTO @Identificador 
			   END
			CLOSE Cur2
			DEALLOCATE Cur2

			FETCH NEXT FROM Cur1 INTO @FechaMovimiento 
		   END
		CLOSE Cur1
		DEALLOCATE Cur1
	   END
	FETCH NEXT FROM Cur INTO @Orden, @BaseDatos, @Numeral
   END
CLOSE Cur
DEALLOCATE Cur

IF @ControlError<>0
   BEGIN
	DROP TABLE #Auxiliar0
	DROP TABLE #Auxiliar00
	DROP TABLE #Auxiliar1
	DROP TABLE #Auxiliar2
	DROP TABLE #Auxiliar3
	DROP TABLE #Auxiliar4
	DROP TABLE #Auxiliar5
	DROP TABLE #Auxiliar6
	DROP TABLE #Auxiliar10
	DROP TABLE #Auxiliar20
	DROP TABLE #Auxiliar30
	RETURN
   END

UPDATE #Auxiliar1
SET Debe=Round(Debe*Cotizacion,2), Haber=Round(Haber*Cotizacion,2)

TRUNCATE TABLE #Auxiliar3

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Orden, BaseDatos, Numeral FROM #Auxiliar0 ORDER BY Orden, BaseDatos, Numeral
OPEN Cur
FETCH NEXT FROM Cur INTO @Orden, @BaseDatos, @Numeral
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF IsNull(@Numeral,1)=1
	   BEGIN
		SET @sql1='Select Null, P.BasePRONTOConsolidacion, P.PorcentajeConsolidacion From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
		SET @OrdenBase=''
	   END
	ELSE 
		IF IsNull(@Numeral,1)=2
		   BEGIN
			SET @sql1='Select Null, P.BasePRONTOConsolidacion2, P.PorcentajeConsolidacion2 From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
			SET @OrdenBase='2'
		   END
		ELSE
		   BEGIN
			SET @sql1='Select Null, P.BasePRONTOConsolidacion3, P.PorcentajeConsolidacion3 From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
			SET @OrdenBase='3'
		   END
	TRUNCATE TABLE #Auxiliar10
	INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
	SET @BaseDatosMadre=IsNull((Select Top 1 #Auxiliar10.Aux1 From #Auxiliar10),'')
	SET @Porcentaje=IsNull((Select Top 1 #Auxiliar10.Aux2 From #Auxiliar10),0)

	IF Len(@BaseDatosMadre)>0
	   BEGIN
		SET @sql1='Select C1.IdCuenta, C1.Codigo, C2.Codigo From '+@BaseDatos+'.dbo.Cuentas C1
				Left Outer Join '+@BaseDatosMadre+'.dbo.Cuentas C2 On C1.IdCuentaConsolidacion'+@OrdenBase+'=C2.IdCuenta'
		TRUNCATE TABLE #Auxiliar4
		INSERT INTO #Auxiliar4 EXEC sp_executesql @sql1

		TRUNCATE TABLE #Auxiliar2
		INSERT INTO #Auxiliar2 
		 SELECT * 
		 FROM #Auxiliar1 
		 WHERE BaseDatos=@BaseDatos and Numeral=@Numeral --and FechaGeneracionConsolidado is null
		UNION ALL 
		 SELECT BaseDatos, @Numeral, CodigoCuenta, Null, (Select Top 1 #Auxiliar4.CodigoCuentaMadre From #Auxiliar4 Where #Auxiliar4.CodigoCuenta=#Auxiliar3.CodigoCuenta), 
			Null, Null, Null, Null, Debe, Haber, 1, Null, MesRegistro, AñoRegistro 
		 FROM #Auxiliar3 
		 WHERE BaseDatos=@BaseDatos and Numeral=@Numeral

		UPDATE #Auxiliar2 SET BaseDatos=@BaseDatosMadre, Debe=Debe*@Porcentaje/100, Haber=Haber*@Porcentaje/100, CodigoCuenta=CodigoCuentaMadre, Cuenta=CuentaMadre

		INSERT INTO #Auxiliar3 
		 SELECT BaseDatos, Numeral, Max(@BaseDatos), CodigoCuenta, Sum(IsNull(Debe,0)), Sum(IsNull(Haber,0)), MesRegistro, AñoRegistro 
		 FROM #Auxiliar2 
		 GROUP BY BaseDatos, CodigoCuenta, Numeral, MesRegistro, AñoRegistro 
	   END

	FETCH NEXT FROM Cur INTO @Orden, @BaseDatos, @Numeral
   END
CLOSE Cur
DEALLOCATE Cur


DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Orden, BaseDatos, Numeral FROM #Auxiliar0 ORDER BY Orden, BaseDatos, Numeral
OPEN Cur
FETCH NEXT FROM Cur INTO @Orden, @BaseDatos, @Numeral
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF IsNull(@Numeral,1)=1
		SET @sql1='Select Null, P.BasePRONTOConsolidacion, P.PorcentajeConsolidacion From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
	ELSE 
		IF IsNull(@Numeral,1)=2
			SET @sql1='Select Null, P.BasePRONTOConsolidacion2, P.PorcentajeConsolidacion2 From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
		ELSE
			SET @sql1='Select Null, P.BasePRONTOConsolidacion3, P.PorcentajeConsolidacion3 From '+@BaseDatos+'.dbo.Parametros P Where P.IdParametro=1'
	TRUNCATE TABLE #Auxiliar10
	INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
	SET @BaseDatosMadre=IsNull((Select Top 1 #Auxiliar10.Aux1 From #Auxiliar10),'')

	IF Len(@BaseDatosMadre)>0
	   BEGIN
		--Buscar la cuenta contable para ajustar diferencias 
		SET @sql1='Select P.IdCuentaAjusteConsolidacion, Null, Null From '+@BaseDatosMadre+'.dbo.Parametros P Where P.IdParametro=1'
		TRUNCATE TABLE #Auxiliar10
		INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
		SET @IdCuentaAjusteConsolidacion=IsNull((Select Top 1 Identificador From #Auxiliar10),0)

		SET @sql1='Select C.Codigo, Null, Null From '+@BaseDatosMadre+'.dbo.Cuentas C Where C.IdCuenta='+Convert(varchar,@IdCuentaAjusteConsolidacion)
		TRUNCATE TABLE #Auxiliar10
		INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
		SET @CodigoCuentaAjusteConsolidacion=IsNull((Select Top 1 Identificador From #Auxiliar10),0)

		TRUNCATE TABLE #Auxiliar30
		INSERT INTO #Auxiliar30 
		 SELECT MesRegistro, AñoRegistro
		 FROM #Auxiliar3 
		 WHERE BaseDatos=@BaseDatosMadre and BaseDatosHija=@BaseDatos
		 GROUP BY MesRegistro, AñoRegistro

		DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT MesRegistro, AñoRegistro FROM #Auxiliar30 ORDER BY MesRegistro, AñoRegistro
		OPEN Cur1
		FETCH NEXT FROM Cur1 INTO @MesRegistro, @AñoRegistro
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			SET @Debe3=IsNull((Select Sum(Debe) From #Auxiliar3 Where BaseDatos=@BaseDatosMadre and BaseDatosHija=@BaseDatos and MesRegistro=@MesRegistro and AñoRegistro=@AñoRegistro),0)
			SET @Haber3=IsNull((Select Sum(Haber) From #Auxiliar3 Where BaseDatos=@BaseDatosMadre and BaseDatosHija=@BaseDatos and MesRegistro=@MesRegistro and AñoRegistro=@AñoRegistro),0)
			IF @Debe3<>@Haber3
			   BEGIN
				SET @SaldoDebe=0
				SET @SaldoHaber=0
				IF @Debe3-@Haber3>0 
					SET @SaldoHaber=@Debe3-@Haber3
				ELSE
					SET @SaldoDebe=Abs(@Debe3-@Haber3)
				INSERT INTO #Auxiliar3 
				 (BaseDatos, Numeral, BaseDatosHija, CodigoCuenta, Debe, Haber, MesRegistro, AñoRegistro)
				VALUES
				 (@BaseDatosMadre, IsNull(@Numeral,1), @BaseDatos, @CodigoCuentaAjusteConsolidacion, @SaldoDebe, @SaldoHaber, @MesRegistro, @AñoRegistro)
--select @BaseDatosMadre,@BaseDatos,@IdCuentaAjusteConsolidacion,@CodigoCuentaAjusteConsolidacion,@SaldoDebe,@SaldoHaber
			   END
			FETCH NEXT FROM Cur1 INTO @MesRegistro, @AñoRegistro
		   END
		CLOSE Cur1
		DEALLOCATE Cur1

		TRUNCATE TABLE #Auxiliar5
		INSERT INTO #Auxiliar5 
		 SELECT CodigoCuenta, Debe, Haber, Null, Null, MesRegistro, AñoRegistro 
		 FROM #Auxiliar20 
		 WHERE BaseDatos=@BaseDatosMadre and BaseConsolidadaHija=@BaseDatos
		UNION ALL 
		 SELECT CodigoCuenta, Null, Null, Debe, Haber, MesRegistro, AñoRegistro
		 FROM #Auxiliar3 
		 WHERE BaseDatos=@BaseDatosMadre and BaseDatosHija=@BaseDatos

--if @BaseDatosMadre='PruebaPronto1'
--if @Numeral=2
--Select @BaseDatos,@BaseDatosMadre,@Numeral,* From #Auxiliar1

		TRUNCATE TABLE #Auxiliar6
		INSERT INTO #Auxiliar6 
		 SELECT CodigoCuenta, Sum(IsNull(Debe1,0)), Sum(IsNull(Haber1,0)), Sum(IsNull(Debe2,0)), Sum(IsNull(Haber2,0)), MesRegistro, AñoRegistro
		 FROM #Auxiliar5 
		 GROUP BY CodigoCuenta, MesRegistro, AñoRegistro

		DELETE #Auxiliar6 WHERE Debe1-Haber1=Debe2-Haber2

		TRUNCATE TABLE #Auxiliar30
		INSERT INTO #Auxiliar30 
		 SELECT MesRegistro, AñoRegistro FROM #Auxiliar6 GROUP BY MesRegistro, AñoRegistro

		DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT MesRegistro, AñoRegistro FROM #Auxiliar30 ORDER BY MesRegistro, AñoRegistro
		OPEN Cur1
		FETCH NEXT FROM Cur1 INTO @MesRegistro, @AñoRegistro
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			SET @Registros=(Select Count(*) From #Auxiliar6 Where MesRegistro=@MesRegistro and AñoRegistro=@AñoRegistro)
			IF @Registros>0 
			   BEGIN
				--Buscar el proximo numero de asiento en la base madre 
				SET @sql1='Select P.ProximoAsiento, Null, Null From '+@BaseDatosMadre+'.dbo.Parametros P Where P.IdParametro=1'
				TRUNCATE TABLE #Auxiliar10
				INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
				SET @NumeroAsiento=IsNull((Select Top 1 Identificador From #Auxiliar10),1)
				
				--Insertar la cabecera del asiento y leer el id generado
				SET @FechaRegistroAsiento=Convert(datetime,'1/'+Convert(varchar,@MesRegistro)+'/'+Convert(varchar,@AñoRegistro))
				SET @FechaRegistroAsiento=DateAdd(d,-1,DateAdd(m,1,@FechaRegistroAsiento))
				IF @FechaRegistroAsiento>GetDate()
					SET @FechaRegistroAsiento=GetDate()
				SET @sql1='Insert Into '+@BaseDatosMadre+'.dbo.Asientos 
						(NumeroAsiento, FechaAsiento, Concepto, IdIngreso, FechaIngreso, BaseConsolidadaHija, FechaGeneracionConsolidado)
						Values 
						('+Convert(varchar,@NumeroAsiento)+', '''+Convert(varchar,@FechaRegistroAsiento,103)+''', 
						 ''CONSOLIDACION DESDE '+@BaseDatos+''',  0, '''+Convert(varchar,GetDate())+''', '''+@BaseDatos+''', '''+Convert(varchar,GetDate())+''')
						Select @@identity, Null, Null'
				TRUNCATE TABLE #Auxiliar10
				INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
				SET @IdAsiento=IsNull((Select Top 1 Identificador From #Auxiliar10),0)
		
				--Incrementar el numerador de asientos
				SET @NumeroAsiento=@NumeroAsiento+1
				SET @sql1='Update '+@BaseDatosMadre+'.dbo.Parametros Set ProximoAsiento='+Convert(varchar,@NumeroAsiento)+' Where IdParametro=1'
				EXEC sp_executesql @sql1
		
				SET @Item=0
				SET @Debe3=0
				SET @Haber3=0
				DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT CodigoCuenta, Debe1, Haber1, Debe2, Haber2 FROM #Auxiliar6 WHERE MesRegistro=@MesRegistro and AñoRegistro=@AñoRegistro ORDER BY CodigoCuenta
				OPEN Cur2
				FETCH NEXT FROM Cur2 INTO @CodigoCuenta, @Debe1, @Haber1, @Debe2, @Haber2 
				WHILE @@FETCH_STATUS = 0
				   BEGIN
					--Insertar un detalle asiento
					SET @sql1='Select C.IdCuenta, Null, Null From '+@BaseDatosMadre+'.dbo.Cuentas C Where C.Codigo='+Convert(varchar,@CodigoCuenta)
					TRUNCATE TABLE #Auxiliar10
					INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1
					SET @IdCuenta=IsNull((Select Top 1 Identificador From #Auxiliar10),0)
		
					SET @SaldoDebe=0
					SET @SaldoHaber=0
					IF @Debe2-@Debe1>0 
						SET @SaldoDebe=@SaldoDebe+(@Debe2-@Debe1)
					ELSE
						SET @SaldoHaber=@SaldoHaber+Abs(@Debe2-@Debe1)
					IF @Haber2-@Haber1>0
						SET @SaldoHaber=@SaldoHaber+(@Haber2-@Haber1)
					ELSE
						SET @SaldoDebe=@SaldoDebe+Abs(@Haber2-@Haber1)
					IF @SaldoDebe-@SaldoHaber>=0
					   BEGIN
						SET @SaldoDebe=@SaldoDebe-@SaldoHaber
						SET @SaldoHaber=0
					   END
					ELSE 
					   BEGIN
						SET @SaldoHaber=@SaldoHaber-@SaldoDebe
						SET @SaldoDebe=0
					   END
					SET @Item=@Item+1
					SET @sql1='Insert Into '+@BaseDatosMadre+'.dbo.DetalleAsientos 
							(IdAsiento, IdCuenta, Debe, Haber, IdMoneda, CotizacionMoneda, IdMonedaDestino, CotizacionMonedaDestino, ImporteEnMonedaDestino, Item)
							Values 
							('+Convert(varchar,@IdAsiento)+', '+Convert(varchar,@IdCuenta)+', '+Convert(varchar,@SaldoDebe)+', '+Convert(varchar,@SaldoHaber)+', 
							 1, 1, 1, 1, '+Convert(varchar,Abs(@SaldoDebe-@SaldoHaber))+', '+Convert(varchar,@Item)+')'
					EXEC sp_executesql @sql1
					SET @Debe3=@Debe3+@SaldoDebe
					SET @Haber3=@Haber3+@SaldoHaber
					FETCH NEXT FROM Cur2 INTO @CodigoCuenta, @Debe1, @Haber1, @Debe2, @Haber2 
				   END
				CLOSE Cur2
				DEALLOCATE Cur2
			   END
			FETCH NEXT FROM Cur1 INTO @MesRegistro, @AñoRegistro
		   END
		CLOSE Cur1
		DEALLOCATE Cur1
	   END
	FETCH NEXT FROM Cur INTO @Orden, @BaseDatos, @Numeral
   END
CLOSE Cur
DEALLOCATE Cur

--select * from #Auxiliar1
--order by BaseDatos, CodigoCuenta

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar00
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar20
DROP TABLE #Auxiliar30