CREATE Procedure [dbo].[Proveedores_TX_PercepcionesIVA]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdCuentaPercepcionIVACompras int
SET @IdCuentaPercepcionIVACompras=(Select IdCuentaPercepcionIVACompras From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProveedor INTEGER,
			 K_Registro INTEGER,
			 CodigoProveedor VARCHAR(20),
			 Proveedor VARCHAR(50),
			 Cuit VARCHAR(20),
			 Letra VARCHAR(1),
			 Comprobante1 INTEGER,
			 Comprobante2 INTEGER,
			 Fecha DATETIME,
			 ImportePercepcionIVA NUMERIC(18,2),
			 Registro VARCHAR(70),
			 FechaComprobante DATETIME,
			)
INSERT INTO #Auxiliar1 
 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.Importe * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuenta is not null and DetCom.IdCuenta=@IdCuentaPercepcionIVACompras and 
	(DetCom.Importe is not null and DetCom.Importe>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA1 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras1 is not null and DetCom.IdCuentaIvaCompras1=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA1 is not null and DetCom.ImporteIVA1>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA2 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras2 is not null and DetCom.IdCuentaIvaCompras2=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA2 is not null and DetCom.ImporteIVA2>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA3 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras3 is not null and DetCom.IdCuentaIvaCompras3=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA3 is not null and DetCom.ImporteIVA3>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA4 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras4 is not null and DetCom.IdCuentaIvaCompras4=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA4 is not null and DetCom.ImporteIVA4>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA5 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras5 is not null and DetCom.IdCuentaIvaCompras5=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA5 is not null and DetCom.ImporteIVA5>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA6 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras6 is not null and DetCom.IdCuentaIvaCompras6=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA6 is not null and DetCom.ImporteIVA6>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA7 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras7 is not null and DetCom.IdCuentaIvaCompras7=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA7 is not null and DetCom.ImporteIVA7>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA8 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras8 is not null and DetCom.IdCuentaIvaCompras8=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA8 is not null and DetCom.ImporteIVA8>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA9 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras9 is not null and DetCom.IdCuentaIvaCompras9=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA9 is not null and DetCom.ImporteIVA9>0)

UNION ALL

 SELECT  
  DetCom.IdComprobanteProveedor,
  IsNull(cp.IdProveedor,cp.IdProveedorEventual),
  1,
  Case When Proveedores.CodigoEmpresa is not null
	Then Proveedores.CodigoEmpresa
	Else (Select Top 1 Prov.CodigoEmpresa From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.RazonSocial is not null
	Then Proveedores.RazonSocial
	Else (Select Top 1 Prov.RazonSocial From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  Case When Proveedores.Cuit is not null
	Then Proveedores.Cuit
	Else (Select Top 1 Prov.Cuit From Proveedores Prov Where Prov.IdProveedor=cp.IdProveedorEventual)
  End, 
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  cp.FechaRecepcion,
  DetCom.ImporteIVA10 * tc.Coeficiente * cp.CotizacionMoneda,
  '',
  cp.FechaComprobante
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	DetCom.IdCuentaIvaCompras10 is not null and DetCom.IdCuentaIvaCompras10=@IdCuentaPercepcionIVACompras and 
	(DetCom.ImporteIVA10 is not null and DetCom.ImporteIVA10>0)

 UNION ALL

 SELECT 
  0,
  Valores.IdBanco,
  1,
  '',
  Bancos.Nombre,
  Case When Bancos.Cuit is not null and len(Bancos.Cuit)=13 Then Bancos.Cuit Else '00-00000000-0' End,
  ' ',
  0,
  Valores.NumeroComprobante,
  Valores.FechaComprobante,
  IsNull(Valores.IVA,0) * tc.Coeficiente * ISNull(Valores.CotizacionMoneda,1),
  '',
  Null
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 WHERE Valores.Estado='G' and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.FechaComprobante between @FechaDesde and @FechaHasta) and
	IsNull(Valores.IdCuentaIVA,0)=@IdCuentaPercepcionIVACompras and 
	IsNull(Valores.IVA,0)<>0

UPDATE #Auxiliar1
SET Comprobante1 = 0
WHERE Comprobante1 IS NULL

UPDATE #Auxiliar1
SET Comprobante2 = 0
WHERE Comprobante2 IS NULL

UPDATE #Auxiliar1
SET Registro = 	'493'+Cuit+
		Substring('00',1,2-len(Convert(varchar,Day(FechaComprobante))))+Convert(varchar,Day(FechaComprobante))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(FechaComprobante))))+Convert(varchar,Month(FechaComprobante))+'/'+
			Convert(varchar,Year(FechaComprobante))+
		'0000'+
		Substring('0000',1,4-Len(Convert(varchar,Comprobante1)))+Convert(varchar,Comprobante1)+
		Substring('00000000',1,8-Len(Substring(Convert(varchar,Comprobante2),1,8)))+Substring(Convert(varchar,Comprobante2),1,8)+
		Substring('0000000000000000',1,16-len(Convert(varchar,ImportePercepcionIVA)))+Convert(varchar,ImportePercepcionIVA)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0001111111133'
SET @vector_T='0001548559600'

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	1 as [K_Orden],
	CodigoProveedor as [Codigo],
	Proveedor as [Proveedor],
	Cuit as [Cuit],
	Null as [Comprobante],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Registro],
	Null as [Imp. percepcion],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdProveedor,CodigoProveedor,Proveedor,Cuit

UNION ALL 

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	2 as [K_Orden],
	Null as [Codigo],
	Null as [Proveedor],
	Null as [Cuit],
	Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,Comprobante1)))+Convert(varchar,Comprobante1)+'-'+
		Substring('00000000',1,8-Len(Substring(Convert(varchar,Comprobante2),1,8)))+Substring(Convert(varchar,Comprobante2),1,8) as [Comprobante],
	Fecha as [Fecha],
	FechaComprobante as [Fecha Comp.],
	Registro as [Registro],
	ImportePercepcionIVA as [Imp. percepcion],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

UNION ALL 

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	3 as [K_Orden],
	Null as [Codigo],
	'TOTAL PROVEEDOR' as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Registro],
	SUM(ImportePercepcionIVA) as [Imp. percepcion],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdProveedor,CodigoProveedor

UNION ALL 

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	4 as [K_Orden],
	Null as [Codigo],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Registro],
	Null as [Imp. percepcion],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdProveedor,CodigoProveedor

UNION ALL 

SELECT 
	0 as [IdProveedor],
	'zzzz' as [K_Codigo],
	5 as [K_Orden],
	Null as [Codigo],
	'TOTAL GENERAL' as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Registro],
	SUM(ImportePercepcionIVA) as [Imp. percepcion],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Codigo],[IdProveedor],[K_Orden],[Fecha],[Comprobante]

DROP TABLE #Auxiliar1