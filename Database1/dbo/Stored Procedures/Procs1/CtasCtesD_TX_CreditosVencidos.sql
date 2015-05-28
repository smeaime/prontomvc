CREATE Procedure [dbo].[CtasCtesD_TX_CreditosVencidos]

@ActivaFechas int,
@FechaDesde datetime,
@FechaHasta datetime,
@VentasEnCuotas varchar(2),
@ConCreditosNoAplicados varchar(2),
@ActivaRango int,
@DesdeAlfa varchar(100),
@HastaAlfa varchar(100),
@Vendedor int,
@Cobrador int,
@FiltraSaldos0 varchar(2) = Null,
@RegistrosResumidos varchar(2) = Null,
@ModeloRegistrosResumidos varchar(20) = Null

AS 

SET NOCOUNT ON

SET @FiltraSaldos0=Isnull(@FiltraSaldos0,'SI')
SET @RegistrosResumidos=IsNull(@RegistrosResumidos,'NO')
SET @ModeloRegistrosResumidos=IsNull(@ModeloRegistrosResumidos,'')

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int,
		@IdTipoComprobanteRecibo int, @IdClienteProc int, @ModeloEmision varchar(10), 
		@ConsolidacionDeBDs VARCHAR(2), @NombreServidorWeb VARCHAR(100), @UsuarioServidorWeb VARCHAR(50), @PasswordServidorWeb VARCHAR(50), @BaseDeDatosServidorWeb VARCHAR(50), 
		@proc_name varchar(1000)

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

SET @IdClienteProc=-1
SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @ModeloEmision=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Modelo para informe clientes creditos vencidos a fecha'),'')

CREATE TABLE #Auxiliar1 
			(
			 IdCtaCte INTEGER,
			 IdCliente INTEGER,
			 Codigo VARCHAR(10),
			 Cliente VARCHAR(100),
			 FechaVencimiento DATETIME,
			 Comprobante VARCHAR(20),
			 IdImputacion INTEGER,
			 ImporteTotal NUMERIC(12,2),
			 Saldo NUMERIC(12,2),
			 Dias INTEGER,
			 FechaComprobante DATETIME,
			 Contacto VARCHAR(50),
			 Telefono VARCHAR(50),
			 Direccion VARCHAR(100),
			 DireccionEntrega VARCHAR(50),
			 Localidad VARCHAR(50),
			 CodigoPostal VARCHAR(20),
			 Provincia VARCHAR(50),
			 Pais VARCHAR(50),
			 Vendedor VARCHAR(50),
			 Cobrador VARCHAR(50),
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdCtaCte) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar1 (IdCliente, IdImputacion) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  Clientes.IdCliente,
  Clientes.Codigo,
  Clientes.RazonSocial,
  Case When @ModeloEmision='Modelo1' or @ModeloEmision='Modelo3' Then CtaCte.Fecha Else IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha) End,
  Case 	When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Facturas.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Devoluciones.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasDebito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasCredito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
	 Then TiposComprobante.DescripcionAb+' '+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
		IsNull(Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	 Else TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
  End,
  IsNull(CtaCte.IdImputacion,0),
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal,
  DateDiff(day,IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha),@FechaHasta),
  CtaCte.Fecha,
  Clientes.Contacto,
  Clientes.Telefono,
  Clientes.Direccion,
  Clientes.DireccionEntrega,
  Localidades.Nombre,
  Clientes.CodigoPostal,
  Provincias.Nombre,
  Paises.Descripcion,
  V1.Nombre,
  V2.Nombre,
  CtaCte.IdTipoComp,
  CtaCte.IdComprobante
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad = Localidades.IdLocalidad
 LEFT OUTER JOIN Provincias ON Clientes.IdProvincia = Provincias.IdProvincia
 LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 LEFT OUTER JOIN Vendedores V1 ON V1.IdVendedor=IsNull(Facturas.IdVendedor,IsNull(Devoluciones.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,IsNull(Recibos.IdVendedor,IsNull(Clientes.Vendedor1,0))))))
 LEFT OUTER JOIN Vendedores V2 ON V2.IdVendedor=IsNull(Recibos.IdCobrador,IsNull(Clientes.Cobrador,0))
 WHERE TiposComprobante.Coeficiente=1 and 
	(@ActivaFechas=-1 or CtaCte.Fecha between @FechaDesde and @FechaHasta) and 
	(@VentasEnCuotas='NO' or (@VentasEnCuotas='SI' and NotasDebito.IdVentaEnCuotas is not null)) and 
	(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa)) and 
	(@Vendedor=-1 or @Vendedor=Clientes.Vendedor1) and 
	(@Cobrador=-1 or @Cobrador=Clientes.Cobrador) and 
	(@IdClienteProc=-1 or @IdClienteProc=CtaCte.IdCliente)

CREATE TABLE #Auxiliar2 
			(
			 IdCtaCte INTEGER,
			 IdCliente INTEGER,
			 FechaVencimiento DATETIME,
			 Comprobante VARCHAR(20),
			 IdImputacion INTEGER,
			 ImporteTotal NUMERIC(12,2),
			 Saldo NUMERIC(12,2),
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCtaCte,
  Clientes.IdCliente,
  Case When @ModeloEmision='Modelo1' or @ModeloEmision='Modelo3' Then CtaCte.Fecha Else IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha) End,
  Case 	When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Facturas.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Devoluciones.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasDebito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasCredito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
	 Then TiposComprobante.DescripcionAb+' '+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
		IsNull(Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	 Else TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
  End,
  IsNull(CtaCte.IdImputacion,0),
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal,
  CtaCte.IdTipoComp,
  CtaCte.IdComprobante
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad = Localidades.IdLocalidad
 LEFT OUTER JOIN Provincias ON Clientes.IdProvincia = Provincias.IdProvincia
 LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE TiposComprobante.Coeficiente=-1 and 
	(@ActivaFechas=-1 or (@ModeloEmision='Modelo3' and @ModeloRegistrosResumidos<>'Resumen1') or CtaCte.Fecha between @FechaDesde and @FechaHasta) and 
	(@VentasEnCuotas='NO' or (@VentasEnCuotas='SI' and NotasDebito.IdVentaEnCuotas is not null)) and 
	(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa)) and 
	(@Vendedor=-1 or @Vendedor=Clientes.Vendedor1) and 
	(@Cobrador=-1 or @Cobrador=Clientes.Cobrador) and 
	(@IdClienteProc=-1 or @IdClienteProc=CtaCte.IdCliente)

