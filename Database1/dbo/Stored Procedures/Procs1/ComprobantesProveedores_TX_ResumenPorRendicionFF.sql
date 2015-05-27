CREATE  Procedure [dbo].[ComprobantesProveedores_TX_ResumenPorRendicionFF]

@IdCuentaContableFF int, 
@NumeroRendicionFF int,
@IdObra int

AS 

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdTipoCuentaPercepciones int, @ModeloContableSinApertura varchar(2), @IdTipoComprobanteDevolucionFondoFijo int

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IdTipoCuentaPercepciones=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoCuentaGrupoPercepciones'),0)
SET @ModeloContableSinApertura=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ModeloContableSinApertura'),'NO')
SET @IdTipoComprobanteDevolucionFondoFijo=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoComprobanteDevolucionFondoFijo'),0)

CREATE TABLE #Auxiliar1
			(
			 IdComprobanteProveedor INTEGER,
			 IdCuenta INTEGER,
			 IdCuentaGasto INTEGER,
			 Neto NUMERIC(18, 2),
			 Percepciones NUMERIC(18, 2),
			 IVA NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	dcp.IdComprobanteProveedor,
	dcp.IdCuenta,
	Cuentas.IdCuentaGasto,
	Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoIVA and IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaPercepciones
		Then Case When cp.IdCodigoIva=1 Then dcp.Importe*cp.CotizacionMoneda 
				Else (dcp.Importe - (IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
						IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+IsNull(dcp.ImporteIVA7,0)+
						IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+IsNull(dcp.ImporteIVA10,0)) * cp.CotizacionMoneda)
			 End
			 Else 0 
	End * TiposComprobante.Coeficiente, -- * Case When TiposComprobante.DescripcionAb='DFF' Then -1 Else 1 End,
	Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaPercepciones Then dcp.Importe*cp.CotizacionMoneda Else 0 End * 
		TiposComprobante.Coeficiente, -- * Case When TiposComprobante.DescripcionAb='DFF' Then -1 Else 1 End,
	(Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaGrupoIVA Then dcp.Importe*cp.CotizacionMoneda Else 0 End + 
		((IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
		  IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+IsNull(dcp.ImporteIVA10,0)) * cp.CotizacionMoneda)) * 
		TiposComprobante.Coeficiente -- * Case When TiposComprobante.DescripcionAb='DFF' Then -1 Else 1 End
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto
 WHERE (cp.Confirmado is null or cp.Confirmado<>'NO') and 
	IsNull(cp.NumeroRendicionFF,0)=@NumeroRendicionFF and 
	IsNull(cp.IdCuenta,0)=@IdCuentaContableFF and 
	(@IdObra=-1 or IsNull(dcp.IdObra,IsNull(cp.IdObra,0))=@IdObra) and 
	cp.IdTipoComprobante<>@IdTipoComprobanteDevolucionFondoFijo

CREATE TABLE #Auxiliar0
			(
			 IdComprobanteProveedor INTEGER,
			 IdCuenta INTEGER,
			 IdCuentaGasto INTEGER,
			 Neto NUMERIC(18, 2),
			 Percepciones NUMERIC(18, 2),
			 IVA NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar0 
 SELECT IdComprobanteProveedor, Null, Null, 0, 0, 0
 FROM #Auxiliar1
 GROUP BY IdComprobanteProveedor

UPDATE #Auxiliar0
SET IVA=IsNull((Select Top 1 cp.AjusteIva From ComprobantesProveedores cp Where cp.IdComprobanteProveedor=#Auxiliar0.IdComprobanteProveedor),0)

DELETE #Auxiliar0
WHERE IVA=0

UPDATE #Auxiliar0
SET IdCuenta=(Select Top 1 IdCuenta From #Auxiliar1 Where #Auxiliar1.IdComprobanteProveedor=#Auxiliar0.IdComprobanteProveedor)

UPDATE #Auxiliar0
SET IdCuentaGasto=(Select Top 1 IdCuentaGasto From #Auxiliar1 Where #Auxiliar1.IdComprobanteProveedor=#Auxiliar0.IdComprobanteProveedor)

INSERT INTO #Auxiliar1 
 SELECT * 
 FROM #Auxiliar0

CREATE TABLE #Auxiliar2
			(
			 IdCuenta INTEGER,
			 Neto NUMERIC(18, 2),
			 Percepciones NUMERIC(18, 2),
			 IVA NUMERIC(18, 2)
			)
IF @ModeloContableSinApertura='NO'
  BEGIN
	INSERT INTO #Auxiliar2 
	SELECT #Auxiliar1.IdCuentaGasto, Sum(Neto), Sum(Percepciones), Sum(IVA)
	FROM #Auxiliar1
	GROUP BY #Auxiliar1.IdCuentaGasto
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar2 
	SELECT #Auxiliar1.IdCuenta, Sum(Neto), Sum(Percepciones), Sum(IVA)
	FROM #Auxiliar1
	GROUP BY #Auxiliar1.IdCuenta
  END

SET NOCOUNT ON

IF @ModeloContableSinApertura='NO'
  BEGIN
	SELECT  
	 CuentasGastos.IdCuentaGasto as [IdCuenta],
	 IsNull(CuentasGastos.CodigoSubcuenta,0) as [Codigo],
	 CuentasGastos.Descripcion as [Cuenta],
	 #Auxiliar2.Neto as [Neto],
	 #Auxiliar2.Percepciones as [Percepciones],
	 #Auxiliar2.IVA as [IVA]
	FROM CuentasGastos
	LEFT OUTER JOIN #Auxiliar2 ON CuentasGastos.IdCuentaGasto = #Auxiliar2.IdCuenta
	
	UNION ALL
	
	SELECT  
	 0 as [IdCuenta],
	 0 as [Codigo],
	 ' Otros' as [Cuenta],
	 #Auxiliar2.Neto as [Neto],
	 #Auxiliar2.Percepciones as [Percepciones],
	 #Auxiliar2.IVA as [IVA]
	FROM #Auxiliar2
	WHERE IsNull(#Auxiliar2.IdCuenta,0)=0
	
	ORDER by [Codigo], [Cuenta]
  END
ELSE
  BEGIN
	SELECT  
	 Cuentas.IdCuenta as [IdCuenta],
	 IsNull(Cuentas.Codigo,0) as [Codigo],
	 Cuentas.Descripcion as [Cuenta],
	 #Auxiliar2.Neto as [Neto],
	 #Auxiliar2.Percepciones as [Percepciones],
	 #Auxiliar2.IVA as [IVA]
	FROM #Auxiliar2
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = #Auxiliar2.IdCuenta
	
	UNION ALL
	
	SELECT  
	 0 as [IdCuenta],
	 0 as [Codigo],
	 ' Otros' as [Cuenta],
	 #Auxiliar2.Neto as [Neto],
	 #Auxiliar2.Percepciones as [Percepciones],
	 #Auxiliar2.IVA as [IVA]
	FROM #Auxiliar2
	WHERE IsNull(#Auxiliar2.IdCuenta,0)=0
	
	ORDER by [Codigo], [Cuenta]
  END

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
