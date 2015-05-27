CREATE PROCEDURE [dbo].[Subdiarios_TXSub]

@Mes int,
@Anio int,
@IdCuentaSubdiario int

AS

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int,@IdTipoComprobanteOrdenPago int, @FechaConsulta datetime

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @FechaConsulta=Convert(datetime,'1/'+Convert(varchar,@Mes)+'/'+Convert(varchar,@Anio))
SET @FechaConsulta=Dateadd(d,-1,Dateadd(m,1,@FechaConsulta))

CREATE TABLE #Auxiliar1
			(
			 IdSubdiario INTEGER,
			 Detalle VARCHAR(200),
			 IdCliente INTEGER,
			 IdProveedor INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT
  Subdiarios.IdSubdiario,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
		Then Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then TiposComprobante.DescripcionAb Else 'CV' End+' '+
			Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then Fac.TipoABC Else IsNull(Fac.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then Fac.PuntoVenta Else IsNull(Fac.CuentaVentaPuntoVenta,0) End)))+
				Convert(varchar,Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then Fac.PuntoVenta Else IsNull(Fac.CuentaVentaPuntoVenta,0) End)+'-'+
			Substring('0000000000',1,10-Len(Convert(varchar,Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then Fac.NumeroFactura Else IsNull(Fac.CuentaVentaNumero,0) End)))+
				Convert(varchar,Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then Fac.NumeroFactura Else IsNull(Fac.CuentaVentaNumero,0) End)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
		Then TiposComprobante.DescripcionAb+' '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
			Substring('0000000000',1,10-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
		Then TiposComprobante.DescripcionAb+' '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
			Substring('0000000000',1,10-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
		Then TiposComprobante.DescripcionAb+' '+Case When IsNull(Cre.CuentaVentaNumero,0)=0 Then Cre.TipoABC Else IsNull(Cre.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Case When IsNull(Cre.CuentaVentaNumero,0)=0 Then Cre.PuntoVenta Else IsNull(Cre.CuentaVentaPuntoVenta,0) End)))+
				Convert(varchar,Case When IsNull(Cre.CuentaVentaNumero,0)=0 Then Cre.PuntoVenta Else IsNull(Cre.CuentaVentaPuntoVenta,0) End)+'-'+
			Substring('0000000000',1,10-Len(Convert(varchar,Case When IsNull(Cre.CuentaVentaNumero,0)=0 Then Cre.NumeroNotaCredito Else IsNull(Cre.CuentaVentaNumero,0) End)))+
				Convert(varchar,Case When IsNull(Cre.CuentaVentaNumero,0)=0 Then Cre.NumeroNotaCredito Else IsNull(Cre.CuentaVentaNumero,0) End)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
		Then TiposComprobante.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,Rec.PuntoVenta)))+Convert(varchar,Rec.PuntoVenta)+'-'+
			Substring('0000000000',1,10-Len(Convert(varchar,Rec.NumeroRecibo)))+Convert(varchar,Rec.NumeroRecibo)+' '+
			Case When Rec.IdCuenta is not null
				Then 'Conc.'+IsNull((Select Top 1 Cuentas.Descripcion From Cuentas Where Cuentas.IdCuenta=Rec.IdCuenta),'')
				Else ''
			End
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
		 Then TiposComprobante.DescripcionAb+' '+Substring('0000000000',1,10-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago)+' '+
			Case When op.IdCuenta is not null
				Then IsNull((Select Top 1 Cuentas.Descripcion From Cuentas Where Cuentas.IdCuenta=op.IdCuenta),'')
				Else ''
			End
	When cp.IdComprobanteProveedor is not null
		 Then TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)	Else Null
  End,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Fac.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Dev.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Deb.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Cre.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Rec.IdCliente
		Else Null
  End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then op.IdProveedor
		When cp.IdComprobanteProveedor is not null Then IsNull(cp.IdProveedor,cp.IdProveedorEventual)
		Else Null
  End
 FROM Subdiarios
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=Subdiarios.IdComprobante
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=Subdiarios.IdComprobante
 LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=Subdiarios.IdComprobante
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=Subdiarios.IdComprobante
 LEFT OUTER JOIN Recibos Rec ON Rec.IdRecibo=Subdiarios.IdComprobante
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=Subdiarios.IdComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and cp.IdTipoComprobante=Subdiarios.IdTipoComprobante
WHERE MONTH(Subdiarios.FechaComprobante)=@Mes and YEAR(Subdiarios.FechaComprobante)=@Anio and Subdiarios.IdCuentaSubdiario=@IdCuentaSubdiario

CREATE TABLE #Auxiliar2
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(100)
			)
INSERT INTO #Auxiliar2 
 SELECT DISTINCT Cuentas.IdCuenta, Cuentas.Codigo, Cuentas.Descripcion
 FROM Subdiarios
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 WHERE MONTH(Subdiarios.FechaComprobante)=@Mes and YEAR(Subdiarios.FechaComprobante)=@Anio and Subdiarios.IdCuentaSubdiario=@IdCuentaSubdiario

 UPDATE #Auxiliar2
 SET Codigo=IsNull((Select Top 1 dc.CodigoAnterior From DetalleCuentas dc Where dc.IdCuenta=#Auxiliar2.IdCuenta and dc.FechaCambio>@FechaConsulta Order By dc.FechaCambio),Codigo),
	Descripcion=IsNull((Select Top 1 dc.NombreAnterior From DetalleCuentas dc Where dc.IdCuenta=#Auxiliar2.IdCuenta and dc.FechaCambio>@FechaConsulta Order By dc.FechaCambio),Descripcion)

SET NOCOUNT ON


DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)
SET @vector_X='0001111111111133'
SET @vector_T='000399002433E900'
SET @vector_E='  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  '

SELECT 
 Subdiarios.IdSubdiario,
 Subdiarios.IdCuentaSubdiario,
 Subdiarios.IdCuenta,
 #Auxiliar2.Codigo as [Codigo],
 Subdiarios.IdTipoComprobante,
 Subdiarios.IdComprobante,
 Case When Subdiarios.Debe is null Then '   '+#Auxiliar2.Descripcion Else #Auxiliar2.Descripcion End as [Cuenta],
 Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then TiposComprobante.DescripcionAb Else 'CV' End as [Comp.],
 Case When IsNull(Fac.CuentaVentaNumero,0)=0 Then Subdiarios.NumeroComprobante Else IsNull(Fac.CuentaVentaNumero,0) End as [Numero],
 Subdiarios.FechaComprobante as [Fecha],
 Subdiarios.Debe as [Debe],
 Subdiarios.Haber as [Haber],
 IsNull(#Auxiliar1.Detalle COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+
	Case When Clientes.RazonSocial is not null Then 'Cli.'+RTrim(Clientes.RazonSocial COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Proveedores.RazonSocial is not null Then 'Prov.'+RTrim(Proveedores.RazonSocial COLLATE SQL_Latin1_General_CP1_CI_AS)
		Else ''
	End+' '+
	IsNull(Subdiarios.Detalle,'') as [Detalle],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Subdiarios
LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN #Auxiliar1 ON Subdiarios.IdSubdiario=#Auxiliar1.IdSubdiario
LEFT OUTER JOIN #Auxiliar2 ON Subdiarios.IdCuenta=#Auxiliar2.IdCuentaLEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON #Auxiliar1.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=Subdiarios.IdComprobante
LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=Subdiarios.IdComprobante
WHERE MONTH(Subdiarios.FechaComprobante)=@Mes and YEAR(Subdiarios.FechaComprobante)=@Anio and Subdiarios.IdCuentaSubdiario=@IdCuentaSubdiario
ORDER by Subdiarios.FechaComprobante,Subdiarios.NumeroComprobante,Subdiarios.Haber

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2