UPDATE #Auxiliar1
SET FechaVencimiento=Convert(datetime,@FechaHasta,103)
WHERE FechaVencimiento Is Null

UPDATE #Auxiliar2
SET FechaVencimiento=Convert(datetime,@FechaHasta,103)
WHERE FechaVencimiento Is Null

/*  CURSORES  */
DECLARE @Corte int, @Fecha datetime, @SaldoAAplicar numeric(18,2), @SaldoAplicado numeric(18,2), 
	@IdCtaCte1 int, @IdCliente1 int, @IdImputacion1 int, @ImporteTotal1 numeric(18,2), @Saldo1 numeric(18,2), 
	@IdCtaCte2 int, @IdCliente2 int, @IdImputacion2 int, @ImporteTotal2 numeric(18,2), @Saldo2 numeric(18,2)
	
DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdCtaCte, IdCliente, IdImputacion, ImporteTotal, Saldo FROM #Auxiliar2 WHERE Saldo<>0 ORDER BY IdImputacion, FechaVencimiento 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdCliente1, @IdImputacion1, @ImporteTotal1, @Saldo1
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @SaldoAAplicar=@Saldo1
	SET @Corte=@IdImputacion1

	DECLARE CtaCte2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdCtaCte, IdCliente, IdImputacion, ImporteTotal, Saldo FROM #Auxiliar1 WHERE IdCliente=@IdCliente1 and Saldo<>0 and IdImputacion=@Corte ORDER BY Saldo, FechaVencimiento 
	OPEN CtaCte2
	FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdCliente2, @IdImputacion2, @ImporteTotal2, @Saldo2
	WHILE @@FETCH_STATUS = 0 and not @SaldoAAplicar=0
	  BEGIN
		IF @SaldoAAplicar>=@Saldo2
		  BEGIN
			SET @SaldoAAplicar=@SaldoAAplicar-@Saldo2
			SET @SaldoAplicado=0
		  END
		ELSE
		  BEGIN
			SET @SaldoAplicado=@Saldo2-@SaldoAAplicar
			SET @SaldoAAplicar=0
		  END

		UPDATE #Auxiliar1
		SET Saldo = @SaldoAplicado
		WHERE IdCtaCte=@IdCtaCte2

		FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdCliente2, @IdImputacion2, @ImporteTotal2, @Saldo2
	  END
	CLOSE CtaCte2
	DEALLOCATE CtaCte2

	UPDATE #Auxiliar2
	SET Saldo = @SaldoAAplicar
	WHERE IdCtaCte=@IdCtaCte1

	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdCliente1, @IdImputacion1, @ImporteTotal1, @Saldo1
  END
CLOSE CtaCte1
DEALLOCATE CtaCte1

