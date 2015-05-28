CREATE Procedure [dbo].[CuboPresupuestoFinanciero3]

@Fecha datetime,
@Dts varchar(200)

AS 

SET NOCOUNT ON

DECLARE @FechaDesde datetime, @FechaHasta datetime, @Mes1 int, @Mes2 int, @Mes3 int

SET @FechaDesde=Convert(datetime,'1/'+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha)))
SET @FechaHasta=Dateadd(d,-1,Dateadd(m,3,@FechaDesde))
SET @Mes1=Month(@FechaDesde)
SET @Mes2=Month(Dateadd(m,1,@FechaDesde))
SET @Mes3=Month(Dateadd(m,2,@FechaDesde))

CREATE TABLE #Auxiliar10
			(
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(20),
			 Jerarquia1 VARCHAR(1),
			 Jerarquia2 VARCHAR(3),
			 Jerarquia3 VARCHAR(6),
			 Jerarquia4 VARCHAR(9)
			)

INSERT INTO #Auxiliar10
 SELECT  
  C.Descripcion,
  C.Jerarquia,
  Substring(C.Jerarquia,1,1),
  Substring(C.Jerarquia,1,3),
  Substring(C.Jerarquia,1,6),
  Substring(C.Jerarquia,1,9)
 FROM Cuentas C 


CREATE TABLE #Auxiliar11
			(
			 Descripcion VARCHAR(50),
			 Jerarquia1 VARCHAR(1)
			)
INSERT INTO #Auxiliar11
 SELECT  
  Null,
  #Auxiliar10.Jerarquia1
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia1

