
CREATE  Procedure [dbo].[ComprobantesProveedores_TX_ResumenPorRendicionFF1]

@IdCuentaContableFF int, 
@NumeroRendicionFF int,
@IdObra int

AS 

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdTipoCuentaPercepciones int

SET @IdTipoCuentaGrupoIVA=IsNull((Select Parametros.IdTipoCuentaGrupoIVA From Parametros Where Parametros.IdParametro=1),0)
SET @IdTipoCuentaPercepciones=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='IdTipoCuentaGrupoPercepciones'),0)

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
	Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoIVA and 
			IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaPercepciones
		Then 	Case When cp.IdCodigoIva=1 
				Then dcp.Importe*cp.CotizacionMoneda 
				Else (dcp.Importe - 
				(IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
				 IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
				 IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
				 IsNull(dcp.ImporteIVA10,0)) * cp.CotizacionMoneda)
			End
		Else 0 
	End * TiposComprobante.Coeficiente,
	Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaPercepciones
		Then dcp.Importe*cp.CotizacionMoneda 
		Else 0 
	End * TiposComprobante.Coeficiente,
	(Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaGrupoIVA
		Then dcp.Importe*cp.CotizacionMoneda
		Else 0 
	 End + ((IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
		 IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
		 IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
		 IsNull(dcp.ImporteIVA10,0)) * cp.CotizacionMoneda)) * TiposComprobante.Coeficiente 
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto
 WHERE IsNull(cp.Confirmado,'')<>'NO' and IsNull(cp.NumeroRendicionFF,0)=@NumeroRendicionFF and 
	IsNull(cp.IdCuenta,0)=@IdCuentaContableFF and 
	(@IdObra=-1 or IsNull(dcp.IdObra,IsNull(cp.IdObra,0))=@IdObra)

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
SET IVA=IsNull((Select Top 1 cp.AjusteIva 
		From ComprobantesProveedores cp 
		Where cp.IdComprobanteProveedor=#Auxiliar0.IdComprobanteProveedor),0)

DELETE #Auxiliar0
WHERE IVA=0

UPDATE #Auxiliar0
SET IdCuenta=(Select Top 1 IdCuenta 
		From #Auxiliar1 
		Where #Auxiliar1.IdComprobanteProveedor=#Auxiliar0.IdComprobanteProveedor)
UPDATE #Auxiliar0
SET IdCuentaGasto=(Select Top 1 IdCuentaGasto 
			From #Auxiliar1 
			Where #Auxiliar1.IdComprobanteProveedor=#Auxiliar0.IdComprobanteProveedor)

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
INSERT INTO #Auxiliar2 
SELECT #Auxiliar1.IdCuenta, Sum(Neto), Sum(Percepciones), Sum(IVA)
FROM #Auxiliar1
GROUP BY #Auxiliar1.IdCuenta

SET NOCOUNT ON

SELECT  
 #Auxiliar2.IdCuenta,
 IsNull(Cuentas.Codigo,0) as [Codigo],
 Cuentas.Descripcion as [Cuenta],
 #Auxiliar2.Neto as [Neto],
 #Auxiliar2.Percepciones as [Percepciones],
 #Auxiliar2.IVA as [IVA]
FROM #Auxiliar2
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = #Auxiliar2.IdCuenta
ORDER by [Codigo], [Cuenta]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