IF @ConCreditosNoAplicados='SI'
   BEGIN
	IF @ModeloEmision='Modelo1' or @ModeloEmision='Modelo4'
	   BEGIN
		INSERT INTO #Auxiliar1 
		 SELECT 
		  #Auxiliar2.IdCtaCte,
		  #Auxiliar2.IdCliente,
		  Clientes.Codigo,
		  Clientes.RazonSocial,
		  #Auxiliar2.FechaVencimiento,
		  #Auxiliar2.Comprobante,
		  #Auxiliar2.IdImputacion,
		  #Auxiliar2.ImporteTotal,
		  IsNull(#Auxiliar2.Saldo,0)*-1,
		  1,
		  #Auxiliar2.FechaVencimiento,
		  Clientes.Contacto,
		  Clientes.Telefono,
		  Clientes.Direccion,
		  Clientes.DireccionEntrega,
		  Localidades.Nombre,
		  Clientes.CodigoPostal,
		  Provincias.Nombre,
		  Paises.Descripcion,
		  V1.Nombre,
		  V2.Nombre,
		  #Auxiliar2.IdTipoComprobante,
		  #Auxiliar2.IdComprobante
		 FROM #Auxiliar2
		 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar2.IdCliente
		 LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad = Localidades.IdLocalidad
		 LEFT OUTER JOIN Provincias ON Clientes.IdProvincia = Provincias.IdProvincia
		 LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
		 LEFT OUTER JOIN Vendedores V1 ON V1.IdVendedor=IsNull(Clientes.Vendedor1,0)
		 LEFT OUTER JOIN Vendedores V2 ON V2.IdVendedor=IsNull(Clientes.Cobrador,0)
	   END
	ELSE
	   BEGIN
		INSERT INTO #Auxiliar1 
		 SELECT 
		  0,
		  #Auxiliar2.IdCliente,
		  Clientes.Codigo,
		  Clientes.RazonSocial,
		  @FechaHasta,
		  'Creditos n/aplicados',
		  Null,
		  Null,
		  Sum(IsNull(#Auxiliar2.Saldo,0))*-1,
		  1,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null,
		  Null
		 FROM #Auxiliar2
		 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar2.IdCliente
		 GROUP BY #Auxiliar2.IdCliente, Clientes.Codigo, Clientes.RazonSocial
	   END
   END

IF @FiltraSaldos0='SI'
	DELETE FROM #Auxiliar1
	WHERE IsNull(Saldo,0)=0

SET NOCOUNT OFF

DECLARE @vector_X varchar(60), @vector_T varchar(60)

IF @RegistrosResumidos='SI'
   BEGIN
	IF @ModeloRegistrosResumidos=''
		IF @ModeloEmision='Modelo4'
		   BEGIN
			SET NOCOUNT ON
			CREATE TABLE #Auxiliar3 
						(
						 IdAux INTEGER,
						 K_Orden INTEGER,
						 FechaVencimiento DATETIME,
						 Codigo VARCHAR(10),
						 Cliente VARCHAR(100),
						 Comprobante VARCHAR(20),
						 ImporteTotal NUMERIC(12,2),
						 Saldo NUMERIC(12,2),
						 FechaComprobante DATETIME,
						 Contacto VARCHAR(50),
						 Telefono VARCHAR(50),
						 Direccion VARCHAR(100),
						 DireccionEntrega VARCHAR(50),
						 Localidad VARCHAR(50),
						 CodigoPostal VARCHAR(20),
						 Provincia VARCHAR(50),
						 Pais VARCHAR(50),
						 Vendedor VARCHAR(50),
						 Cobrador VARCHAR(50),
						 IdTipoComprobante INTEGER,
						 IdComprobante INTEGER
						)

			IF Len(@NombreServidorWeb)>0
			   BEGIN
				EXEC sp_addlinkedserver @NombreServidorWeb
				SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.CtasCtesD_TX_CreditosVencidos'
				INSERT INTO #Auxiliar3 
					EXECUTE @proc_name @ActivaFechas,@FechaDesde,@FechaHasta, @VentasEnCuotas, @ConCreditosNoAplicados, @ActivaRango, @DesdeAlfa, @HastaAlfa, @Vendedor, @Cobrador, @FiltraSaldos0, @RegistrosResumidos, @ModeloRegistrosResumidos
				UPDATE #Auxiliar3
				SET K_Orden=10
				EXEC sp_dropserver @NombreServidorWeb
			   END

			INSERT INTO #Auxiliar3 
				SELECT 0, 11, #Auxiliar1.FechaVencimiento, #Auxiliar1.Codigo, #Auxiliar1.Cliente, #Auxiliar1.Comprobante, Abs(#Auxiliar1.ImporteTotal)*IsNull(TiposComprobante.Coeficiente,1), 
						Abs(#Auxiliar1.Saldo)*IsNull(TiposComprobante.Coeficiente,1), #Auxiliar1.FechaComprobante, #Auxiliar1.Contacto, #Auxiliar1.Telefono, #Auxiliar1.Direccion, 
						#Auxiliar1.DireccionEntrega, #Auxiliar1.Localidad, #Auxiliar1.CodigoPostal, #Auxiliar1.Provincia, #Auxiliar1.Pais, #Auxiliar1.Vendedor, #Auxiliar1.Cobrador, 
						#Auxiliar1.IdTipoComprobante, #Auxiliar1.IdComprobante
				FROM #Auxiliar1
				LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=#Auxiliar1.IdTipoComprobante
			SET NOCOUNT OFF

			SELECT * FROM #Auxiliar3 ORDER BY Vendedor, Cliente, Codigo, K_Orden, FechaVencimiento, Comprobante
			DROP TABLE #Auxiliar3
		   END
	ELSE
		   BEGIN
			SELECT 
			 0 as [IdAux],
			 1 as [K_Orden],
			 #Auxiliar1.FechaVencimiento as [K_FechaVencimiento],
			 #Auxiliar1.Codigo as [Codigo],
			 #Auxiliar1.Cliente as [Cliente],
			 #Auxiliar1.Comprobante as [Comprobante],
			 #Auxiliar1.ImporteTotal as [Importe total],
			 #Auxiliar1.Saldo as [Saldo],
			 Case When #Auxiliar1.Dias>=0 Then #Auxiliar1.Dias Else Null End as [Ds.Venc.],
			 Case When #Auxiliar1.Dias>=0 Then Null Else #Auxiliar1.Dias End as [Ds.A Vencer],
			 Case When #Auxiliar1.Dias>0 Then #Auxiliar1.Saldo Else Null End as [Vencido],
			 Case When #Auxiliar1.Dias>=0 and #Auxiliar1.Dias<=10 Then #Auxiliar1.Saldo Else Null End as [0 a 10 dias],
			 Case When #Auxiliar1.Dias>10 and #Auxiliar1.Dias<=30 Then #Auxiliar1.Saldo Else Null End as [11 a 30 dias],
			 Case When #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60 Then #Auxiliar1.Saldo Else Null End as [31 a 60 dias],
			 Case When #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=90 Then #Auxiliar1.Saldo Else Null End as [61 a 90 dias],
			 Case When #Auxiliar1.Dias>90 and #Auxiliar1.Dias<=120 Then #Auxiliar1.Saldo Else Null End as [91 a 120 dias],
			 Case When #Auxiliar1.Dias>120 and #Auxiliar1.Dias<=150 Then #Auxiliar1.Saldo Else Null End as [121 a 150 dias],
			 Case When #Auxiliar1.Dias>150 and #Auxiliar1.Dias<=180 Then #Auxiliar1.Saldo Else Null End as [151 a 180 dias],
			 Case When #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=270 Then #Auxiliar1.Saldo Else Null End as [181 a 270 dias],
			 Case When #Auxiliar1.Dias>270 and #Auxiliar1.Dias<=365 Then #Auxiliar1.Saldo Else Null End as [271 a 365 dias],
			 Case When #Auxiliar1.Dias>365 and #Auxiliar1.Dias<=730 Then #Auxiliar1.Saldo Else Null End as [1 a 2 años],
			 Case When #Auxiliar1.Dias>730 and #Auxiliar1.Dias<=1095 Then #Auxiliar1.Saldo Else Null End as [2 a 3 años],
			 Case When #Auxiliar1.Dias>1095 Then #Auxiliar1.Saldo Else Null End as [Mas de 3 años],
			 #Auxiliar1.FechaComprobante as [Fecha Comp.],
			 #Auxiliar1.Contacto as [Contacto],
			 #Auxiliar1.Telefono as [Telefono],
			 #Auxiliar1.Direccion as [Direccion],
			 #Auxiliar1.DireccionEntrega as [Direccion entrega],
			 #Auxiliar1.Localidad as [Localidad],
			 #Auxiliar1.CodigoPostal as [Cod.Pos.],
			 #Auxiliar1.Provincia as [Provincia],
			 #Auxiliar1.Pais as [Pais],
			 #Auxiliar1.Vendedor as [Vendedor],
			 #Auxiliar1.Cobrador as [Cobrador],
			 #Auxiliar1.IdTipoComprobante as [IdTipoComprobante],
			 #Auxiliar1.IdComprobante as [IdComprobante]
			FROM #Auxiliar1
			ORDER BY [Cliente], [Codigo], [K_Orden], [K_FechaVencimiento], [Comprobante]
		   END

	IF @ModeloRegistrosResumidos='Resumen1'
	   BEGIN
		SELECT Sum(IsNull(#Auxiliar1.Saldo,0)) FROM #Auxiliar1 WHERE #Auxiliar1.Dias<=30 
		UNION ALL
		SELECT Sum(IsNull(#Auxiliar1.Saldo,0)) FROM #Auxiliar1 WHERE #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60
		UNION ALL
		SELECT Sum(IsNull(#Auxiliar1.Saldo,0)) FROM #Auxiliar1 WHERE #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=180
		UNION ALL
		SELECT Sum(IsNull(#Auxiliar1.Saldo,0)) FROM #Auxiliar1 WHERE #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=365
		UNION ALL
		SELECT Sum(IsNull(#Auxiliar1.Saldo,0)) FROM #Auxiliar1 WHERE #Auxiliar1.Dias>365
	   END
   END

ELSE

   BEGIN
	IF @ModeloEmision='Modelo1' or @ModeloEmision='Modelo3'
	   BEGIN
		SET @vector_X='00001111661111111111111111111111111133'
		SET @vector_T='00004228442922222222222224111111111100'
	
		SELECT 
		 0 as [IdAux],
		 #Auxiliar1.Codigo as [K_Codigo],
		 #Auxiliar1.FechaVencimiento as [K_FechaVencimiento],
		 1 as [K_Orden],
		 #Auxiliar1.FechaVencimiento as [Fecha vto.],
		 #Auxiliar1.Codigo as [Codigo],
		 #Auxiliar1.Cliente as [Cliente],
		 #Auxiliar1.Comprobante as [Comprobante],
		 #Auxiliar1.ImporteTotal as [Importe total],
		 #Auxiliar1.Saldo as [Saldo],
		 Case When #Auxiliar1.Dias>=0 Then #Auxiliar1.Dias Else Null End as [Ds.Venc.],
		 Case When #Auxiliar1.Dias>=0 Then Null Else #Auxiliar1.Dias End as [Ds.A Vencer],
		 Case When #Auxiliar1.Dias>0 Then #Auxiliar1.Saldo Else Null End as [Vencido],
		 Case When #Auxiliar1.Dias>=0 and #Auxiliar1.Dias<=10 Then #Auxiliar1.Saldo Else Null End as [0 a 10 dias],
		 Case When #Auxiliar1.Dias>10 and #Auxiliar1.Dias<=30 Then #Auxiliar1.Saldo Else Null End as [11 a 30 dias],
		 Case When #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60 Then #Auxiliar1.Saldo Else Null End as [31 a 60 dias],
		 Case When #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=90 Then #Auxiliar1.Saldo Else Null End as [61 a 90 dias],
		 Case When #Auxiliar1.Dias>90 and #Auxiliar1.Dias<=120 Then #Auxiliar1.Saldo Else Null End as [91 a 120 dias],
		 Case When #Auxiliar1.Dias>120 and #Auxiliar1.Dias<=150 Then #Auxiliar1.Saldo Else Null End as [121 a 150 dias],
		 Case When #Auxiliar1.Dias>150 and #Auxiliar1.Dias<=180 Then #Auxiliar1.Saldo Else Null End as [151 a 180 dias],
		 Case When #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=270 Then #Auxiliar1.Saldo Else Null End as [181 a 270 dias],
		 Case When #Auxiliar1.Dias>270 and #Auxiliar1.Dias<=365 Then #Auxiliar1.Saldo Else Null End as [271 a 365 dias],
		 Case When #Auxiliar1.Dias>365 and #Auxiliar1.Dias<=730 Then #Auxiliar1.Saldo Else Null End as [1 a 2 años],
		 Case When #Auxiliar1.Dias>730 and #Auxiliar1.Dias<=1095 Then #Auxiliar1.Saldo Else Null End as [2 a 3 años],
		 Case When #Auxiliar1.Dias>1095 Then #Auxiliar1.Saldo Else Null End as [Mas de 3 años],
		 #Auxiliar1.FechaComprobante as [Fecha Comp.],
		 #Auxiliar1.Contacto as [Contacto],
		 #Auxiliar1.Telefono as [Telefono],
		 #Auxiliar1.Direccion as [Direccion],
		 #Auxiliar1.DireccionEntrega as [Direccion entrega],
		 #Auxiliar1.Localidad as [Localidad],
		 #Auxiliar1.CodigoPostal as [Cod.Pos.],
		 #Auxiliar1.Provincia as [Provincia],
		 #Auxiliar1.Pais as [Pais],
		 #Auxiliar1.Vendedor as [Vendedor],
		 #Auxiliar1.Cobrador as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
	
		UNION ALL 
	
		SELECT 
		 0 as [IdAux],
		 #Auxiliar1.Codigo as [K_Codigo],
		 Null as [K_FechaVencimiento],
		 2 as [K_Orden],
		 Null as [Fecha vto.],
		 Null as [Codigo],
		 Null as [Cliente],
		 '    TOTAL CLIENTE' as [Comprobante],
		 SUM(#Auxiliar1.ImporteTotal) as [Importe total],
		 SUM(#Auxiliar1.Saldo) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.Dias>0 Then #Auxiliar1.Saldo Else 0 End) as [Vencido],
		 SUM(Case When #Auxiliar1.Dias>=0 and #Auxiliar1.Dias<=10 Then #Auxiliar1.Saldo Else 0 End) as [0 a 10 dias],
		 SUM(Case When #Auxiliar1.Dias>10 and #Auxiliar1.Dias<=30 Then #Auxiliar1.Saldo Else 0 End) as [11 a 30 dias],
		 SUM(Case When #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60 Then #Auxiliar1.Saldo Else 0 End) as [31 a 60 dias],
		 SUM(Case When #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=90 Then #Auxiliar1.Saldo Else 0 End) as [61 a 90 dias],
		 SUM(Case When #Auxiliar1.Dias>90 and #Auxiliar1.Dias<=120 Then #Auxiliar1.Saldo Else 0 End) as [91 a 120 dias],
		 SUM(Case When #Auxiliar1.Dias>120 and #Auxiliar1.Dias<=150 Then #Auxiliar1.Saldo Else 0 End) as [121 a 150 dias],
		 SUM(Case When #Auxiliar1.Dias>150 and #Auxiliar1.Dias<=180 Then #Auxiliar1.Saldo Else 0 End) as [151 a 180 dias],
		 SUM(Case When #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=270 Then #Auxiliar1.Saldo Else 0 End) as [181 a 270 dias],
		 SUM(Case When #Auxiliar1.Dias>270 and #Auxiliar1.Dias<=365 Then #Auxiliar1.Saldo Else 0 End) as [271 a 365 dias],
		 SUM(Case When #Auxiliar1.Dias>365 and #Auxiliar1.Dias<=730 Then #Auxiliar1.Saldo Else 0 End) as [1 a 2 años],
		 SUM(Case When #Auxiliar1.Dias>730 and #Auxiliar1.Dias<=1095 Then #Auxiliar1.Saldo Else 0 End) as [2 a 3 años],
		 SUM(Case When #Auxiliar1.Dias>1095 Then #Auxiliar1.Saldo Else 0 End) as [Mas de 3 años],
		 Null as [Fecha Comp.],
		 Null as [Contacto],
		 Null as [Telefono],
		 Null as [Direccion],
		 Null as [Direccion entrega],
		 Null as [Localidad],
		 Null as [Cod.Pos.],
		 Null as [Provincia],
		 Null as [Pais],
		 Null as [Vendedor],
		 Null as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
		GROUP BY #Auxiliar1.Codigo
	
		UNION ALL 
	
		SELECT 
		 0 as [IdAux],
		 #Auxiliar1.Codigo as [K_Codigo],
		 Null as [K_FechaVencimiento],
		 3 as [K_Orden],
		 Null as [Fecha vto.],
		 Null as [Codigo],
		 Null as [Cliente],
		 Null as [Comprobante],
		 Null as [Importe total],
		 Null as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 Null as [Vencido],
		 Null as [0 a 10 dias],
		 Null as [11 a 30 dias],
		 Null as [31 a 60 dias],
		 Null as [61 a 90 dias],
		 Null as [91 a 120 dias],
		 Null as [121 a 150 dias],
		 Null as [151 a 180 dias],
		 Null as [181 a 270 dias],
		 Null as [271 a 365 dias],
		 Null as [1 a 2 años],
		 Null as [2 a 3 años],
		 Null as [Mas de 3 años],
		 Null as [Fecha Comp.],
		 Null as [Contacto],
		 Null as [Telefono],
		 Null as [Direccion],
		 Null as [Direccion entrega],
		 Null as [Localidad],
		 Null as [Cod.Pos.],
		 Null as [Provincia],
		 Null as [Pais],
		 Null as [Vendedor],
		 Null as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
		GROUP BY #Auxiliar1.Codigo
	
		UNION ALL 
	
		SELECT 
		 0 as [IdAux],
		 'zzzzz' as [K_Codigo],
		 Null as [K_FechaVencimiento],
		 4 as [K_Orden],
		 Null as [Fecha vto.],
		 Null as [Codigo],
		 Null as [Cliente],
		 '    TOTAL GENERAL' as [Comprobante],
		 SUM(#Auxiliar1.ImporteTotal) as [Importe total],
		 SUM(#Auxiliar1.Saldo) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.Dias>0 Then #Auxiliar1.Saldo Else 0 End) as [Vencido],
		 SUM(Case When #Auxiliar1.Dias>=0 and #Auxiliar1.Dias<=10 Then #Auxiliar1.Saldo Else 0 End) as [0 a 10 dias],
		 SUM(Case When #Auxiliar1.Dias>10 and #Auxiliar1.Dias<=30 Then #Auxiliar1.Saldo Else 0 End) as [11 a 30 dias],
		 SUM(Case When #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60 Then #Auxiliar1.Saldo Else 0 End) as [31 a 60 dias],
		 SUM(Case When #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=90 Then #Auxiliar1.Saldo Else 0 End) as [61 a 90 dias],
		 SUM(Case When #Auxiliar1.Dias>90 and #Auxiliar1.Dias<=120 Then #Auxiliar1.Saldo Else 0 End) as [91 a 120 dias],
		 SUM(Case When #Auxiliar1.Dias>120 and #Auxiliar1.Dias<=150 Then #Auxiliar1.Saldo Else 0 End) as [121 a 150 dias],
		 SUM(Case When #Auxiliar1.Dias>150 and #Auxiliar1.Dias<=180 Then #Auxiliar1.Saldo Else 0 End) as [151 a 180 dias],
		 SUM(Case When #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=270 Then #Auxiliar1.Saldo Else 0 End) as [181 a 270 dias],
		 SUM(Case When #Auxiliar1.Dias>270 and #Auxiliar1.Dias<=365 Then #Auxiliar1.Saldo Else 0 End) as [271 a 365 dias],
		 SUM(Case When #Auxiliar1.Dias>365 and #Auxiliar1.Dias<=730 Then #Auxiliar1.Saldo Else 0 End) as [1 a 2 años],
		 SUM(Case When #Auxiliar1.Dias>730 and #Auxiliar1.Dias<=1095 Then #Auxiliar1.Saldo Else 0 End) as [2 a 3 años],
		 SUM(Case When #Auxiliar1.Dias>1095 Then #Auxiliar1.Saldo Else 0 End) as [Mas de 3 años],
		 Null as [Fecha Comp.],
		 Null as [Contacto],
		 Null as [Telefono],
		 Null as [Direccion],
		 Null as [Direccion entrega],
		 Null as [Localidad],
		 Null as [Cod.Pos.],
		 Null as [Provincia],
		 Null as [Pais],
		 Null as [Vendedor],
		 Null as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
	
		ORDER BY [K_Codigo], [K_Orden], [K_FechaVencimiento]
	   END
	ELSE
	   BEGIN
		SET @vector_X='00001111661111111111111111111111111111111111111133'
		SET @vector_T='00004228442222222222222222222222222224111111111100'
	
		SELECT 
		 0 as [IdAux],
		 #Auxiliar1.Codigo as [K_Codigo],
		 #Auxiliar1.FechaVencimiento as [K_FechaVencimiento],
		 1 as [K_Orden],
		 #Auxiliar1.FechaVencimiento as [Fecha vto.],
		 #Auxiliar1.Codigo as [Codigo],
		 #Auxiliar1.Cliente as [Cliente],
		 #Auxiliar1.Comprobante as [Comprobante],
		 #Auxiliar1.ImporteTotal as [Importe total],
		 #Auxiliar1.Saldo as [Saldo],
		 Case When #Auxiliar1.Dias>=0 Then #Auxiliar1.Dias Else Null End as [Ds.Venc.],
		 Case When #Auxiliar1.Dias>=0 Then Null Else #Auxiliar1.Dias End as [Ds.A Vencer],
		 Case When #Auxiliar1.Dias>0 Then #Auxiliar1.Saldo Else Null End as [Vencido],
	
		 Case When #Auxiliar1.Dias>1095 Then #Auxiliar1.Saldo Else Null End as [Mas de -3 años],
		 Case When #Auxiliar1.Dias>730 and #Auxiliar1.Dias<=1095 Then #Auxiliar1.Saldo Else Null End as [-3 a -2 años],
		 Case When #Auxiliar1.Dias>365 and #Auxiliar1.Dias<=730 Then #Auxiliar1.Saldo Else Null End as [-2 a -1 años],
		 Case When #Auxiliar1.Dias>270 and #Auxiliar1.Dias<=365 Then #Auxiliar1.Saldo Else Null End as [-365 a -270 dias],
		 Case When #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=270 Then #Auxiliar1.Saldo Else Null End as [-270 a -180 dias],
		 Case When #Auxiliar1.Dias>150 and #Auxiliar1.Dias<=180 Then #Auxiliar1.Saldo Else Null End as [-180 a -150 dias],
		 Case When #Auxiliar1.Dias>120 and #Auxiliar1.Dias<=150 Then #Auxiliar1.Saldo Else Null End as [-150 a -120 dias],
	
		 Case When #Auxiliar1.Dias>90 and #Auxiliar1.Dias<=120 Then #Auxiliar1.Saldo Else Null End as [-120 a -90 dias],
		 Case When #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=90 Then #Auxiliar1.Saldo Else Null End as [-90 a -60 dias],
		 Case When #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60 Then #Auxiliar1.Saldo Else Null End as [-60 a -30 dias],
		 Case When #Auxiliar1.Dias>10 and #Auxiliar1.Dias<=30 Then #Auxiliar1.Saldo Else Null End as [-30 a -10 dias],
		 Case When #Auxiliar1.Dias>=0 and #Auxiliar1.Dias<=10 Then #Auxiliar1.Saldo Else Null End as [-10 a 0 dias],
	
		 Case When #Auxiliar1.Dias*-1>=0 and #Auxiliar1.Dias*-1<=10 Then #Auxiliar1.Saldo Else Null End as [0 a 10 dias],
		 Case When #Auxiliar1.Dias*-1>10 and #Auxiliar1.Dias*-1<=30 Then #Auxiliar1.Saldo Else Null End as [10 a 30 dias],
		 Case When #Auxiliar1.Dias*-1>30 and #Auxiliar1.Dias*-1<=60 Then #Auxiliar1.Saldo Else Null End as [30 a 60 dias],
		 Case When #Auxiliar1.Dias*-1>60 and #Auxiliar1.Dias*-1<=90 Then #Auxiliar1.Saldo Else Null End as [60 a 90 dias],
		 Case When #Auxiliar1.Dias*-1>90 and #Auxiliar1.Dias*-1<=120 Then #Auxiliar1.Saldo Else Null End as [90 a 120 dias],
		 Case When #Auxiliar1.Dias*-1>120 and #Auxiliar1.Dias*-1<=150 Then #Auxiliar1.Saldo Else Null End as [120 a 150 dias],
		 Case When #Auxiliar1.Dias*-1>150 and #Auxiliar1.Dias*-1<=180 Then #Auxiliar1.Saldo Else Null End as [150 a 180 dias],
		 Case When #Auxiliar1.Dias*-1>180 and #Auxiliar1.Dias*-1<=270 Then #Auxiliar1.Saldo Else Null End as [180 a 270 dias],
		 Case When #Auxiliar1.Dias*-1>270 and #Auxiliar1.Dias*-1<=365 Then #Auxiliar1.Saldo Else Null End as [270 a 365 dias],
		 Case When #Auxiliar1.Dias*-1>365 and #Auxiliar1.Dias*-1<=730 Then #Auxiliar1.Saldo Else Null End as [1 a 2 años],
		 Case When #Auxiliar1.Dias*-1>730 and #Auxiliar1.Dias*-1<=1095 Then #Auxiliar1.Saldo Else Null End as [2 a 3 años],
		 Case When #Auxiliar1.Dias*-1>1095 Then #Auxiliar1.Saldo Else Null End as [Mas de 3 años],
		 #Auxiliar1.FechaComprobante as [Fecha Comp.],
		 #Auxiliar1.Contacto as [Contacto],
		 #Auxiliar1.Telefono as [Telefono],
		 #Auxiliar1.Direccion as [Direccion],
		 #Auxiliar1.DireccionEntrega as [Direccion entrega],
		 #Auxiliar1.Localidad as [Localidad],
		 #Auxiliar1.CodigoPostal as [Cod.Pos.],
		 #Auxiliar1.Provincia as [Provincia],
		 #Auxiliar1.Pais as [Pais],
		 #Auxiliar1.Vendedor as [Vendedor],
		 #Auxiliar1.Cobrador as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
	
		UNION ALL 
	
		SELECT 
		 0 as [IdAux],
		 #Auxiliar1.Codigo as [K_Codigo],
		 Null as [K_FechaVencimiento],
		 2 as [K_Orden],
		 Null as [Fecha vto.],
		 Null as [Codigo],
		 Null as [Cliente],
		 '    TOTAL CLIENTE' as [Comprobante],
		 SUM(#Auxiliar1.ImporteTotal) as [Importe total],
		 SUM(#Auxiliar1.Saldo) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.Dias>0 Then #Auxiliar1.Saldo Else 0 End) as [Vencido],
	
		 SUM(Case When #Auxiliar1.Dias>1095 Then #Auxiliar1.Saldo Else 0 End) as [Mas de -3 años],
		 SUM(Case When #Auxiliar1.Dias>730 and #Auxiliar1.Dias<=1095 Then #Auxiliar1.Saldo Else 0 End) as [-3 a -2 años],
		 SUM(Case When #Auxiliar1.Dias>365 and #Auxiliar1.Dias<=730 Then #Auxiliar1.Saldo Else 0 End) as [-2 a -1 años],
		 SUM(Case When #Auxiliar1.Dias>270 and #Auxiliar1.Dias<=365 Then #Auxiliar1.Saldo Else 0 End) as [-365 a -270 dias],
		 SUM(Case When #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=270 Then #Auxiliar1.Saldo Else 0 End) as [-270 a -180 dias],
		 SUM(Case When #Auxiliar1.Dias>150 and #Auxiliar1.Dias<=180 Then #Auxiliar1.Saldo Else 0 End) as [-180 a -150 dias],
		 SUM(Case When #Auxiliar1.Dias>120 and #Auxiliar1.Dias<=150 Then #Auxiliar1.Saldo Else 0 End) as [-150 a -120 dias],
		 SUM(Case When #Auxiliar1.Dias>90 and #Auxiliar1.Dias<=120 Then #Auxiliar1.Saldo Else 0 End) as [-120 a -90 dias],
		 SUM(Case When #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=90 Then #Auxiliar1.Saldo Else 0 End) as [-90 a -60 dias],
		 SUM(Case When #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60 Then #Auxiliar1.Saldo Else 0 End) as [-60 a -30 dias],
		 SUM(Case When #Auxiliar1.Dias>10 and #Auxiliar1.Dias<=30 Then #Auxiliar1.Saldo Else 0 End) as [-30 a -10 dias],
		 SUM(Case When #Auxiliar1.Dias>=0 and #Auxiliar1.Dias<=10 Then #Auxiliar1.Saldo Else 0 End) as [-10 a 0 dias],
	
		 SUM(Case When #Auxiliar1.Dias*-1>=0 and #Auxiliar1.Dias*-1<=10 Then #Auxiliar1.Saldo Else 0 End) as [0 a 10 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>10 and #Auxiliar1.Dias*-1<=30 Then #Auxiliar1.Saldo Else 0 End) as [10 a 30 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>30 and #Auxiliar1.Dias*-1<=60 Then #Auxiliar1.Saldo Else 0 End) as [30 a 60 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>60 and #Auxiliar1.Dias*-1<=90 Then #Auxiliar1.Saldo Else 0 End) as [60 a 90 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>90 and #Auxiliar1.Dias*-1<=120 Then #Auxiliar1.Saldo Else 0 End) as [90 a 120 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>120 and #Auxiliar1.Dias*-1<=150 Then #Auxiliar1.Saldo Else 0 End) as [120 a 150 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>150 and #Auxiliar1.Dias*-1<=180 Then #Auxiliar1.Saldo Else 0 End) as [150 a 180 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>180 and #Auxiliar1.Dias*-1<=270 Then #Auxiliar1.Saldo Else 0 End) as [180 a 270 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>270 and #Auxiliar1.Dias*-1<=365 Then #Auxiliar1.Saldo Else 0 End) as [270 a 365 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>365 and #Auxiliar1.Dias*-1<=730 Then #Auxiliar1.Saldo Else 0 End) as [1 a 2 años],
		 SUM(Case When #Auxiliar1.Dias*-1>730 and #Auxiliar1.Dias*-1<=1095 Then #Auxiliar1.Saldo Else 0 End) as [2 a 3 años],
		 SUM(Case When #Auxiliar1.Dias*-1>1095 Then #Auxiliar1.Saldo Else 0 End) as [Mas de 3 años],
		 Null as [Fecha Comp.],
		 Null as [Contacto],
		 Null as [Telefono],
		 Null as [Direccion],
		 Null as [Direccion entrega],
		 Null as [Localidad],
		 Null as [Cod.Pos.],
		 Null as [Provincia],
		 Null as [Pais],
		 Null as [Vendedor],
		 Null as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
		GROUP BY #Auxiliar1.Codigo
	
		UNION ALL 
	
		SELECT 
		 0 as [IdAux],
		 #Auxiliar1.Codigo as [K_Codigo],
		 Null as [K_FechaVencimiento],
		 3 as [K_Orden],
		 Null as [Fecha vto.],
		 Null as [Codigo],
		 Null as [Cliente],
		 Null as [Comprobante],
		 Null as [Importe total],
		 Null as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 Null as [Vencido],
	
		 Null as [Mas de -3 años],
		 Null as [-3 a -2 años],
		 Null as [-2 a -1 años],
		 Null as [-365 a -270 dias],
		 Null as [-270 a -180 dias],
		 Null as [-180 a -150 dias],
		 Null as [-150 a -120 dias],
		 Null as [-120 a -90 dias],
		 Null as [-90 a -60 dias],
		 Null as [-60 a -30 dias],
		 Null as [-30 a -10 dias],
		 Null as [-10 a 0 dias],
	
		 Null as [0 a 10 dias],
		 Null as [10 a 30 dias],
		 Null as [30 a 60 dias],
		 Null as [60 a 90 dias],
		 Null as [90 a 120 dias],
		 Null as [120 a 150 dias],
		 Null as [150 a 180 dias],
		 Null as [180 a 270 dias],
		 Null as [270 a 365 dias],
		 Null as [1 a 2 años],
		 Null as [2 a 3 años],
		 Null as [Mas de 3 años],
		 Null as [Fecha Comp.],
		 Null as [Contacto],
		 Null as [Telefono],
		 Null as [Direccion],
		 Null as [Direccion entrega],
		 Null as [Localidad],
		 Null as [Cod.Pos.],
		 Null as [Provincia],
		 Null as [Pais],
		 Null as [Vendedor],
		 Null as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
		GROUP BY #Auxiliar1.Codigo
	
		UNION ALL 
	
		SELECT 
		 0 as [IdAux],
		 'zzzzz' as [K_Codigo],
		 Null as [K_FechaVencimiento],
		 4 as [K_Orden],
		 Null as [Fecha vto.],
		 Null as [Codigo],
		 Null as [Cliente],
		 '    TOTAL GENERAL' as [Comprobante],
		 SUM(#Auxiliar1.ImporteTotal) as [Importe total],
		 SUM(#Auxiliar1.Saldo) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.Dias>0 Then #Auxiliar1.Saldo Else 0 End) as [Vencido],
	
		 SUM(Case When #Auxiliar1.Dias>1095 Then #Auxiliar1.Saldo Else 0 End) as [Mas de -3 años],
		 SUM(Case When #Auxiliar1.Dias>730 and #Auxiliar1.Dias<=1095 Then #Auxiliar1.Saldo Else 0 End) as [-3 a -2 años],
		 SUM(Case When #Auxiliar1.Dias>365 and #Auxiliar1.Dias<=730 Then #Auxiliar1.Saldo Else 0 End) as [-2 a -1 años],
		 SUM(Case When #Auxiliar1.Dias>270 and #Auxiliar1.Dias<=365 Then #Auxiliar1.Saldo Else 0 End) as [-365 a -270 dias],
		 SUM(Case When #Auxiliar1.Dias>180 and #Auxiliar1.Dias<=270 Then #Auxiliar1.Saldo Else 0 End) as [-270 a -180 dias],
		 SUM(Case When #Auxiliar1.Dias>150 and #Auxiliar1.Dias<=180 Then #Auxiliar1.Saldo Else 0 End) as [-180 a -150 dias],
		 SUM(Case When #Auxiliar1.Dias>120 and #Auxiliar1.Dias<=150 Then #Auxiliar1.Saldo Else 0 End) as [-150 a -120 dias],
		 SUM(Case When #Auxiliar1.Dias>90 and #Auxiliar1.Dias<=120 Then #Auxiliar1.Saldo Else 0 End) as [-120 a -90 dias],
		 SUM(Case When #Auxiliar1.Dias>60 and #Auxiliar1.Dias<=90 Then #Auxiliar1.Saldo Else 0 End) as [-90 a -60 dias],
		 SUM(Case When #Auxiliar1.Dias>30 and #Auxiliar1.Dias<=60 Then #Auxiliar1.Saldo Else 0 End) as [-60 a -30 dias],
		 SUM(Case When #Auxiliar1.Dias>10 and #Auxiliar1.Dias<=30 Then #Auxiliar1.Saldo Else 0 End) as [-30 a -10 dias],
		 SUM(Case When #Auxiliar1.Dias>=0 and #Auxiliar1.Dias<=10 Then #Auxiliar1.Saldo Else 0 End) as [-10 a 0 dias],
	
		 SUM(Case When #Auxiliar1.Dias*-1>=0 and #Auxiliar1.Dias*-1<=10 Then #Auxiliar1.Saldo Else 0 End) as [0 a 10 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>10 and #Auxiliar1.Dias*-1<=30 Then #Auxiliar1.Saldo Else 0 End) as [10 a 30 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>30 and #Auxiliar1.Dias*-1<=60 Then #Auxiliar1.Saldo Else 0 End) as [30 a 60 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>60 and #Auxiliar1.Dias*-1<=90 Then #Auxiliar1.Saldo Else 0 End) as [60 a 90 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>90 and #Auxiliar1.Dias*-1<=120 Then #Auxiliar1.Saldo Else 0 End) as [90 a 120 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>120 and #Auxiliar1.Dias*-1<=150 Then #Auxiliar1.Saldo Else 0 End) as [120 a 150 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>150 and #Auxiliar1.Dias*-1<=180 Then #Auxiliar1.Saldo Else 0 End) as [150 a 180 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>180 and #Auxiliar1.Dias*-1<=270 Then #Auxiliar1.Saldo Else 0 End) as [180 a 270 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>270 and #Auxiliar1.Dias*-1<=365 Then #Auxiliar1.Saldo Else 0 End) as [270 a 365 dias],
		 SUM(Case When #Auxiliar1.Dias*-1>365 and #Auxiliar1.Dias*-1<=730 Then #Auxiliar1.Saldo Else 0 End) as [1 a 2 años],
		 SUM(Case When #Auxiliar1.Dias*-1>730 and #Auxiliar1.Dias*-1<=1095 Then #Auxiliar1.Saldo Else 0 End) as [2 a 3 años],
		 SUM(Case When #Auxiliar1.Dias*-1>1095 Then #Auxiliar1.Saldo Else 0 End) as [Mas de 3 años],
		 Null as [Fecha Comp.],
		 Null as [Contacto],
		 Null as [Telefono],
		 Null as [Direccion],
		 Null as [Direccion entrega],
		 Null as [Localidad],
		 Null as [Cod.Pos.],
		 Null as [Provincia],
		 Null as [Pais],
		 Null as [Vendedor],
		 Null as [Cobrador],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
	
		ORDER BY [K_Codigo], [K_Orden], [K_FechaVencimiento]
	   END
   END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2