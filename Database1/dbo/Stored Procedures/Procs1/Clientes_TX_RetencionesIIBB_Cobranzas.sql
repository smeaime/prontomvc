CREATE Procedure [dbo].[Clientes_TX_RetencionesIIBB_Cobranzas]

@FechaDesde datetime,
@FechaHasta datetime,
@Formato varchar(10) = Null

AS 

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdRecibo INTEGER,
			 IdCliente INTEGER,
			 IdProvincia INTEGER,
			 Jurisdiccion VARCHAR(3),
			 Provincia VARCHAR(50),
			 CodigoCliente VARCHAR(10),
			 Cliente VARCHAR(100),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 PuntoVenta INTEGER,
			 Comprobante NUMERIC(18,0),
			 TipoComprobanteOrigen VARCHAR(1),
			 LetraComprobanteOrigen VARCHAR(1),
			 NumeroComprobanteOrigen INTEGER,
			 RetencionIIBB NUMERIC(18,0),
			 ImporteBase NUMERIC(18,0),
			 Registro VARCHAR(80)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta1),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta1),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta1),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante1,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros1 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta1,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta2),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta2),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta2),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante2,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros2 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta2,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta3),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta3),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta3),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante3,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros3 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta3,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta4),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta4),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta4),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante4,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros4 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta4,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta5),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta5),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta5),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante5,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros5 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta5,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta6),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta6),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta6),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante6,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros6 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta6,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta7),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta7),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta7),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante7,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros7 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta7,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta8),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta8),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta8),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante8,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros8 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta8,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta9),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta9),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta9),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante9,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros9 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta9,0))

 UNION ALL

 SELECT  
  re.IdRecibo,
  re.IdCliente,
  (Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta10),
  SubString(IsNull((Select Top 1 Provincias.InformacionAuxiliar From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta10),'000'),1,3),
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=re.IdCuenta10),
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.PuntoVenta,
  IsNull(re.NumeroComprobante10,re.NumeroRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then 'F'
			When Devoluciones.IdDevolucion is not null Then 'C'
			When NotasDebito.IdNotaDebito is not null Then 'D'
			When NotasCredito.IdNotaCredito is not null Then 'C'
			Else 'O' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.TipoABC
			When Devoluciones.IdDevolucion is not null Then Devoluciones.TipoABC
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.TipoABC
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.TipoABC
			Else ' ' End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  (Select Top 1 Case When Facturas.IdFactura is not null Then Facturas.NumeroFactura
			When Devoluciones.IdDevolucion is not null Then Devoluciones.NumeroDevolucion
			When NotasDebito.IdNotaDebito is not null Then NotasDebito.NumeroNotaDebito
			When NotasCredito.IdNotaCredito is not null Then NotasCredito.NumeroNotaCredito
			Else 0 End 
   From DetalleRecibos DetRec 
   Left Outer Join CuentasCorrientesDeudores CtaCte On CtaCte.IdCtaCte=DetRec.IdImputacion
   Left Outer Join Facturas On Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
   Left Outer Join Devoluciones On Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
   Left Outer Join NotasDebito On NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
   Left Outer Join NotasCredito On NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
   Where DetRec.IdRecibo=re.IdRecibo),
  re.Otros10 * re.CotizacionMoneda * 100,
  0, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null and 
	Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(re.IdCuenta10,0))

UPDATE #Auxiliar1
SET RetencionIIBB=0 
WHERE RetencionIIBB IS NULL

UPDATE #Auxiliar1
SET Cuit = '00-00000000-0'
WHERE Len(IsNull(Cuit,''))=0

