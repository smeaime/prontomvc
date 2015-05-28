CREATE Procedure [dbo].[CtasCtesD_TXPorTrs]

@IdCliente int,
@Todo int,
@FechaLimite datetime,
@FechaDesde datetime = Null,
@Consolidar int = Null,
@Pendiente varchar(1) = Null

AS 

SET NOCOUNT ON

SET @FechaDesde=IsNull(@FechaDesde,Convert(datetime,'1/1/1500'))
SET @Consolidar=IsNull(@Consolidar,-1)
SET @Pendiente=IsNull(@Pendiente,'N')

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, 
		@ConsolidacionDeBDs VARCHAR(2), @NombreServidorWeb VARCHAR(100), @UsuarioServidorWeb VARCHAR(50), @PasswordServidorWeb VARCHAR(50), @BaseDeDatosServidorWeb VARCHAR(50), 
		@proc_name varchar(1000), @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)

SET @vector_X='001111118815111111111133'
SET @vector_T='00199744555A999133329900'
SET @vector_E='  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  |  |  |  |  |  '

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

CREATE TABLE #Auxiliar1 
			(
			 IdCtaCte INTEGER,
			 IdTipoComp INTEGER,
			 Coeficiente INTEGER,
			 IdImputacion INTEGER,
			 Saldo NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdImputacion, IdCtaCte) ON [PRIMARY]
CREATE TABLE #Auxiliar2 
			(
			 IdImputacion INTEGER,
			 Saldo NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdImputacion) ON [PRIMARY]

CREATE TABLE #Auxiliar10
			(
			 IdCtaCte INTEGER,
			 IdImputacion INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Comprobante VARCHAR(16),
			 Fecha DATETIME,
			 FechaVencimiento DATETIME,
			 ImporteTotal NUMERIC(18,2),
			 Saldo NUMERIC(18,2),
			 SaldoTransaccion NUMERIC(18,2),
			 Observaciones VARCHAR(1500),
			 Cabeza VARCHAR(1),
			 IdImputacion2 INTEGER,
			 IdCtaCte2 INTEGER,
			 Condicion VARCHAR(50),
			 Obra VARCHAR(13),
			 OrdenCompra VARCHAR(20),
			 Moneda VARCHAR(15),
			 Vendedor VARCHAR(50),
			 Origen VARCHAR(1),
			 Vector_E VARCHAR(100),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdCtaCte, CtaCte.IdTipoComp, IsNull(TiposComprobante.Coeficiente,1), Case When IsNull(CtaCte.IdImputacion,0)=0 Then Null Else CtaCte.IdImputacion End, CtaCte.Saldo
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE CtaCte.IdCliente=@IdCliente and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 

/*  CURSOR  */
DECLARE @IdTrs int, @IdCtaCte int, @IdTipoComp int, @Coeficiente int, @IdImputacion int, @Saldo numeric(18,2), @Saldo1 numeric(18,2)
SET @IdTrs=0
SET @Saldo1=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdCtaCte, IdTipoComp, Coeficiente, IdImputacion, Saldo FROM #Auxiliar1 ORDER BY IdImputacion, IdCtaCte
OPEN Cur
FETCH NEXT FROM Cur INTO @IdCtaCte, @IdTipoComp, @Coeficiente, @IdImputacion, @Saldo
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @IdTrs<>IsNull(@IdImputacion,-1)
	  BEGIN
		IF @IdTrs<>0
			INSERT INTO #Auxiliar2
			(IdImputacion, Saldo)
			VALUES
			(Case When @IdTrs=-1 Then Null Else @IdTrs End, @Saldo1)
		SET @Saldo1=0
		SET @IdTrs=IsNull(@IdImputacion,-1)
	  END
	SET @Saldo1=@Saldo1+(@Saldo*@Coeficiente)
	FETCH NEXT FROM Cur INTO @IdCtaCte, @IdTipoComp, @Coeficiente, @IdImputacion, @Saldo
  END
IF @IdTrs<>0
  BEGIN
	INSERT INTO #Auxiliar2
	(IdImputacion, Saldo)
	VALUES
	(@IdTrs, @Saldo1)
  END
CLOSE Cur
DEALLOCATE Cur

IF @Pendiente='S'
  BEGIN
	DELETE #Auxiliar1
	WHERE IsNull((Select Top 1 #Auxiliar2.Saldo From #Auxiliar2 Where IsNull(#Auxiliar2.IdImputacion,-1)=IsNull(#Auxiliar1.IdImputacion,-1)),0)=0 or IsNull(#Auxiliar1.Saldo,0)=0
	DELETE #Auxiliar2
	WHERE IsNull(Saldo,0)=0
  END

IF Len(@NombreServidorWeb)>0 and @Consolidar>=0
  BEGIN
	EXEC sp_addlinkedserver @NombreServidorWeb
	SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.CtasCtesD_TXPorTrs'
	INSERT INTO #Auxiliar10 
		EXECUTE @proc_name @IdCliente, @Todo, @FechaLimite, @FechaDesde, @Consolidar, @Pendiente
	EXEC sp_dropserver @NombreServidorWeb
--EXEC sp_dropserver 'serversql1'
	UPDATE #Auxiliar10 SET Origen='1'
  END

INSERT INTO #Auxiliar10 
 SELECT 
  #Auxiliar1.IdCtaCte,
  #Auxiliar1.IdImputacion,
  Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then TiposComprobante.DescripcionAb Else 'CV' End,
  CtaCte.IdTipoComp,
  CtaCte.IdComprobante,
  Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and Facturas.IdFactura is not null
	Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.TipoABC Else IsNull(Facturas.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.PuntoVenta Else IsNull(Facturas.CuentaVentaPuntoVenta,0) End)))+Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.PuntoVenta Else IsNull(Facturas.CuentaVentaPuntoVenta,0) End)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.NumeroFactura Else IsNull(Facturas.CuentaVentaNumero,0) End)))+Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.NumeroFactura Else IsNull(Facturas.CuentaVentaNumero,0) End)
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones and Devoluciones.IdDevolucion is not null
	Then Devoluciones.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito and NotasDebito.IdNotaDebito is not null
	Then NotasDebito.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito and NotasCredito.IdNotaCredito is not null
	Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.TipoABC Else IsNull(NotasCredito.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.PuntoVenta Else IsNull(NotasCredito.CuentaVentaPuntoVenta,0) End)))+Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.PuntoVenta Else IsNull(NotasCredito.CuentaVentaPuntoVenta,0) End)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.NumeroNotaCredito Else IsNull(NotasCredito.CuentaVentaNumero,0) End)))+Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.NumeroNotaCredito Else IsNull(NotasCredito.CuentaVentaNumero,0) End)
	When (CtaCte.IdTipoComp=@IdTipoComprobanteRecibo or CtaCte.IdTipoComp=16) and Recibos.IdRecibo is not null
	Then Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	Else Substring(Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante),1,15)
  End,
  CtaCte.Fecha,
  CtaCte.FechaVencimiento,
  Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal Else CtaCte.ImporteTotal*-1 End,
  Case When @Todo=-1
	Then Case When TiposComprobante.Coeficiente=1 Then CtaCte.Saldo Else CtaCte.Saldo*-1 End 
	Else Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal Else CtaCte.ImporteTotal*-1 End 
  End,
  CtaCte.SaldoTrs,
  Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and Facturas.IdFactura is not null
	Then Substring(Convert(varchar(1500),Facturas.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),1,1500)
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones and Devoluciones.IdDevolucion is not null
	Then Substring(Convert(varchar(1500),Devoluciones.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),1,1500)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito and NotasDebito.IdNotaDebito is not null
	Then Substring(Convert(varchar(1500),NotasDebito.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),1,1500)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito and NotasCredito.IdNotaCredito is not null
	Then Substring(Convert(varchar(1500),NotasCredito.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),1,1500)
	When (CtaCte.IdTipoComp=@IdTipoComprobanteRecibo or CtaCte.IdTipoComp=16) and Recibos.IdRecibo is not null
	Then Substring(Convert(varchar(1500),Recibos.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),1,1500)
	Else ''
  End,
  Case When CtaCte.IdCtaCte=IsNull(CtaCte.IdImputacion,0) Then '0' Else '1' End,
  CtaCte.IdImputacion,
  CtaCte.IdCtaCte,
  cc.Descripcion,
  Obras.NumeroObra,
  Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and Facturas.IdFactura is not null
	Then (Select Top 1 oc.NumeroOrdenCompraCliente
		From DetalleFacturasOrdenesCompra dfoc 
		Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra
		Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra
		Where dfoc.IdFactura=CtaCte.IdComprobante)
	Else Null
  End,
  Monedas.Abreviatura,
  Vendedores.Nombre,
  '0',
  @vector_E,
  @vector_T,
  @vector_X
 FROM #Auxiliar1
 LEFT OUTER JOIN CuentasCorrientesDeudores CtaCte ON CtaCte.IdCtaCte=#Auxiliar1.IdCtaCte
 LEFT OUTER JOIN Clientes ON CtaCte.IdCliente=Clientes.IdCliente
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Monedas ON CtaCte.IdMoneda=Monedas.IdMoneda
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(Facturas.IdObra,IsNull(Devoluciones.IdObra,IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,0))))
 LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=IsNull(Facturas.IdVendedor,IsNull(Devoluciones.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,IsNull(Recibos.IdVendedor,0)))))
 LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra=Facturas.IdCondicionVenta
 WHERE CtaCte.IdCliente=@IdCliente and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 

