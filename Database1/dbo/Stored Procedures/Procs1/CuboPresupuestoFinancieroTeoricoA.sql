CREATE Procedure [dbo].[CuboPresupuestoFinancieroTeoricoA]

@VencimientosPosterioresA datetime,
@Dts varchar(100)

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 Tipo VARCHAR(20),
			 RubroFinanciero VARCHAR(50),
			 UnidadOperativa VARCHAR(50),
			 IdObra INTEGER,
			 Obra VARCHAR(20),
			 IdCondicionCompra INTEGER,
			 Fecha DATETIME,
			 Detalle VARCHAR(200),
			 Importe NUMERIC(18,2),
			 TotalComprobante NUMERIC(18,2),
			 SaldoComprobante NUMERIC(18,2),
			 SaldoImporte NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  '( Gastos )',
  RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS,
  Null,
  Case 	When DetCP.IdObra is not null 
		Then DetCP.IdObra
	When Cuentas.IdObra is not null 
		Then Cuentas.IdObra
		Else Null
  End,
  Case 	When (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra)
	When (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra)
		Else ' NO IMPUTABLE'
  End,
  cp.IdCondicionCompra,
  cp.FechaComprobante,
  Convert(varchar,cp.FechaComprobante,103)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)+' - '+
	'Proveedor : '+
	Case When cp.IdProveedor is not null
		Then IsNull(Proveedores.RazonSocial,'')
		Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P
			Where P.IdProveedor=cp.IdProveedorEventual)
	End,
  Case When cp.Letra='A' or cp.Letra='M' 
	Then (DetCP.Importe + 
		IsNull(DetCP.ImporteIVA1,0) +  IsNull(DetCP.ImporteIVA2,0) +  
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
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetCP.IdRubroContable
 LEFT OUTER JOIN _TempCuentasCorrientesAcreedores CtaCte ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and 
								cp.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE (cp.Confirmado is null or cp.Confirmado<>'NO') and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre 
		 From CuentasGastos
		 Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta))) and 
	IsNull(CtaCte.Saldo,0)<>0 

 UNION ALL

 SELECT 
  '( Bienes/Servicios )',
  RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS,
  Null,
  Case 	When DetCP.IdObra is not null 
		Then DetCP.IdObra
	When Cuentas.IdObra is not null 
		Then Cuentas.IdObra
		Else Null
  End,
  Case 	When (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra)
	When (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra) is not null 
		Then (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra)
		Else ' NO IMPUTABLE'
  End,
  cp.IdCondicionCompra,
  cp.FechaComprobante,
  Convert(varchar,cp.FechaComprobante,103)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)+' - '+
	'Proveedor : '+
	Case When cp.IdProveedor is not null
		Then IsNull(Proveedores.RazonSocial,'')
		Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P
			Where P.IdProveedor=cp.IdProveedorEventual)
	End,
  Case When cp.Letra='A' or cp.Letra='M' 
	Then (DetCP.Importe + 
		IsNull(DetCP.ImporteIVA1,0) +  IsNull(DetCP.ImporteIVA2,0) +  
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
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetCP.IdRubroContable
 LEFT OUTER JOIN _TempCuentasCorrientesAcreedores CtaCte ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and 
								cp.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE (cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(DetCP.IdObra is not null and 
	 Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	 Not Exists(Select Top 1 CuentasGastos.IdCuentaMadre 
			From CuentasGastos
			Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta))


UPDATE #Auxiliar1
SET RubroFinanciero='SIN RUBRO'
WHERE RubroFinanciero IS NULL

UPDATE #Auxiliar1
SET Obra=' NO IMPUTABLE'
WHERE Obra IS NULL

UPDATE #Auxiliar1
SET UnidadOperativa=(Select Top 1 UnidadesOperativas.Descripcion 
			From UnidadesOperativas
			Where UnidadesOperativas.IdUnidadOperativa=
				(Select Top 1 Obras.IdUnidadOperativa
				 From Obras 
				 Where #Auxiliar1.IdObra=Obras.IdObra))

UPDATE #Auxiliar1
SET UnidadOperativa='SIN UNIDAD OPERATIVA'
WHERE UnidadOperativa IS NULL

UPDATE #Auxiliar1
SET SaldoImporte=ROUND(SaldoComprobante*Importe/TotalComprobante,2)
WHERE ISNULL(TotalComprobante,0)<>0


TRUNCATE TABLE _TempCuboPresupuestoFinancieroTeorico

INSERT INTO _TempCuboPresupuestoFinancieroTeorico 
 SELECT 
  Tipo,
  RubroFinanciero,
  UnidadOperativa,
  Obra,
  DateAdd(day,IsNull(Tmp.Dias,0),Fecha),
  Detalle,
  SaldoImporte * IsNull(Tmp.Porcentaje,100)/100
 FROM #Auxiliar1
 LEFT OUTER JOIN _TempCondicionesCompra Tmp ON #Auxiliar1.IdCondicionCompra=Tmp.IdCondicionCompra
 WHERE SaldoImporte<>0 and DateAdd(day,IsNull(Tmp.Dias,0),Fecha)>=@VencimientosPosterioresA

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

DROP TABLE #Auxiliar1

SET NOCOUNT OFF