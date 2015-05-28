
CREATE PROCEDURE [dbo].[CuboSaldosComprobantesPorObraProveedorA]

@FechaHasta datetime,
@Dts varchar(200)

AS

SET NOCOUNT ON

DECLARE @IdTipoComprobanteOrdenPago int

SET @IdTipoComprobanteOrdenPago=IsNull((Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1),0)

TRUNCATE TABLE _TempCuboSaldosComprobantesPorObraProveedor

INSERT INTO _TempCuboSaldosComprobantesPorObraProveedor 
 SELECT 
  Case 	When (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra)
	When (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra)
		Else ' NO IMPUTABLE'
  End,
  Case When cp.IdProveedor is not null
	Then IsNull(Proveedores.RazonSocial,'')
	Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
  End,
  Case When RubrosContables.Descripcion is not null 
	Then RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS
	Else Cuentas.Descripcion COLLATE Modern_Spanish_CI_AS
  End,
  'Vto.: '+Convert(varchar,IsNull(cp.FechaVencimiento,cp.FechaRecepcion),103)+' '+
	'Ref.: '+Convert(varchar,cp.NumeroReferencia)+' '+Convert(varchar,cp.FechaRecepcion,103)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' ( Gastos )',
  Case When cp.Letra='A' or cp.Letra='M' 
	Then (DetCP.Importe + 
		IsNull(DetCP.ImporteIVA1,0) + IsNull(DetCP.ImporteIVA2,0) + 
		IsNull(DetCP.ImporteIVA3,0) + IsNull(DetCP.ImporteIVA4,0) + 
		IsNull(DetCP.ImporteIVA5,0) + IsNull(DetCP.ImporteIVA6,0) + 
		IsNull(DetCP.ImporteIVA7,0) + IsNull(DetCP.ImporteIVA8,0) + 
		IsNull(DetCP.ImporteIVA9,0) + IsNull(DetCP.ImporteIVA10,0))
		* cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
	Else DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
  End,
  CtaCte.ImporteTotal,
  CtaCte.Saldo,
  0
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN _TempCuentasCorrientesAcreedores CtaCte ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and cp.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE cp.FechaRecepcion<=@FechaHasta and IsNull(cp.Confirmado,'')<>'NO' and IsNull(CtaCte.Saldo,0)<>0 and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta))) 

 UNION ALL

 SELECT 
  Case 	When (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra)
	When (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra)
		Else ' NO IMPUTABLE'
  End,
  Case When cp.IdProveedor is not null
	Then IsNull(Proveedores.RazonSocial,'')
	Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P
		Where P.IdProveedor=cp.IdProveedorEventual)
  End,
  Case When RubrosContables.Descripcion is not null 
	Then RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS
	Else Cuentas.Descripcion COLLATE Modern_Spanish_CI_AS
  End,
  'Vto.: '+Convert(varchar,IsNull(cp.FechaVencimiento,cp.FechaRecepcion),103)+' '+
	'Ref. : '+Convert(varchar,cp.NumeroReferencia)+' '+Convert(varchar,cp.FechaRecepcion,103)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' ( Bienes/Servicios )',
  Case When cp.Letra='A' or cp.Letra='M' 
	Then (DetCP.Importe + 
		IsNull(DetCP.ImporteIVA1,0) + IsNull(DetCP.ImporteIVA2,0) + 
		IsNull(DetCP.ImporteIVA3,0) + IsNull(DetCP.ImporteIVA4,0) + 
		IsNull(DetCP.ImporteIVA5,0) + IsNull(DetCP.ImporteIVA6,0) + 
		IsNull(DetCP.ImporteIVA7,0) + IsNull(DetCP.ImporteIVA8,0) + 
		IsNull(DetCP.ImporteIVA9,0) + IsNull(DetCP.ImporteIVA10,0))
		* cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
	Else DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
  End,
  CtaCte.ImporteTotal,
  CtaCte.Saldo,
  0
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN _TempCuentasCorrientesAcreedores CtaCte ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and cp.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE cp.FechaRecepcion<=@FechaHasta and IsNull(cp.Confirmado,'')<>'NO' and IsNull(CtaCte.Saldo,0)<>0 and 
	(DetCP.IdObra is not null and 
	 IsNull(Cuentas.IdObra,-1)=-1 and Cuentas.IdCuentaGasto Is Null and 
	 Not Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta)) 

 UNION ALL

 SELECT 
  ' NO IMPUTABLE',
  Case When cp.IdProveedor is not null
	Then IsNull(Proveedores.RazonSocial,'')
	Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
  End,
  Case When RubrosContables.Descripcion is not null 
	Then RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS
	Else Cuentas.Descripcion COLLATE Modern_Spanish_CI_AS
  End,
  'Vto.: '+Convert(varchar,IsNull(cp.FechaVencimiento,cp.FechaRecepcion),103)+' '+
	'Ref. : '+Convert(varchar,cp.NumeroReferencia)+' '+Convert(varchar,cp.FechaRecepcion,103)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
  Case When cp.Letra='A' or cp.Letra='M' 
	Then (DetCP.Importe + 
		IsNull(DetCP.ImporteIVA1,0) + IsNull(DetCP.ImporteIVA2,0) + 
		IsNull(DetCP.ImporteIVA3,0) + IsNull(DetCP.ImporteIVA4,0) + 
		IsNull(DetCP.ImporteIVA5,0) + IsNull(DetCP.ImporteIVA6,0) + 
		IsNull(DetCP.ImporteIVA7,0) + IsNull(DetCP.ImporteIVA8,0) + 
		IsNull(DetCP.ImporteIVA9,0) + IsNull(DetCP.ImporteIVA10,0))
		* cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
	Else DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
  End,
  CtaCte.ImporteTotal,
  CtaCte.Saldo,
  0
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN _TempCuentasCorrientesAcreedores CtaCte ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and cp.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE cp.FechaRecepcion<=@FechaHasta and IsNull(cp.Confirmado,'')<>'NO' and IsNull(CtaCte.Saldo,0)<>0 and 
	(DetCP.IdObra is null and 
	 Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	 Not Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta)) 

 UNION ALL

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else ' NO IMPUTABLE' End,
  IsNull(Proveedores.RazonSocial,''),
  '',
  'Vto.: '+Convert(varchar,IsNull(cp.FechaVencimiento,CtaCte.Fecha),103)+' '+
	Convert(varchar,CtaCte.Fecha,103)+' '+
	TiposComprobante.DescripcionAb+' '+
	Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+
		Convert(varchar,CtaCte.NumeroComprobante),
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal,
  CtaCte.Saldo,
  0
 FROM _TempCuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and cp.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=CtaCte.IdComprobante and (CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16)
 LEFT OUTER JOIN Obras ON Obras.IdObra=OrdenesPago.IdObra
 WHERE CtaCte.Fecha<=@FechaHasta and cp.IdComprobanteProveedor is null and IsNull(CtaCte.Saldo,0)<>0 


UPDATE _TempCuboSaldosComprobantesPorObraProveedor
SET SaldoImporte=ROUND(SaldoComprobante*Importe/TotalComprobante,2)
WHERE ISNULL(TotalComprobante,0)<>0

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF
