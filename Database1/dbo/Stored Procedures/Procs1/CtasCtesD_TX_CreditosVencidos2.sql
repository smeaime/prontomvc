CREATE Procedure [dbo].[CtasCtesD_TX_CreditosVencidos2]

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
@FiltraSaldos0 varchar(2) = Null

AS 

SET NOCOUNT ON

IF @FiltraSaldos0 is null
	SET @FiltraSaldos0='SI'

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int, @IdClienteProc int

SET @IdClienteProc=-1
SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

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
			 Cobrador VARCHAR(50)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdImputacion, FechaVencimiento) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  Clientes.IdCliente,
  Clientes.Codigo,
  Clientes.RazonSocial,
  IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha),
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
  V2.Nombre
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
			 Saldo NUMERIC(12,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdImputacion, FechaVencimiento) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCtaCte,
  Clientes.IdCliente,
  IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha),
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
  CtaCte.ImporteTotal
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
	(@ActivaFechas=-1 or CtaCte.Fecha between @FechaDesde and @FechaHasta) and 
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
DECLARE @IdCtaCte int, @Corte int, @IdImputacion int, @IdCliente int, @Fecha datetime, @ImporteTotal numeric(18,2), 
	@Saldo numeric(18,2), @SaldoAAplicar numeric(18,2), @SaldoAplicado numeric(18,2)

DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdCtaCte, IdCliente, IdImputacion, ImporteTotal, Saldo
		FROM #Auxiliar2
		WHERE Saldo<>0 and IdImputacion<>0
		ORDER BY IdImputacion, FechaVencimiento 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte, @IdCliente, @IdImputacion, @ImporteTotal, @Saldo
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @SaldoAAplicar=@Saldo
	SET @Corte=@IdImputacion

	DECLARE CtaCte2 CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdCtaCte, IdCliente, IdImputacion, ImporteTotal, Saldo
			FROM #Auxiliar1
			WHERE Saldo<>0 and IdImputacion=@Corte
			ORDER BY FechaVencimiento 
	OPEN CtaCte2
	FETCH NEXT FROM CtaCte2	INTO @IdCtaCte, @IdCliente, @IdImputacion, @ImporteTotal, @Saldo
	WHILE @@FETCH_STATUS = 0 and not @SaldoAAplicar=0
	   BEGIN
		IF @SaldoAAplicar>=@Saldo
		   BEGIN
			SET @SaldoAAplicar=@SaldoAAplicar-@Saldo
			SET @SaldoAplicado=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicado=@Saldo-@SaldoAAplicar
			SET @SaldoAAplicar=0
		   END

		UPDATE #Auxiliar1
		SET Saldo = @SaldoAplicado
		WHERE CURRENT OF CtaCte2

		FETCH NEXT FROM CtaCte2	INTO @IdCtaCte, @IdCliente, @IdImputacion, @ImporteTotal, @Saldo
	   END
	CLOSE CtaCte2
	DEALLOCATE CtaCte2

	UPDATE #Auxiliar2
	SET Saldo = @SaldoAAplicar
	WHERE CURRENT OF CtaCte1

	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte, @IdCliente, @IdImputacion, @ImporteTotal, @Saldo
   END
CLOSE CtaCte1
DEALLOCATE CtaCte1

IF @ConCreditosNoAplicados='SI'
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
	  Null
	 FROM #Auxiliar2
	 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar2.IdCliente
	 GROUP BY #Auxiliar2.IdCliente, Clientes.Codigo, Clientes.RazonSocial

IF @FiltraSaldos0='SI'
	DELETE FROM #Auxiliar1
	WHERE IsNull(Saldo,0)=0

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0000111166111111111111111111111111133'
SET @vector_T='0000422844222222222222224111111111100'

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
 Case When #Auxiliar1.Dias*-1>=0 and #Auxiliar1.Dias*-1<=30 Then #Auxiliar1.Saldo Else Null End as [0 a 30 dias],
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
 SUM(Case When #Auxiliar1.Dias*-1>=0 and #Auxiliar1.Dias*-1<=30 Then #Auxiliar1.Saldo Else 0 End) as [0 a 30 dias],
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
 Null as [0 a 30 dias],
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
 SUM(Case When #Auxiliar1.Dias*-1>=0 and #Auxiliar1.Dias*-1<=30 Then #Auxiliar1.Saldo Else 0 End) as [0 a 30 dias],
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

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2