IF @Formato='e-sicol'
  BEGIN
	UPDATE #Auxiliar1
	SET Registro = Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1) + 
		Convert(varchar,Year(Fecha))+
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+
			Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha)) +
		Substring('        ',1,8-len(Convert(varchar,Comprobante)))+Convert(varchar,Comprobante) + 
		Substring(Substring('               ',1,15-len(Convert(varchar,RetencionIIBB)))+Convert(varchar,RetencionIIBB),1,13)+'.'+
			Substring(Substring('               ',1,15-len(Convert(varchar,RetencionIIBB)))+Convert(varchar,RetencionIIBB),14,2) + 
		Substring(Substring('               ',1,15-len(Convert(varchar,RetencionIIBB)))+Convert(varchar,RetencionIIBB),1,13)+'.'+
			Substring(Substring('               ',1,15-len(Convert(varchar,RetencionIIBB)))+Convert(varchar,RetencionIIBB),14,2)
  END
ELSE
  BEGIN
	UPDATE #Auxiliar1
	SET Registro = Jurisdiccion + Cuit + Convert(varchar,Fecha,103) + 
			Substring('0000',1,4-len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta) + 
			Substring('0000000000000000',1,16-len(Substring(Convert(varchar,Comprobante),1,16)))+Substring(Convert(varchar,Comprobante),1,16) + 
			TipoComprobanteOrigen + LetraComprobanteOrigen + 
			Substring('00000000000000000000',1,20-len(Convert(varchar,NumeroComprobanteOrigen)))+Convert(varchar,NumeroComprobanteOrigen) + 
			Substring(Substring('0000000000',1,10-len(Convert(varchar,RetencionIIBB)))+Convert(varchar,RetencionIIBB),1,8)+','+
				Substring(Substring('0000000000',1,10-len(Convert(varchar,RetencionIIBB)))+Convert(varchar,RetencionIIBB),9,2)
  END

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0001111111111116133'
SET @vector_T='0001931354213334500'

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	1 as [K_Orden],
	Provincia as [Provincia],
	Provincia as [Aux1],
	Jurisdiccion as [Jurisdiccion],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Sucursal],
	Null as [Recibo],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	Null as [Nro.Comp],
	Null as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionIIBB<>0
GROUP BY IdProvincia, Provincia, Jurisdiccion

UNION ALL 

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	2 as [K_Orden],
	Null as [Provincia],
	Provincia as [Aux1],
	Null as [Jurisdiccion],
	CodigoCliente as [Codigo],
	Cliente as [Cliente],
	Cuit as [Cuit],
	Fecha as [Fecha],
	PuntoVenta as [Sucursal],
	Comprobante as [Recibo],
	TipoComprobanteOrigen as [Tipo Comp.],
	LetraComprobanteOrigen as [Letra Comp.],
	NumeroComprobanteOrigen as [Nro.Comp],
	RetencionIIBB/100 as [Imp. retenido],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionIIBB<>0
/*
UNION ALL 

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	3 as [K_Orden],
	Null as [Provincia],
	Provincia as [Aux1],
	Null as [Jurisdiccion],
	Null as [Codigo],
	'TOTAL PROVINCIA' as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Sucursal],
	Null as [Recibo],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	Null as [Nro.Comp],
	SUM(RetencionIIBB/100) as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionIIBB<>0
GROUP BY IdProvincia, Provincia
*/
UNION ALL 

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	4 as [K_Orden],
	Null as [Provincia],
	Provincia as [Aux1],
	Null as [Jurisdiccion],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Sucursal],
	Null as [Recibo],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	Null as [Nro.Comp],
	Null as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionIIBB<>0
GROUP BY IdProvincia, Provincia
/*
UNION ALL 

SELECT 
	0 as [K_IdProvincia],
	'zzzz' as [K_Provincia],
	5 as [K_Orden],
	Null as [Provincia],
	Null as [Aux1],
	Null as [Jurisdiccion],
	Null as [Codigo],
	'TOTAL GENERAL' as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Sucursal],
	Null as [Recibo],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	Null as [Nro.Comp],
	SUM(RetencionIIBB/100) as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionIIBB<>0
*/
ORDER BY [K_Provincia], [K_IdProvincia], [K_Orden], [Fecha]

DROP TABLE #Auxiliar1