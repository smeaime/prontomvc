CREATE PROCEDURE [dbo].[Proveedores_TX_PercepcionesIIBB]

@FechaDesde datetime,
@FechaHasta datetime,
@Formato varchar(10) = Null

AS

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')

DECLARE @CuitAduana varchar(13), @NumeroAgentePercepcionIIBB int, @DigitoVerificadorNumeroAgentePercepcionIIBB int, @IdTipoCuentaGrupoIVA int, 
		@IdTipoCuentaGrupoPercepciones int, @NumeroAgentePercepcionIIBB2 varchar(5)

SET @CuitAduana='33-69345023-9'
SET @NumeroAgentePercepcionIIBB=IsNull((Select Top 1 NumeroAgentePercepcionIIBB From Empresa Where IdEmpresa=1),0)
SET @DigitoVerificadorNumeroAgentePercepcionIIBB=IsNull((Select Top 1 DigitoVerificadorNumeroAgentePercepcionIIBB From Empresa Where IdEmpresa=1),0)
SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IdTipoCuentaGrupoPercepciones=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoCuentaGrupoPercepciones'),0)

IF Len(@NumeroAgentePercepcionIIBB)<=5
	SET @NumeroAgentePercepcionIIBB2=Substring('00000',1,5-len(Convert(varchar,@NumeroAgentePercepcionIIBB)))+Convert(varchar,@NumeroAgentePercepcionIIBB)
ELSE
	SET @NumeroAgentePercepcionIIBB2=SUBSTRING(Convert(varchar,@NumeroAgentePercepcionIIBB),len(Convert(varchar,@NumeroAgentePercepcionIIBB))-4,5)
	
CREATE TABLE #Auxiliar0 
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
			 ImporteIIBB NUMERIC(18,2),
			 Importacion_Despacho VARCHAR(20),
			 CBU VARCHAR(22),
			 Registro VARCHAR(80),
			 IdMoneda INTEGER,
			 ImporteBase NUMERIC(18,2),
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT  
  cp.IdComprobanteProveedor,
  (Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1)),
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
  dcp.Importe * cp.CotizacionMoneda, --* TiposComprobante.Coeficiente,
  Substring(Rtrim(IsNull(dcp.Importacion_Despacho,IsNull(cp.Importacion_Despacho,'0'))),1,20),
  Null,
  '',
  cp.IdMoneda,
  0, --(cp.TotalBruto - dcp.Importe) * cp.CotizacionMoneda, -- * TiposComprobante.Coeficiente
/*
  Case When IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoIVA and IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoPercepciones
		Then Round(dcp.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente,3) 
		Else 0
  End
*/
  cp.IdObra
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=cp.IdIBCondicion
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta=Cuentas.IdCuenta
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')<>'NO' and 
		Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1)) and 
		Proveedores.Cuit<>@CuitAduana

UPDATE #Auxiliar0
SET ImporteBase=IsNull((Select Sum(IsNull(dcp2.Importe * cp.CotizacionMoneda,0))
						From DetalleComprobantesProveedores dcp2
						Left Outer Join ComprobantesProveedores cp On dcp2.IdComprobanteProveedor=cp.IdComprobanteProveedor
						Left Outer Join Cuentas On Cuentas.IdCuenta=dcp2.IdCuenta
						Where dcp2.IdComprobanteProveedor=#Auxiliar0.IdComprobanteProveedor and 
								Not Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp2.IdCuenta,-1)) and 
								IsNull(Cuentas.IdTipoCuentaGrupo,0)<>@IdTipoCuentaGrupoIVA),0) 

CREATE TABLE #Auxiliar2 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProvincia INTEGER,
			 Tipo VARCHAR(10),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 ImporteIIBB NUMERIC(18,2),
			 Importacion_Despacho VARCHAR(20),
			 ImporteBase NUMERIC(18,2),
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT  
  cp.IdComprobanteProveedor,
  (Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1)),
  'ADUANA',
  Proveedores.Cuit,
  cp.FechaRecepcion,
  dcp.Importe * cp.CotizacionMoneda, -- * TiposComprobante.Coeficiente,
  Substring(Rtrim(IsNull(cp.Importacion_Despacho,'0')),1,20),
  0, --(cp.TotalBruto - dcp.Importe) * cp.CotizacionMoneda, -- * TiposComprobante.Coeficiente
  cp.IdObra
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')<>'NO' and 
		Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1)) and 
		Proveedores.Cuit=@CuitAduana

UPDATE #Auxiliar2
SET ImporteBase=IsNull((Select Sum(IsNull(dcp2.Importe * cp.CotizacionMoneda,0))
						From DetalleComprobantesProveedores dcp2
						Left Outer Join ComprobantesProveedores cp On dcp2.IdComprobanteProveedor=cp.IdComprobanteProveedor
						Left Outer Join Cuentas On Cuentas.IdCuenta=dcp2.IdCuenta
						Where dcp2.IdComprobanteProveedor=#Auxiliar2.IdComprobanteProveedor and 
								Not Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp2.IdCuenta,-1)) and 
								IsNull(Cuentas.IdTipoCuentaGrupo,0)<>@IdTipoCuentaGrupoIVA),0) 

INSERT INTO #Auxiliar0 
 SELECT 
  0,
  (Select Top 1 Pv.IdProvincia From Provincias Pv 
	Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(Valores.IdCuentaContable,-1) or 
			IsNull(Pv.IdCuentaRetencionIBrutosCobranzas,0)=IsNull(Valores.IdCuentaContable,-1)),
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
  Valores.Importe,
  '',
  IsNull(CuentasBancarias.CBU,'0000000000000000000000'),
  '',
  Valores.IdMoneda,
  0,
  Valores.IdObra
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 WHERE Valores.Estado='G' and IsNull(Valores.Anulado,'NO')<>'SI' and 
		(Valores.FechaComprobante between @FechaDesde and @FechaHasta) and
		Exists(Select Top 1 Pv.IdProvincia From Provincias Pv 
				Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(Valores.IdCuentaContable,-1) or 
						IsNull(Pv.IdCuentaRetencionIBrutosCobranzas,0)=IsNull(Valores.IdCuentaContable,-1))

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
			 ImporteIIBB NUMERIC(18,2),
			 Importacion_Despacho VARCHAR(20),
			 CBU VARCHAR(22),
			 Registro VARCHAR(80),
			 IdMoneda INTEGER,
			 ImporteBase NUMERIC(18,2),
			 IdObra INTEGER
			)

INSERT INTO #Auxiliar1 
 SELECT IdComprobanteProveedor, IdProvincia, Tipo, Jurisdiccion, Provincia, Proveedor, Cuit, Fecha, FechaComprobante, NumeroComprobante1, NumeroComprobante2, 
		TipoComprobante, Letra, Sum(IsNull(ImporteIIBB,0)), Importacion_Despacho, CBU, IdMoneda, '', Max(IsNull(ImporteBase,0)), IdObra
 FROM #Auxiliar0
 GROUP BY IdComprobanteProveedor, IdProvincia, Tipo, Jurisdiccion, Provincia, Proveedor, Cuit, Fecha, FechaComprobante, NumeroComprobante1, NumeroComprobante2, 
			TipoComprobante, Letra, Importacion_Despacho, CBU, IdMoneda, IdObra

INSERT INTO #Auxiliar1 
 SELECT 0, IdProvincia, Tipo, Null, Null, Null, Cuit, Fecha, Fecha, Null, Null, Null, Null, 
		Sum(IsNull(ImporteIIBB,0)), Importacion_Despacho, Null, Null, '', Max(IsNull(ImporteBase,0)), IdObra
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdProvincia, #Auxiliar2.Tipo, #Auxiliar2.Cuit, #Auxiliar2.Fecha, #Auxiliar2.Importacion_Despacho, IdObra

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
			 ImporteIIBB NUMERIC(18,2),
			 Importacion_Despacho VARCHAR(20),
			 CBU VARCHAR(22),
			 Registro VARCHAR(80),
			 IdMoneda INTEGER,
			 ImporteBase NUMERIC(18,2),
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar3 
 SELECT IdComprobanteProveedor, IdProvincia, Tipo, Jurisdiccion, Provincia, Proveedor, Cuit, Fecha, FechaComprobante, NumeroComprobante1, NumeroComprobante2, 
		TipoComprobante, Letra, Sum(IsNull(ImporteIIBB,0)), Importacion_Despacho, CBU, IdMoneda, Registro, Sum(IsNull(ImporteBase,0)), IdObra
 FROM #Auxiliar1
 GROUP BY IdComprobanteProveedor, IdProvincia, Tipo, Jurisdiccion, Provincia, Proveedor, Cuit, Fecha, FechaComprobante, NumeroComprobante1, NumeroComprobante2, 
			TipoComprobante, Letra, Importacion_Despacho, CBU, IdMoneda, Registro, IdObra

IF @Formato='e-sicol'
	UPDATE #Auxiliar3
	SET Registro = Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1) + 
		Substring('00000000',1,8-len(Convert(varchar,NumeroComprobante2)))+Convert(varchar,NumeroComprobante2) + 
		Convert(varchar,Year(FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(FechaComprobante))))+Convert(varchar,Month(FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Day(FechaComprobante))))+Convert(varchar,Day(FechaComprobante)) +
		Substring('0000',1,4-len(Convert(varchar,NumeroComprobante1)))+Convert(varchar,NumeroComprobante1) + 
		Case When TipoComprobante='C' Then '-' Else '0' End+Substring('000000000000000',1,15-len(Convert(varchar,ImporteBase)))+Convert(varchar,ImporteBase) + 
		Case When TipoComprobante='C' Then '-' Else '0' End+Substring('000000000000000',1,15-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB) + 
		--Case When TipoComprobante='C' Then 'D' When TipoComprobante='D' Then 'R' Else TipoComprobante End + 
		Case When TipoComprobante='C' Then 'F' When TipoComprobante='D' Then 'R' Else TipoComprobante End + 
		Letra 
	WHERE Tipo='PERCEPCION'
ELSE
	UPDATE #Auxiliar3
	SET Registro = Cuit + 
		@NumeroAgentePercepcionIIBB2 + --Substring('00000',1,5-len(Convert(varchar,@NumeroAgentePercepcionIIBB)))+Convert(varchar,@NumeroAgentePercepcionIIBB) + 
		Convert(varchar,@DigitoVerificadorNumeroAgentePercepcionIIBB) + 
		Convert(varchar,FechaComprobante,103) + 
		TipoComprobante + Letra + 
		Substring('0000',1,4-len(Convert(varchar,NumeroComprobante1)))+Convert(varchar,NumeroComprobante1) + 
		Substring('00000000',1,8-len(Convert(varchar,NumeroComprobante2)))+Convert(varchar,NumeroComprobante2) + 
		Substring('0000000000000000',1,16-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB) +
		Substring('0000000000000000',1,16-len(Convert(varchar,ImporteBase)))+Convert(varchar,ImporteBase)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000011111111111116116133'
SET @vector_T='000019923354421334334300'

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
	Null as [Imp. base],
	Null as [Obra],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
WHERE ImporteIIBB<>0
GROUP BY Tipo, IdProvincia, Provincia, Jurisdiccion

UNION ALL 

SELECT 
	#Auxiliar3.Tipo as [K_Tipo],
	#Auxiliar3.IdProvincia as [K_IdProvincia],
	#Auxiliar3.Provincia as [K_Provincia],
	2 as [K_Orden],
	Null as [Tipo],
	#Auxiliar3.Tipo as [Aux0],
	#Auxiliar3.Provincia as [Aux1],
	Null as [Provincia],
	Null as [Jurisdiccion],	Proveedor as [Proveedor],
	#Auxiliar3.Cuit as [Cuit],
	#Auxiliar3.Fecha as [Fecha],
	#Auxiliar3.FechaComprobante as [Fecha Comp.],
	#Auxiliar3.NumeroComprobante1 as [Sucursal],
	#Auxiliar3.NumeroComprobante2 as [Comprobante],
	#Auxiliar3.TipoComprobante as [Tipo Comp.],
	#Auxiliar3.Letra as [Letra Comp.],
	#Auxiliar3.ImporteIIBB as [Imp. percibido],
	#Auxiliar3.Registro as [Registro],
	#Auxiliar3.Importacion_Despacho as [Nro.Despacho],
	#Auxiliar3.ImporteBase as [Imp. base],
	Obras.Descripcion as [Obra],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar3.IdObra
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
	SUM(Case When TipoComprobante='C' Then ImporteIIBB*-1 Else ImporteIIBB End) as [Imp. percibido],
	Null as [Registro],
	Null as [Nro.Despacho],
	SUM(Case When TipoComprobante='C' Then ImporteBase*-1 Else ImporteBase End) as [Imp. base],
	Null as [Obra],
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
	Null as [Imp. base],
	Null as [Obra],
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
	SUM(Case When TipoComprobante='C' Then ImporteIIBB*-1 Else ImporteIIBB End) as [Imp. percibido],
	Null as [Registro],
	Null as [Nro.Despacho],
	SUM(Case When TipoComprobante='C' Then ImporteBase*-1 Else ImporteBase End) as [Imp. base],
	Null as [Obra],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar3
WHERE ImporteIIBB<>0

ORDER BY [K_Tipo], [K_Provincia], [K_IdProvincia], [K_Orden], [Fecha]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3