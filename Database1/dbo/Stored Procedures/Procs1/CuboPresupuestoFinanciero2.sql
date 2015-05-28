CREATE Procedure [dbo].[CuboPresupuestoFinanciero2]

@IdEjercicioContable int,
@Dts varchar(200),
@FechaIni datetime = Null,
@FechaFin datetime = Null

AS 

SET NOCOUNT ON

DECLARE @FechaDesde datetime,@FechaHasta datetime

IF @IdEjercicioContable>0 
    BEGIN
	SET @FechaDesde=(Select Top 1 FechaInicio From EjerciciosContables Where IdEjercicioContable=@IdEjercicioContable)
	SET @FechaHasta=(Select Top 1 FechaFinalizacion From EjerciciosContables Where IdEjercicioContable=@IdEjercicioContable)
    END
ELSE
    BEGIN
	SET @FechaDesde=IsNull(@FechaIni,0)
	SET @FechaHasta=IsNull(@FechaFin,0)
    END

CREATE TABLE #Auxiliar10
			(
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(20),
			 Jerarquia1 VARCHAR(1),
			 Jerarquia2 VARCHAR(3),
			 Jerarquia3 VARCHAR(6),
			 Jerarquia4 VARCHAR(9)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (Jerarquia) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar10 (Jerarquia1) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar12 ON #Auxiliar10 (Jerarquia2) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar13 ON #Auxiliar10 (Jerarquia3) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar14 ON #Auxiliar10 (Jerarquia4) ON [PRIMARY]
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
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (Jerarquia1) ON [PRIMARY]
INSERT INTO #Auxiliar11
 SELECT  
  Null,
  #Auxiliar10.Jerarquia1
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia1

UPDATE #Auxiliar11
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia1=Substring(#Auxiliar11.Jerarquia1,1,1) and Len(IsNull(#Auxiliar10.Descripcion,''))>0
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar12
			(
			 Descripcion VARCHAR(50),
			 Jerarquia2 VARCHAR(3)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar12 ON #Auxiliar12 (Jerarquia2) ON [PRIMARY]
INSERT INTO #Auxiliar12
 SELECT  
  Null,
  #Auxiliar10.Jerarquia2
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia2

UPDATE #Auxiliar12
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia2=Substring(#Auxiliar12.Jerarquia2,1,3) and Len(IsNull(#Auxiliar10.Descripcion,''))>0
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar13
			(
			 Descripcion VARCHAR(50),
			 Jerarquia3 VARCHAR(6)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar13 ON #Auxiliar13 (Jerarquia3) ON [PRIMARY]
INSERT INTO #Auxiliar13
 SELECT  
  Null,
  #Auxiliar10.Jerarquia3
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia3

UPDATE #Auxiliar13
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia3=Substring(#Auxiliar13.Jerarquia3,1,6) and Len(IsNull(#Auxiliar10.Descripcion,''))>0
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar14
			(
			 Descripcion VARCHAR(50),
			 Jerarquia4 VARCHAR(9)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar14 ON #Auxiliar14 (Jerarquia4) ON [PRIMARY]
INSERT INTO #Auxiliar14
 SELECT  
  Null,
  #Auxiliar10.Jerarquia4
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia4

UPDATE #Auxiliar14
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia4=Substring(#Auxiliar14.Jerarquia4,1,9) and Len(IsNull(#Auxiliar10.Descripcion,''))>0
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
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdCuenta) ON [PRIMARY]
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
			 A_SaldoMes03 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes04 NUMERIC(18, 2),
			 A_SaldoMes04 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes05 NUMERIC(18, 2),
			 A_SaldoMes05 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes06 NUMERIC(18, 2),
			 A_SaldoMes06 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes07 NUMERIC(18, 2),
			 A_SaldoMes07 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes08 NUMERIC(18, 2),
			 A_SaldoMes08 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes09 NUMERIC(18, 2),
			 A_SaldoMes09 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes10 NUMERIC(18, 2),
			 A_SaldoMes10 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes11 NUMERIC(18, 2),
			 A_SaldoMes11 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes12 NUMERIC(18, 2),
			 A_SaldoMes12 NUMERIC(18, 2)
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
  Case When PF.Mes=1 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=2 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=3 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=4 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=5 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=6 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=7 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=8 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=9 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=10 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=11 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0,
  Case When PF.Mes=12 Then IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0) Else 0 End,
  0
 FROM PresupuestoFinanciero PF 
 LEFT OUTER JOIN RubrosContables ON PF.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE IsNull(PF.Tipo,'M')='A' and IsNull(RubrosContables.NoTomarEnCuboPresupuestoFinanciero,'')<>'SI' and 
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
  Case When Month(Recibos.FechaRecibo)=1 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=2 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=3 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=4 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=5 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=6 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=7 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=8 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=9 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=10 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=11 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(Recibos.FechaRecibo)=12 Then DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) Else 0 End -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
 FROM DetalleRecibosRubrosContables DetRRC
 LEFT OUTER JOIN Recibos ON DetRRC.IdRecibo=Recibos.IdRecibo
 LEFT OUTER JOIN Clientes ON Recibos.IdCliente=Clientes.IdCliente
 LEFT OUTER JOIN RubrosContables ON DetRRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @FechaDesde and @FechaHasta and IsNull(RubrosContables.NoTomarEnCuboPresupuestoFinanciero,'')<>'SI' and IsNull(Recibos.Anulado,'NO')<>'SI'

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
  Case When Month(OrdenesPago.FechaOrdenPago)=1 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=2 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=3 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=4 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=5 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=6 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=7 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=8 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=9 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=10 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=11 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1, -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(OrdenesPago.FechaOrdenPago)=12 Then DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1) Else 0 End * -1 -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
 FROM DetalleOrdenesPagoRubrosContables DetOPRC 
 LEFT OUTER JOIN OrdenesPago ON DetOPRC.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON OrdenesPago.IdProveedor=Proveedores.IdProveedor
 LEFT OUTER JOIN RubrosContables ON DetOPRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE OrdenesPago.FechaOrdenPago between @FechaDesde and @FechaHasta and IsNull(OrdenesPago.TipoOperacionOtros,-1)<>0 and IsNull(RubrosContables.NoTomarEnCuboPresupuestoFinanciero,'')<>'SI' and IsNull(OrdenesPago.Anulada,'NO')<>'SI'

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
  Case When Month(Valores.FechaComprobante)=1 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=2 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=3 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=4 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=5 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=6 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=7 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=8 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=9 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=10 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=11 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End,
  0,
  Case When Month(Valores.FechaComprobante)=12 
	Then DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End * Case When IsNull(TiposComprobante.Coeficiente,1)=1 
											Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
											Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
										End
 FROM DetalleValoresRubrosContables DetVRC 
 LEFT OUTER JOIN Valores ON DetVRC.IdValor=Valores.IdValor
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN RubrosContables ON DetVRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE Valores.FechaComprobante between @FechaDesde and @FechaHasta and IsNull(RubrosContables.NoTomarEnCuboPresupuestoFinanciero,'')<>'SI'

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
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=1 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=2 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=3 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=4 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=5 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=6 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=7 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=8 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=9 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=10 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=11 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End,
  0,
  Case When Month(PlazosFijos.FechaInicioPlazoFijo)=12 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE PlazosFijos.FechaInicioPlazoFijo between @FechaDesde and @FechaHasta and IsNull(RubrosContables.NoTomarEnCuboPresupuestoFinanciero,'')<>'SI' and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='E'

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
  Case When Month(PlazosFijos.FechaVencimiento)=1 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=2 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=3 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=4 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=5 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=6 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=7 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=8 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=9 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=10 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=11 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End,
  0,
  Case When Month(PlazosFijos.FechaVencimiento)=12 Then Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) Else 0 End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 LEFT OUTER JOIN #Auxiliar0 ON RubrosContables.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta = Cuentas.IdCuenta
 WHERE PlazosFijos.FechaVencimiento between @FechaDesde and @FechaHasta and IsNull(RubrosContables.NoTomarEnCuboPresupuestoFinanciero,'')<>'SI' and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='I'

TRUNCATE TABLE _TempCuboPresupuestoFinanciero2
INSERT INTO _TempCuboPresupuestoFinanciero2 
SELECT 
 #Auxiliar4.A_Jerarquia1,
 #Auxiliar4.A_Jerarquia2,
 #Auxiliar4.A_Jerarquia3,
 #Auxiliar4.A_Jerarquia4, 
 Substring('('+IsNull(Substring(Cuentas.Jerarquia COLLATE Modern_Spanish_CI_AS,11,3),'000')+') '+Convert(varchar,#Auxiliar4.A_Codigo)+' '+#Auxiliar4.A_Descripcion COLLATE Modern_Spanish_CI_AS,1,60),
 #Auxiliar4.A_Detalle, 
 #Auxiliar4.A_PresupuestoTeoricoMes01,
 #Auxiliar4.A_SaldoMes01,
 #Auxiliar4.A_PresupuestoTeoricoMes02,
 #Auxiliar4.A_SaldoMes02,
 #Auxiliar4.A_PresupuestoTeoricoMes03,
 #Auxiliar4.A_SaldoMes03,
 #Auxiliar4.A_PresupuestoTeoricoMes04,
 #Auxiliar4.A_SaldoMes04,
 #Auxiliar4.A_PresupuestoTeoricoMes05,
 #Auxiliar4.A_SaldoMes05,
 #Auxiliar4.A_PresupuestoTeoricoMes06,
 #Auxiliar4.A_SaldoMes06,
 #Auxiliar4.A_PresupuestoTeoricoMes07,
 #Auxiliar4.A_SaldoMes07,
 #Auxiliar4.A_PresupuestoTeoricoMes08,
 #Auxiliar4.A_SaldoMes08,
 #Auxiliar4.A_PresupuestoTeoricoMes09,
 #Auxiliar4.A_SaldoMes09,
 #Auxiliar4.A_PresupuestoTeoricoMes10,
 #Auxiliar4.A_SaldoMes10,
 #Auxiliar4.A_PresupuestoTeoricoMes11,
 #Auxiliar4.A_SaldoMes11,
 #Auxiliar4.A_PresupuestoTeoricoMes12,
 #Auxiliar4.A_SaldoMes12 
FROM #Auxiliar4
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar4.A_IdCuenta
WHERE (#Auxiliar4.A_SaldoMes01<>0 or #Auxiliar4.A_SaldoMes02<>0 or #Auxiliar4.A_SaldoMes03<>0 or #Auxiliar4.A_SaldoMes04<>0 or #Auxiliar4.A_SaldoMes05<>0 or #Auxiliar4.A_SaldoMes06<>0 or 
	#Auxiliar4.A_SaldoMes07<>0 or #Auxiliar4.A_SaldoMes08<>0 or #Auxiliar4.A_SaldoMes09<>0 or #Auxiliar4.A_SaldoMes10<>0 or #Auxiliar4.A_SaldoMes11<>0 or #Auxiliar4.A_SaldoMes12<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes01<>0 or #Auxiliar4.A_PresupuestoTeoricoMes02<>0 or #Auxiliar4.A_PresupuestoTeoricoMes03<>0 or #Auxiliar4.A_PresupuestoTeoricoMes04<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes05<>0 or #Auxiliar4.A_PresupuestoTeoricoMes06<>0 or #Auxiliar4.A_PresupuestoTeoricoMes07<>0 or #Auxiliar4.A_PresupuestoTeoricoMes08<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes09<>0 or #Auxiliar4.A_PresupuestoTeoricoMes10<>0 or #Auxiliar4.A_PresupuestoTeoricoMes11<>0 or #Auxiliar4.A_PresupuestoTeoricoMes12<>0) and 
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