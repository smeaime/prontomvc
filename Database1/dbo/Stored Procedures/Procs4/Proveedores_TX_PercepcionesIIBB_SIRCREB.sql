CREATE PROCEDURE [dbo].[Proveedores_TX_PercepcionesIIBB_SIRCREB]

@FechaDesde datetime,
@FechaHasta datetime,
@Formato varchar(10) = Null

AS

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')

CREATE TABLE #Auxiliar1 
			(
			 IdProvincia INTEGER,
			 Provincia VARCHAR(50),
			 Jurisdiccion VARCHAR(3),
			 Cuit VARCHAR(13),
			 CBU VARCHAR(22),
			 TipoCuenta VARCHAR(2),
			 Mes INTEGER,
			 Año INTEGER,
			 TipoMoneda VARCHAR(1),
			 ImporteIIBB NUMERIC(18,0)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  IsNull(dvp.IdProvincia,0),
  Null,
  Null,
  Case When Bancos.Cuit is not null and len(Bancos.Cuit)=13 Then Bancos.Cuit Else '00-00000000-0' End,
  IsNull(CuentasBancarias.CBU,'0000000000000000000000'),
  Substring(IsNull(CuentasBancarias.InformacionAuxiliar,'  '),1,2),
  Month(Valores.FechaComprobante),
  Year(Valores.FechaComprobante),
  Case When Valores.IdMoneda=1 Then 'P' Else 'E' End,
  IsNull(Valores.Importe,0) * Isnull(dvp.Porcentaje/100,1) * 100
 FROM Valores 
 LEFT OUTER JOIN DetalleValoresProvincias dvp ON Valores.IdValor=dvp.IdValor
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 WHERE Valores.Estado='G' and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.FechaComprobante between @FechaDesde and @FechaHasta) and
	Exists(Select Top 1 Pv.IdProvincia From Provincias Pv 
		Where IsNull(Pv.IdCuentaPercepcionIIBBCompras,0)=IsNull(Valores.IdCuentaContable,-1) or 
			IsNull(Pv.IdCuentaRetencionIBrutosCobranzas,0)=IsNull(Valores.IdCuentaContable,-1) or 
			IsNull(Pv.IdCuentaSIRCREB,0)=IsNull(Valores.IdCuentaContable,-1))

UPDATE #Auxiliar1
SET Jurisdiccion=SubString(IsNull((Select Top 1 InformacionAuxiliar From Provincias Where #Auxiliar1.IdProvincia=Provincias.IdProvincia),'000'),1,3)

UPDATE #Auxiliar1
SET Provincia=IsNull((Select Top 1 Nombre From Provincias Where #Auxiliar1.IdProvincia=Provincias.IdProvincia),'SD')

CREATE TABLE #Auxiliar2 
			(
			 IdProvincia INTEGER,
			 Provincia VARCHAR(50),
			 Jurisdiccion VARCHAR(3),
			 Cuit VARCHAR(13),
			 CBU VARCHAR(22),
			 TipoCuenta VARCHAR(2),
			 Mes INTEGER,
			 Año INTEGER,
			 TipoMoneda VARCHAR(1),
			 ImporteIIBB NUMERIC(18,0),
			 Registro VARCHAR(80)
			)
INSERT INTO #Auxiliar2 
 SELECT IdProvincia, Provincia, Jurisdiccion, Cuit, CBU, TipoCuenta, Mes, Año, TipoMoneda, Sum(IsNull(ImporteIIBB,0)), ''
 FROM #Auxiliar1
 GROUP BY IdProvincia, Provincia, Jurisdiccion, Cuit, CBU, TipoCuenta, Mes, Año, TipoMoneda

IF @Formato='e-sicol'
	UPDATE #Auxiliar2
	SET Registro = Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1) + 
		Substring('0000',1,4-len(Convert(varchar,Año)))+Convert(varchar,Año)+Substring('00',1,2-len(Convert(varchar,Mes)))+Convert(varchar,Mes)+'01' +
		Substring(Substring('0000000000000',1,13-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),1,13)+'.00'+
--			Substring(Substring('000000000000000',1,15-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),14,2) + 
		Substring(TipoCuenta+'      ',1,6) + 
		CBU
ELSE
	UPDATE #Auxiliar2
	SET Registro = Jurisdiccion + Cuit + 
		Substring('0000',1,4-len(Convert(varchar,Año)))+Convert(varchar,Año) + '/' + Substring('00',1,2-len(Convert(varchar,Mes)))+Convert(varchar,Mes) +
		Substring('0000000000000000000000',1,22-len(CBU)) + CBU + 
		TipoCuenta + 
		TipoMoneda + 
		Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),1,7)+','+
			Substring(Substring('000000000',1,9-len(Convert(varchar,ImporteIIBB)))+Convert(varchar,ImporteIIBB),8,2)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0001111111116133'
SET @vector_T='000G935633223300'

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	1 as [K_Orden],
	Provincia as [Provincia],
	Provincia as [Aux1],
	Jurisdiccion as [Jurisdiccion],
	Null as [Cuit],
	Null as [CBU],
	Null as [Tipo Cuenta],
	Null as [Tipo Moneda],
	Null as [Mes],
	Null as [Año],
	Null as [Imp. percibido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar2
WHERE ImporteIIBB<>0
GROUP BY IdProvincia, Provincia, Jurisdiccion

UNION ALL 

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	2 as [K_Orden],
	Null as [Provincia],
	Provincia as [Aux1],
	Null as [Jurisdiccion],	Cuit as [Cuit],
	CBU as [CBU],
	TipoCuenta as [Tipo Cuenta],
	TipoMoneda as [Tipo Moneda],
	Mes as [Mes],
	Año as [Año],
	ImporteIIBB/100 as [Imp. percibido],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar2
WHERE ImporteIIBB<>0

UNION ALL 

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	3 as [K_Orden],
	Null as [Provincia],
	Provincia as [Aux1],
	Null as [Jurisdiccion],
	'TOTAL PROVINCIA' as [Cuit],
	Null as [CBU],
	Null as [Tipo Cuenta],
	Null as [Tipo Moneda],
	Null as [Mes],
	Null as [Año],
	SUM(ImporteIIBB/100) as [Imp. percibido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar2
WHERE ImporteIIBB<>0
GROUP BY IdProvincia, Provincia

UNION ALL 

SELECT 
	IdProvincia as [K_IdProvincia],
	Provincia as [K_Provincia],
	4 as [K_Orden],
	Null as [Provincia],
	Provincia as [Aux1],
	Null as [Jurisdiccion],
	Null as [Cuit],
	Null as [CBU],
	Null as [Tipo Cuenta],
	Null as [Tipo Moneda],
	Null as [Mes],
	Null as [Año],
	Null as [Imp. percibido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar2
WHERE ImporteIIBB<>0
GROUP BY IdProvincia, Provincia

UNION ALL 

SELECT 
	0 as [K_IdProvincia],
	'zzzz' as [K_Provincia],
	5 as [K_Orden],
	Null as [Provincia],
	Null as [Aux1],
	Null as [Jurisdiccion],
	'TOTAL GENERAL' as [Cuit],
	Null as [CBU],
	Null as [Tipo Cuenta],
	Null as [Tipo Moneda],
	Null as [Mes],
	Null as [Año],
	SUM(ImporteIIBB/100) as [Imp. percibido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar2
WHERE ImporteIIBB<>0

ORDER BY [K_Provincia], [K_IdProvincia], [K_Orden], [Año], [Mes]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2