INSERT INTO #Auxiliar10 
 SELECT 
  0,
  #Auxiliar2.IdImputacion,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  #Auxiliar2.Saldo,
  Null,
  '9',
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  '0',
  @vector_E,
  @vector_T,
  @vector_X
 FROM #Auxiliar2

SET NOCOUNT OFF

SELECT 
 IdCtaCte as [IdCtaCte],
 IdImputacion as [IdImputacion],
 TipoComprobante+Case When IsNull(Origen,'0')<>'0' Then ' *' Else '' End as [Comp.],
 IdTipoComprobante as [IdTipoComp],
 IdComprobante as [IdComprobante],
 Comprobante as [Numero],
 Fecha as [Fecha],
 FechaVencimiento as [Fecha vto.],
 ImporteTotal as [Imp.orig.],
 Saldo as [Saldo Comp.],
 SaldoTransaccion as [SaldoTrs],
 Observaciones as [Observaciones],
 Cabeza as [Cabeza],
 IdImputacion2 as [IdImpu],
 IdCtaCte2 as [IdAux1],
 Condicion as [Cond. venta],
 Obra as [Obra],
 OrdenCompra as [Orden de compra],
 Moneda as [Mon.origen],
 Vendedor as [Vendedor],
 Origen as [Origen],
 Vector_E as [Vector_E],
 Vector_T as [Vector_T],
 Vector_X as [Vector_X]
FROM #Auxiliar10
ORDER by Origen, IdImputacion, Cabeza, Fecha, Comprobante

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar10