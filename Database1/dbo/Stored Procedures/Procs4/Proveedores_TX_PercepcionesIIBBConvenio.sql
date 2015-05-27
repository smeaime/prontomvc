CREATE PROCEDURE [dbo].[Proveedores_TX_PercepcionesIIBBConvenio]

@FechaDesde datetime,
@FechaHasta datetime,
@Formato varchar(10) = Null

AS

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')

DECLARE @CuitAduana varchar(13), @IdTipoCuentaGrupoIVA int

SET @CuitAduana='33-69345023-9'
SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProvincia INTEGER,
			 Tipo VARCHAR(10),
			 Jurisdiccion VARCHAR(3),
			 Provincia VARCHAR(50),
			 Proveedor VARCHAR(50),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 FechaComprobante DATETIME,
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 TipoComprobante VARCHAR(1),
			 Letra VARCHAR(1),
			 ImporteIIBB NUMERIC(18,0),
			 Importacion_Despacho VARCHAR(20),
			 CBU VARCHAR(22),
			 IdMoneda INTEGER,
			 Registro VARCHAR(80),
			 ImporteBase NUMERIC(18,0)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  cp.IdComprobanteProveedor,
  (Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(dcp.IdCuenta,-1)),
  'PERCEPCION',
  Null,
  Null,
  Proveedores.RazonSocial, 
  Proveedores.Cuit,
  cp.FechaRecepcion,
  cp.FechaComprobante,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  Case When cp.IdTipoComprobante=11 Then 'F'
	When cp.IdTipoComprobante=10 Then 'C'
	When cp.IdTipoComprobante=18 Then 'D'
	When cp.IdTipoComprobante=31 Then 'D'
	When cp.IdTipoComprobante=34 Then 'D'
	When cp.IdTipoComprobante=35 Then 'D'
	When cp.IdTipoComprobante=40 Then 'F'
	When cp.IdTipoComprobante=51 Then 'F'
	When cp.IdTipoComprobante=52 Then 'F'
	When cp.IdTipoComprobante=53 Then 'F'
	Else 'O'
  End,
  cp.Letra,
  dcp.Importe * cp.CotizacionMoneda * 100, --* TiposComprobante.Coeficiente,
  Substring(Rtrim(IsNull(dcp.Importacion_Despacho,IsNull(cp.Importacion_Despacho,'0'))),1,20),
  Null,
  cp.IdMoneda,
  '',
  0
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=cp.IdIBCondicion
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')<>'NO' and 
	Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(dcp.IdCuenta,-1)) and 
	Proveedores.Cuit<>@CuitAduana

UPDATE #Auxiliar1
SET ImporteBase=IsNull((Select Sum(IsNull(dcp2.Importe * cp.CotizacionMoneda * 100,0))
						From DetalleComprobantesProveedores dcp2
						Left Outer Join ComprobantesProveedores cp On dcp2.IdComprobanteProveedor=cp.IdComprobanteProveedor
						Left Outer Join Cuentas On Cuentas.IdCuenta=dcp2.IdCuenta
						Where dcp2.IdComprobanteProveedor=#Auxiliar1.IdComprobanteProveedor and 
							Not Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(dcp2.IdCuenta,-1)) and 
							IsNull(Cuentas.IdTipoCuentaGrupo,0)<>@IdTipoCuentaGrupoIVA),0) 

INSERT INTO #Auxiliar1 
 SELECT 
  0,
  (Select Top 1 Pv.IdProvincia From Provincias Pv 
	Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(Valores.IdCuentaContable,-1) or IsNull(Pv.IdCuentaRetencionIBrutosCobranzas,0)=IsNull(Valores.IdCuentaContable,-1)),
  'BANCOS',
  Null,
  Null,
  Bancos.Nombre,
  Case When Bancos.Cuit is not null and len(Bancos.Cuit)=13 Then Bancos.Cuit Else '00-00000000-0' End,
  Valores.FechaComprobante,
  Valores.FechaComprobante,
  0,
  Valores.NumeroComprobante,
  Case When TiposComprobante.Coeficiente=1 Then 'D'Else 'C' End,
  'A',
  Valores.Importe * 100,
  '',
  IsNull(CuentasBancarias.CBU,'0000000000000000000000'),
  Valores.IdMoneda,
  '',
  0
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 WHERE Valores.Estado='G' and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.FechaComprobante between @FechaDesde and @FechaHasta) and
	Exists(Select Top 1 Pv.IdProvincia From Provincias Pv 
		Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(Valores.IdCuentaContable,-1) or 
			IsNull(Pv.IdCuentaRetencionIBrutosCobranzas,0)=IsNull(Valores.IdCuentaContable,-1))

/*
 UNION ALL

 SELECT  
  cp.IdComprobanteProveedor,
  IsNull(IBCondiciones.IdProvincia,0),
  SubString(IsNull(Provincias.InformacionAuxiliar,'000'),1,3),
  IsNull(Provincias.Nombre,'SD'),
  Proveedores.RazonSocial, 
  Proveedores.Cuit,
  cp.FechaRecepcion,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  Case When cp.IdTipoComprobante=11 Then 'F'
	When cp.IdTipoComprobante=10 Then 'C'
	When cp.IdTipoComprobante=18 Then 'D'
	When cp.IdTipoComprobante=31 Then 'D'
	When cp.IdTipoComprobante=34 Then 'D'
	When cp.IdTipoComprobante=35 Then 'D'
	When cp.IdTipoComprobante=40 Then 'F'
	Else 'O'
  End,
  cp.Letra,
  dcp.Importe * cp.CotizacionMoneda * IsNull(dcp.PorcentajeProvinciaDestino2/100,0) * 100,
  Substring(Rtrim(IsNull(cp.Importacion_Despacho,'')),1,20),
  ''
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=cp.IdIBCondicion
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IsNull(dcp.IdProvinciaDestino2,IBCondiciones.IdProvincia)
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	cp.IdIBCondicion is not null and dcp.IdProvinciaDestino2 is not null and 
	Exists(Select Top 1 Pv.IdProvincia From Provincias Pv 
		Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(dcp.IdCuenta,-1))
*/

CREATE TABLE #Auxiliar2 
			(
			 IdProvincia INTEGER,
			 Tipo VARCHAR(10),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 Coeficiente INTEGER,
			 ImporteIIBB NUMERIC(18,0),
			 Importacion_Despacho VARCHAR(20)
			)
INSERT INTO #Auxiliar2 
 SELECT  
  (Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(dcp.IdCuenta,-1)),
  'ADUANA',
  Proveedores.Cuit,
  cp.FechaRecepcion,
  TiposComprobante.Coeficiente,
  dcp.Importe * cp.CotizacionMoneda * 100, -- * TiposComprobante.Coeficiente,
  Substring(Rtrim(IsNull(cp.Importacion_Despacho,'0')),1,20)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')<>'NO' and 
	Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(dcp.IdCuenta,-1)) and 
	Proveedores.Cuit=@CuitAduana

INSERT INTO #Auxiliar1 
 SELECT 0, #Auxiliar2.IdProvincia, #Auxiliar2.Tipo, Null, Null, Null, #Auxiliar2.Cuit, #Auxiliar2.Fecha, #Auxiliar2.Fecha, Null, Null, Null, Null, 
		Sum(IsNull(#Auxiliar2.ImporteIIBB,0)*IsNull(#Auxiliar2.Coeficiente,1)), #Auxiliar2.Importacion_Despacho, Null, Null, '', 0
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdProvincia, #Auxiliar2.Tipo, #Auxiliar2.Cuit, #Auxiliar2.Fecha, #Auxiliar2.Importacion_Despacho

UPDATE #Auxiliar1
SET ImporteIIBB=0 
WHERE ImporteIIBB IS NULL

UPDATE #Auxiliar1
SET Jurisdiccion=SubString(IsNull((Select Top 1 InformacionAuxiliar From Provincias Where #Auxiliar1.IdProvincia=Provincias.IdProvincia),'000'),1,3)

UPDATE #Auxiliar1
SET Provincia=IsNull((Select Top 1 Nombre From Provincias Where #Auxiliar1.IdProvincia=Provincias.IdProvincia),'SD')
  
UPDATE #Auxiliar1
SET Cuit = '00-00000000-0'
WHERE Cuit IS NULL

CREATE TABLE #Auxiliar3 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProvincia INTEGER,
			 Tipo VARCHAR(10),
			 Jurisdiccion VARCHAR(3),
			 Provincia VARCHAR(50),
			 Proveedor VARCHAR(50),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 FechaComprobante DATETIME,
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 TipoComprobante VARCHAR(1),
			 Letra VARCHAR(1),
			 ImporteIIBB NUMERIC(18,0),
			 Importacion_Despacho VARCHAR(20),
			 CBU VARCHAR(22),
			 IdMoneda INTEGER,
			 Registro VARCHAR(80),
			 ImporteBase NUMERIC(18,0)
			)
INSERT INTO #Auxiliar3 
 SELECT IdComprobanteProveedor, IdProvincia, Tipo, Jurisdiccion, Provincia, Proveedor, Cuit, Fecha, FechaComprobante, NumeroComprobante1, NumeroComprobante2, 
		TipoComprobante, Letra, Sum(IsNull(ImporteIIBB,0)), Importacion_Despacho, CBU, IdMoneda, Registro, Max(IsNull(ImporteBase,0))
 FROM #Auxiliar1
 GROUP BY IdComprobanteProveedor, IdProvincia, Tipo, Jurisdiccion, Provincia, Proveedor, Cuit, Fecha, FechaComprobante, NumeroComprobante1, NumeroComprobante2, 
			TipoComprobante, Letra, Importacion_Despacho, CBU, IdMoneda, Registro

IF @Formato='e-sicol'
  BEGIN
	UPDATE #Auxiliar3
	SET Registro = Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1) + 
		Substring('        ',1,8-len(Convert(varchar,NumeroComprobante2)))+Convert(varchar,NumeroComprobante2) + 
		Convert(varchar,Year(FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(FechaComprobante))))+Convert(varchar,Month(FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Day(FechaComprobante))))+Convert(varchar,Day(FechaComprobante)) +
		Substring('0000',1,4-len(Convert(varchar,NumeroComprobante1)))+Convert(varchar,NumeroComprobante1) + 
		Case When TipoComprobante='C' 
				Then Substring(Substring('               ',1,15-len(Convert(varchar,ImporteBase*-1)))+Convert(varchar,ImporteBase*-1),1,13)+'.'+
					 Substring(Substring('               ',1,15-len(Convert(varchar,ImporteBase*-1)))+Convert(varchar,ImporteBase*-1),14,2)
				Else Substring(Substring('               ',1,15-len(Convert(varchar,ImporteBase)))+Convert(varchar,ImporteBase),1,13)+'.'+
					 Substring(Substring('               ',1,15-len(Convert(varchar,ImporteBase)))+Convert(varchar,ImporteBase),14,2)
		End + 
		Case When TipoComprobante='C' 
				Then Substring(Substring('               ',1,15-len(Convert(varchar,ImporteIIBB*-1)))+Convert(varchar,ImporteIIBB*-1),1,13)+'.'+
					 Substring(Substring('               ',1,15-len(Convert(varchar,ImporteIIBB*-1)))+Convert(varchar,ImporteIIBB*-1),14,2)
				Else Substring(Substring('               ',1,15-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),1,13)+'.'+
					 Substring(Substring('               ',1,15-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),14,2)
		End + 
		--Case When TipoComprobante='C' Then 'D' When TipoComprobante='D' Then 'R' Else TipoComprobante End + 
		Case When TipoComprobante='C' Then 'F' When TipoComprobante='D' Then 'R' Else TipoComprobante End + 
		Letra 
	WHERE Tipo='PERCEPCION'

	UPDATE #Auxiliar3
	SET Registro = Jurisdiccion + Cuit + Convert(varchar,Fecha,103) + 
			Substring('0000000000000000000000',1,20-len(Rtrim(Importacion_Despacho)))+Rtrim(Importacion_Despacho) + 
			Substring(Substring('0000000',1,7-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),1,7)+'.00'
--			+Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),8,2)
	WHERE Tipo='ADUANA'

	UPDATE #Auxiliar3
	SET Registro = Jurisdiccion + Cuit + 
			Convert(varchar,Year(Fecha)) + '/' + 
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha)) + 
			Substring('0000000000000000000000',1,22-len(CBU))+CBU + 
			'CC' + 
			Case When IsNull(IdMoneda,0)=1 Then 'P' Else 'E' End + 
			Substring(Substring('0000000',1,7-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),1,7)+'.00'
--			+Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),8,2)
	WHERE Tipo='BANCOS'
  END
ELSE
  BEGIN
	UPDATE #Auxiliar3
	SET Registro = Jurisdiccion + Cuit + Convert(varchar,FechaComprobante,103) + 
		Substring('0000',1,4-len(Convert(varchar,NumeroComprobante1)))+Convert(varchar,NumeroComprobante1) + 
		Substring('00000000',1,8-len(Convert(varchar,NumeroComprobante2)))+Convert(varchar,NumeroComprobante2) + 
		TipoComprobante + Letra + 
		Case When TipoComprobante='C' Then '-' Else '0' End+
			Substring(Substring('0000000000',1,10-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),2,7)+','+
			Substring(Substring('0000000000',1,10-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),9,2)
	WHERE Tipo='PERCEPCION'

	UPDATE #Auxiliar3
	SET Registro = Jurisdiccion + Cuit + Convert(varchar,Fecha,103) + 
			Substring('0000000000000000000000',1,20-len(Rtrim(Importacion_Despacho)))+Rtrim(Importacion_Despacho) + 
			Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),1,7)+','+
				Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),8,2)
	WHERE Tipo='ADUANA'

	UPDATE #Auxiliar3
	SET Registro = Jurisdiccion + Cuit + 
			Convert(varchar,Year(Fecha)) + '/' + 
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha)) + 
			Substring('0000000000000000000000',1,22-len(CBU))+CBU + 
			'CC' + 
			Case When IsNull(IdMoneda,0)=1 Then 'P' Else 'E' End + 
			Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),1,7)+','+
				Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),8,2)
	WHERE Tipo='BANCOS'
  END

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00001111111111111611133'
SET @vector_T='00001992335442133433300'

SELECT 
	Tipo as [K_Tipo],
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	1 as [K_Orden],
	Tipo as [Tipo],
	Tipo as [Aux0],
	Provincia as [Aux1],
	Provincia as [Provincia],
	Jurisdiccion as [Jurisdiccion],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Sucursal],
	Null as [Comprobante],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	Null as [Imp. percibido],
	Null as [Registro],
	Null as [Nro.Despacho],
	Null as [Importe Base],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
WHERE ImporteIIBB<>0
GROUP BY Tipo, IdProvincia, Provincia, Jurisdiccion

UNION ALL 

SELECT 
	Tipo as [K_Tipo],
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	2 as [K_Orden],
	Null as [Tipo],
	Tipo as [Aux0],
	Provincia as [Aux1],
	Null as [Provincia],
	Null as [Jurisdiccion],	Proveedor as [Proveedor],
	Cuit as [Cuit],
	Fecha as [Fecha],
	FechaComprobante as [Fecha Comp.],
	NumeroComprobante1 as [Sucursal],
	NumeroComprobante2 as [Comprobante],
	TipoComprobante as [Tipo Comp.],
	Letra as [Letra Comp.],
	ImporteIIBB/100 as [Imp. percibido],
	Registro as [Registro],
	Importacion_Despacho as [Nro.Despacho],
	ImporteBase as [Importe Base],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
WHERE ImporteIIBB<>0

UNION ALL 

SELECT 
	Tipo as [K_Tipo],
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	3 as [K_Orden],
	Null as [Tipo],
	Tipo as [Aux0],
	Provincia as [Aux1],
	Null as [Provincia],
	Null as [Jurisdiccion],
	'TOTAL PROVINCIA' as [Proveedor],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Sucursal],
	Null as [Comprobante],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	SUM(Case When TipoComprobante='C' Then ImporteIIBB*-1 Else ImporteIIBB End/100) as [Imp. percibido],
	Null as [Registro],
	Null as [Nro.Despacho],
	Null as [Importe Base],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
WHERE ImporteIIBB<>0
GROUP BY Tipo, IdProvincia, Provincia

UNION ALL 

SELECT 
	Tipo as [K_Tipo],
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	4 as [K_Orden],
	Null as [Tipo],
	Tipo as [Aux0],
	Provincia as [Aux1],
	Null as [Provincia],
	Null as [Jurisdiccion],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Sucursal],
	Null as [Comprobante],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	Null as [Imp. percibido],
	Null as [Registro],
	Null as [Nro.Despacho],
	Null as [Importe Base],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
WHERE ImporteIIBB<>0
GROUP BY Tipo, IdProvincia, Provincia

UNION ALL 

SELECT 
	'zzzz' as [K_Tipo],
	0 as [K_IdProvincia],
	'zzzz' as [K_Provincia],
	5 as [K_Orden],
	Null as [Tipo],
	Null as [Aux0],
	Null as [Aux1],
	Null as [Provincia],
	Null as [Jurisdiccion],
	'TOTAL GENERAL' as [Proveedor],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Fecha Comp.],
	Null as [Sucursal],
	Null as [Comprobante],
	Null as [Tipo Comp.],
	Null as [Letra Comp.],
	SUM(Case When TipoComprobante='C' Then ImporteIIBB*-1 Else ImporteIIBB End/100) as [Imp. percibido],
	Null as [Registro],
	Null as [Nro.Despacho],
	Null as [Importe Base],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
WHERE ImporteIIBB<>0

ORDER BY [K_Tipo], [K_Provincia], [K_IdProvincia], [K_Orden], [Fecha]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3