UPDATE #Auxiliar11
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia1=Substring(#Auxiliar11.Jerarquia1,1,1)
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar12
			(
			 Descripcion VARCHAR(50),
			 Jerarquia2 VARCHAR(3)
			)
INSERT INTO #Auxiliar12
 SELECT  
  Null,
  #Auxiliar10.Jerarquia2
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia2

UPDATE #Auxiliar12
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia2=Substring(#Auxiliar12.Jerarquia2,1,3)
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar13
			(
			 Descripcion VARCHAR(50),
			 Jerarquia3 VARCHAR(6)
			)
INSERT INTO #Auxiliar13
 SELECT  
  Null,
  #Auxiliar10.Jerarquia3
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia3

UPDATE #Auxiliar13
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia3=Substring(#Auxiliar13.Jerarquia3,1,6)
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar14
			(
			 Descripcion VARCHAR(50),
			 Jerarquia4 VARCHAR(9)
			)
INSERT INTO #Auxiliar14
 SELECT  
  Null,
  #Auxiliar10.Jerarquia4
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia4

UPDATE #Auxiliar14
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia4=Substring(#Auxiliar14.Jerarquia4,1,9)
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar0
			(
			 IdCuenta INTEGER,
			 IdTipoCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(60),
			 DescripcionJerarquia1 VARCHAR(60),
			 DescripcionJerarquia2 VARCHAR(60),
			 DescripcionJerarquia3 VARCHAR(60),
			 DescripcionJerarquia4 VARCHAR(60)
			)

INSERT INTO #Auxiliar0 
 SELECT 
  C.IdCuenta,
  C.IdTipoCuenta,
  C.Codigo,
  C.Descripcion,
  C.Jerarquia,
  Substring(C.Jerarquia,1,1)+' - '+#Auxiliar11.Descripcion COLLATE Modern_Spanish_CI_AS,
  Substring(C.Jerarquia,3,1)+' - '+#Auxiliar12.Descripcion COLLATE Modern_Spanish_CI_AS,
  Substring(C.Jerarquia,5,2)+' - '+#Auxiliar13.Descripcion COLLATE Modern_Spanish_CI_AS,
  Substring(C.Jerarquia,8,2)+' - '+#Auxiliar14.Descripcion COLLATE Modern_Spanish_CI_AS
/*
  Case When Substring(C.Jerarquia,1,1)<='5'  	Then Substring(C.Jerarquia,8,2)+' - '+#Auxiliar14.Descripcion
  	Else Substring(C.Jerarquia,8,2)+' - '+#Auxiliar13.Descripcion
  End
*/
 FROM Cuentas C 
 LEFT OUTER JOIN #Auxiliar11 ON #Auxiliar11.Jerarquia1 COLLATE Modern_Spanish_CI_AS=Substring(C.Jerarquia,1,1)
 LEFT OUTER JOIN #Auxiliar12 ON #Auxiliar12.Jerarquia2 COLLATE Modern_Spanish_CI_AS=Substring(C.Jerarquia,1,3)
 LEFT OUTER JOIN #Auxiliar13 ON #Auxiliar13.Jerarquia3 COLLATE Modern_Spanish_CI_AS=Substring(C.Jerarquia,1,6)
 LEFT OUTER JOIN #Auxiliar14 ON #Auxiliar14.Jerarquia4 COLLATE Modern_Spanish_CI_AS=Substring(C.Jerarquia,1,9)


CREATE TABLE #Auxiliar4 
			(
			 A_IdCuenta INTEGER,
			 A_IdTipoCuenta INTEGER,
			 A_Clave INTEGER,
			 A_Jerarquia1 VARCHAR(60),
			 A_Jerarquia2 VARCHAR(60),
			 A_Jerarquia3 VARCHAR(60),
			 A_Jerarquia4 VARCHAR(60),
			 A_Codigo INTEGER,
			 A_Descripcion  VARCHAR(60),
			 A_Detalle  VARCHAR(100),
			 A_PresupuestoTeoricoMes01 NUMERIC(18, 2),
			 A_SaldoMes01 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes02 NUMERIC(18, 2),
			 A_SaldoMes02 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes03 NUMERIC(18, 2),
			 A_SaldoMes03 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  IsNull(#Auxiliar0.IdCuenta,0),
  IsNull(Cuentas.IdTipoCuenta,2),
  1,
  IsNull(#Auxiliar0.DescripcionJerarquia1,''),
  IsNull(#Auxiliar0.DescripcionJerarquia2,''),
  IsNull(#Auxiliar0.DescripcionJerarquia3,''),
  IsNull(#Auxiliar0.DescripcionJerarquia4,''),
  IsNull(#Auxiliar0.Codigo,0),
  IsNull(#Auxiliar0.Descripcion,''),
  '',
  Case When PF.Mes=@Mes1 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=@Mes2 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=@Mes3 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0
 FROM PresupuestoFinanciero PF 
 LEFT OUTER JOIN RubrosContables ON PF.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE IsNull(PF.Tipo,'M')='A' and 
	Convert(datetime,'1/'+Convert(varchar,PF.Mes)+'/'+Convert(varchar,PF.Año))>=@FechaDesde and 
	Convert(datetime,'1/'+Convert(varchar,PF.Mes)+'/'+Convert(varchar,PF.Año))<=@FechaHasta

 UNION ALL 

 SELECT 
  IsNull(#Auxiliar0.IdCuenta,0),
  IsNull(Cuentas.IdTipoCuenta,2),
  1,
  IsNull(#Auxiliar0.DescripcionJerarquia1,''),
  IsNull(#Auxiliar0.DescripcionJerarquia2,''),
  IsNull(#Auxiliar0.DescripcionJerarquia3,''),
  IsNull(#Auxiliar0.DescripcionJerarquia4,''),
  IsNull(#Auxiliar0.Codigo,0),
  IsNull(#Auxiliar0.Descripcion,''),
  Convert(varchar,Year(Recibos.FechaRecibo))+' '+
	Substring('00',1,2-Len(Convert(varchar,Month(Recibos.FechaRecibo))))+Convert(varchar,Month(Recibos.FechaRecibo))+' '+
	Substring('00',1,2-Len(Convert(varchar,Day(Recibos.FechaRecibo))))+Convert(varchar,Day(Recibos.FechaRecibo))+' '+
	'RE '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)+' - '+
	Case 	When Recibos.IdCliente is not null Then 'Cliente : '+IsNull(Clientes.RazonSocial,'')
		When Recibos.IdCuenta is not null Then 'Cuenta : '+IsNull((Select Top 1 Cta.Descripcion From Cuentas Cta Where Cta.IdCuenta=Recibos.IdCuenta),'')
		Else ''
	End,
  0,
  Case When Month(Recibos.FechaRecibo)=@Mes1 
	Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(Recibos.FechaRecibo)=@Mes2
	Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(Recibos.FechaRecibo)=@Mes3 
	Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1
 FROM DetalleRecibosRubrosContables DetRRC
 LEFT OUTER JOIN Recibos ON DetRRC.IdRecibo=Recibos.IdRecibo
 LEFT OUTER JOIN Clientes ON Recibos.IdCliente=Clientes.IdCliente
 LEFT OUTER JOIN RubrosContables ON DetRRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @FechaDesde and @FechaHasta and IsNull(Recibos.Anulado,'NO')<>'SI'

 UNION ALL 

 SELECT 
  IsNull(#Auxiliar0.IdCuenta,0),
  IsNull(Cuentas.IdTipoCuenta,2),
  1,
  IsNull(#Auxiliar0.DescripcionJerarquia1,''),
  IsNull(#Auxiliar0.DescripcionJerarquia2,''),
  IsNull(#Auxiliar0.DescripcionJerarquia3,''),
  IsNull(#Auxiliar0.DescripcionJerarquia4,''),
  IsNull(#Auxiliar0.Codigo,0),
  IsNull(#Auxiliar0.Descripcion,''),
  Convert(varchar,Year(OrdenesPago.FechaOrdenPago))+' '+
	Substring('00',1,2-Len(Convert(varchar,Month(OrdenesPago.FechaOrdenPago))))+Convert(varchar,Month(OrdenesPago.FechaOrdenPago))+' '+
	Substring('00',1,2-Len(Convert(varchar,Day(OrdenesPago.FechaOrdenPago))))+Convert(varchar,Day(OrdenesPago.FechaOrdenPago))+' '+
	'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)+' - '+
	Case 	When OrdenesPago.IdProveedor is not null Then 'Proveedor : '+IsNull(Proveedores.RazonSocial,'')
		When OrdenesPago.IdCuenta is not null Then 'Cuenta : '+IsNull((Select Top 1 Cta.Descripcion From Cuentas Cta Where Cta.IdCuenta=OrdenesPago.IdCuenta),'')
		Else ''
	End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=@Mes1 
	Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=@Mes2 
	Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=@Mes3 
	Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1
 FROM DetalleOrdenesPagoRubrosContables DetOPRC 
 LEFT OUTER JOIN OrdenesPago ON DetOPRC.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON OrdenesPago.IdProveedor=Proveedores.IdProveedor
 LEFT OUTER JOIN RubrosContables ON DetOPRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE OrdenesPago.FechaOrdenPago between @FechaDesde and @FechaHasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI'

 UNION ALL 

 SELECT 
  IsNull(#Auxiliar0.IdCuenta,0),
  IsNull(Cuentas.IdTipoCuenta,2),
  1,
  IsNull(#Auxiliar0.DescripcionJerarquia1,''),
  IsNull(#Auxiliar0.DescripcionJerarquia2,''),
  IsNull(#Auxiliar0.DescripcionJerarquia3,''),
  IsNull(#Auxiliar0.DescripcionJerarquia4,''),
  IsNull(#Auxiliar0.Codigo,0),
  IsNull(#Auxiliar0.Descripcion,''),
  Convert(varchar,Year(Valores.FechaComprobante))+' '+
	Substring('00',1,2-Len(Convert(varchar,Month(Valores.FechaComprobante))))+Convert(varchar,Month(Valores.FechaComprobante))+' '+
	Substring('00',1,2-Len(Convert(varchar,Day(Valores.FechaComprobante))))+Convert(varchar,Day(Valores.FechaComprobante))+' '+
	TiposComprobante.DescripcionAb+' '+Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+Convert(varchar,Valores.NumeroComprobante),
  0,
  Case When Month(Valores.FechaComprobante)=@Mes1 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * IsNull(TiposComprobante.Coeficiente,1) * 
		Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(Valores.FechaComprobante)=@Mes2 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * IsNull(TiposComprobante.Coeficiente,1) * 
		Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(Valores.FechaComprobante)=@Mes3 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * IsNull(TiposComprobante.Coeficiente,1) * 
		Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1
 FROM DetalleValoresRubrosContables DetVRC 
 LEFT OUTER JOIN Valores ON DetVRC.IdValor=Valores.IdValor
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN RubrosContables ON DetVRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE Valores.FechaComprobante between @FechaDesde and @FechaHasta

 UNION ALL 

 SELECT 
  IsNull(#Auxiliar0.IdCuenta,0),
  IsNull(Cuentas.IdTipoCuenta,2),
  1,
  IsNull(#Auxiliar0.DescripcionJerarquia1,''),
  IsNull(#Auxiliar0.DescripcionJerarquia2,''),
  IsNull(#Auxiliar0.DescripcionJerarquia3,''),
  IsNull(#Auxiliar0.DescripcionJerarquia4,''),
  IsNull(#Auxiliar0.Codigo,0),
  IsNull(#Auxiliar0.Descripcion,''),
  Convert(varchar,Year(PlazosFijos.FechaInicioPlazoFijo))+' '+
	Substring('00',1,2-Len(Convert(varchar,Month(PlazosFijos.FechaInicioPlazoFijo))))+Convert(varchar,Month(PlazosFijos.FechaInicioPlazoFijo))+' '+
	Substring('00',1,2-Len(Convert(varchar,Day(PlazosFijos.FechaInicioPlazoFijo))))+Convert(varchar,Day(PlazosFijos.FechaInicioPlazoFijo))+' '+
	'PF '+Substring('0000000000',1,10-Len(Convert(varchar,PlazosFijos.NumeroCertificado1)))+Convert(varchar,PlazosFijos.NumeroCertificado1),
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=@Mes1 
	Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=@Mes2 
	Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=@Mes3 
	Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE PlazosFijos.FechaInicioPlazoFijo between @FechaDesde and @FechaHasta and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='E'

 UNION ALL 

 SELECT 
  IsNull(#Auxiliar0.IdCuenta,0),
  IsNull(Cuentas.IdTipoCuenta,2),
  1,
  IsNull(#Auxiliar0.DescripcionJerarquia1,''),
  IsNull(#Auxiliar0.DescripcionJerarquia2,''),
  IsNull(#Auxiliar0.DescripcionJerarquia3,''),
  IsNull(#Auxiliar0.DescripcionJerarquia4,''),
  IsNull(#Auxiliar0.Codigo,0),
  IsNull(#Auxiliar0.Descripcion,''),
  Convert(varchar,Year(PlazosFijos.FechaVencimiento))+' '+
	Substring('00',1,2-Len(Convert(varchar,Month(PlazosFijos.FechaVencimiento))))+Convert(varchar,Month(PlazosFijos.FechaVencimiento))+' '+
	Substring('00',1,2-Len(Convert(varchar,Day(PlazosFijos.FechaVencimiento))))+Convert(varchar,Day(PlazosFijos.FechaVencimiento))+' '+
	'PF '+Substring('0000000000',1,10-Len(Convert(varchar,PlazosFijos.NumeroCertificado1)))+Convert(varchar,PlazosFijos.NumeroCertificado1),
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=@Mes1 
	Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=@Mes2
	Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=@Mes3 
	Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE PlazosFijos.FechaVencimiento between @FechaDesde and @FechaHasta and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='I'


TRUNCATE TABLE _TempCuboPresupuestoFinanciero2
INSERT INTO _TempCuboPresupuestoFinanciero2 
SELECT 
 #Auxiliar4.A_Jerarquia1,
 #Auxiliar4.A_Jerarquia2,
 #Auxiliar4.A_Jerarquia3,
 #Auxiliar4.A_Jerarquia4, 
 Convert(varchar,#Auxiliar4.A_Codigo)+' '+#Auxiliar4.A_Descripcion,
 #Auxiliar4.A_Detalle, 
 #Auxiliar4.A_PresupuestoTeoricoMes01,
 #Auxiliar4.A_SaldoMes01,
 #Auxiliar4.A_PresupuestoTeoricoMes02,
 #Auxiliar4.A_SaldoMes02,
 #Auxiliar4.A_PresupuestoTeoricoMes03,
 #Auxiliar4.A_SaldoMes03,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null,
 Null
FROM #Auxiliar4
WHERE 	(IsNull(#Auxiliar4.A_SaldoMes01,0)<>0 or IsNull(#Auxiliar4.A_SaldoMes02,0)<>0 or IsNull(#Auxiliar4.A_SaldoMes03,0)<>0 or 
	 IsNull(#Auxiliar4.A_PresupuestoTeoricoMes01,0)<>0 or IsNull(#Auxiliar4.A_PresupuestoTeoricoMes02,0)<>0 or 
	 IsNull(#Auxiliar4.A_PresupuestoTeoricoMes03,0)<>0) and 
	(#Auxiliar4.A_IdTipoCuenta=2 or #Auxiliar4.A_IdTipoCuenta=4)

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13
DROP TABLE #Auxiliar14