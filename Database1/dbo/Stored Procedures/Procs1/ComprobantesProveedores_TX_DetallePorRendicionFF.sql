
CREATE  Procedure [dbo].[ComprobantesProveedores_TX_DetallePorRendicionFF]

@IdCuentaContableFF int, 
@NumeroRendicionFF int,
@IdObra int

AS 

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdTipoCuentaPercepciones int
SET @IdTipoCuentaGrupoIVA=IsNull((Select Parametros.IdTipoCuentaGrupoIVA From Parametros Where Parametros.IdParametro=1),0)
SET @IdTipoCuentaPercepciones=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='IdTipoCuentaGrupoPercepciones'),0)

CREATE TABLE #Auxiliar1 (IdComprobanteProveedor INTEGER)
INSERT INTO #Auxiliar1 
 SELECT dcp.IdComprobanteProveedor
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE (cp.Confirmado is null or cp.Confirmado<>'NO') and 
	IsNull(cp.NumeroRendicionFF,0)=@NumeroRendicionFF and 
	IsNull(cp.IdCuenta,0)=@IdCuentaContableFF and 
	(@IdObra=-1 or IsNull(dcp.IdObra,IsNull(cp.IdObra,0))=@IdObra)
 GROUP BY dcp.IdComprobanteProveedor

CREATE TABLE #Auxiliar2
			(
			 IdComprobanteProveedor INTEGER,
			 IdDetalleComprobanteProveedor INTEGER,
			 IVA NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdComprobanteProveedor, 0, IsNull(cp.AjusteIva,0)
 FROM #Auxiliar1
 LEFT OUTER JOIN ComprobantesProveedores cp ON #Auxiliar1.IdComprobanteProveedor = cp.IdComprobanteProveedor

DELETE #Auxiliar2
WHERE IVA=0

UPDATE #Auxiliar2
SET IdDetalleComprobanteProveedor=(Select Top 1 dcp.IdDetalleComprobanteProveedor
					From DetalleComprobantesProveedores dcp 
					Where dcp.IdComprobanteProveedor=#Auxiliar2.IdComprobanteProveedor)

SET NOCOUNT OFF

SELECT 
 cp.FechaComprobante as [Fecha], 
 TiposComprobante.DescripcionAb as [Tipo],
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 Proveedores.RazonSocial as [Proveedor], 
 Proveedores.Cuit as [Cuit], 
 DescripcionIva.Descripcion as [CondicionIVA], 
 Cuentas.Codigo as [CodigoCuenta],
 Cuentas.Descripcion as [Cuenta],
 Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoIVA and 
		IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaPercepciones
	Then 	Case When cp.IdCodigoIva=1 
			Then dcp.Importe*cp.CotizacionMoneda 
			Else (dcp.Importe - 
			(IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
			 IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
			 IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
			 IsNull(dcp.ImporteIVA10,0)+IsNull(#Auxiliar2.IVA,0)) * cp.CotizacionMoneda)
		End
	Else 0 
 End * TiposComprobante.Coeficiente as [Neto],
 (Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaGrupoIVA 
	Then dcp.Importe*cp.CotizacionMoneda 
	Else 0 
  End + ((IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
	 IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
	 IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
	 IsNull(dcp.ImporteIVA10,0)+IsNull(#Auxiliar2.IVA,0))*cp.CotizacionMoneda)) * TiposComprobante.Coeficiente as [Iva],
 Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaPercepciones 
	Then dcp.Importe*cp.CotizacionMoneda 
	Else 0 
 End * TiposComprobante.Coeficiente as [Percepcion]
FROM DetalleComprobantesProveedores dcp 
LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,cp.IdProveedorEventual) = Proveedores.IdProveedor
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN #Auxiliar2 ON dcp.IdDetalleComprobanteProveedor = #Auxiliar2.IdDetalleComprobanteProveedor
WHERE (cp.Confirmado is null or cp.Confirmado<>'NO') and 
	IsNull(cp.NumeroRendicionFF,0)=@NumeroRendicionFF and 
	IsNull(cp.IdCuenta,0)=@IdCuentaContableFF and 
	(@IdObra=-1 or IsNull(dcp.IdObra,IsNull(cp.IdObra,0))=@IdObra)
ORDER BY  cp.FechaComprobante,  cp.Letra, cp.NumeroComprobante1, cp.NumeroComprobante2, Cuentas.Codigo

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
