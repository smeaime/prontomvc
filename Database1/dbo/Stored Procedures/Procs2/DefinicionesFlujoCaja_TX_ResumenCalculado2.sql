CREATE Procedure [dbo].[DefinicionesFlujoCaja_TX_ResumenCalculado2]

@Fecha datetime = Null,
@Formato varchar(10) = Null

AS 

SET NOCOUNT ON

SET @Fecha=IsNull(@Fecha,Convert(datetime,Convert(varchar,Day(getdate()),103)+'/'+Convert(varchar,Month(getdate()),103)+'/'+Convert(varchar,Year(getdate())),103))
SET @Formato=IsNull(@Formato,'SinObra')

DECLARE @proc_name varchar(1000), @FechaInicial datetime, @FechaFinal datetime, @FechaInicial2 datetime, @FechaInicial2MenosUno datetime, @FechaFinal2 datetime, 
		@IdDetalleDefinicionFlujoCaja int, @IdDefinicionFlujoCaja int, @IdCuenta int, @IdRubroContable int, @OtroConcepto varchar(50), @IdObra int, @Codigo int, 
		@Importe1 numeric(18,2), @Importe2 numeric(18,2), @Cantidad1 numeric(18,2), @Cantidad2 numeric(18,2), @Mes int, @IdAux int, @TipoConcepto int, @Coeficiente int, 
		@Presupuesto numeric(18,2), @IdEjercicioContable int, @IdTipoCuentaGrupoFF int, @IdTipoCuentaGrupoCajas int, @Formato2 varchar(10), @IdAux2 int, @Año int, 
		@Si varchar(2), @No varchar(2), @ImporteProyectado1 numeric(18,2), @ImporteProyectado2 numeric(18,2), @ImporteProyectado3 numeric(18,2), @UltimaSemana int, 
		@ImporteProyectado4 numeric(18,2), @ImporteProyectado5 numeric(18,2), @ImporteProyectado6 numeric(18,2), @Semana int, @FechaAux datetime, @FechaAux2 datetime,
		@FechaInicialMesAnterior datetime, @FechaFinalMesAnterior datetime, @ImporteMesMenosUno numeric(18,2)

SET @FechaInicial=@Fecha
SET @FechaFinal=@Fecha
SET @FechaInicialMesAnterior=Convert(datetime,'01/'+Convert(varchar,Month(Dateadd(m,-1,@Fecha)))+'/'+Convert(varchar,Year(Dateadd(m,-1,@Fecha))),103)
SET @FechaAux=Dateadd(d,-1,Dateadd(m,1,@FechaInicialMesAnterior))
SET @FechaFinalMesAnterior=Convert(datetime,Convert(varchar,Day(@FechaAux))+'/'+Convert(varchar,Month(@FechaAux))+'/'+Convert(varchar,Year(@FechaAux)),103)
SET @Año=Year(@Fecha)
SET @IdTipoCuentaGrupoFF=IsNull((Select Top 1 IdTipoCuentaGrupoFF From Parametros Where IdParametro=1),0)
SET @IdTipoCuentaGrupoCajas=IsNull((Select Top 1 IdTipoCuentaGrupo From TiposCuentaGrupos Where IsNull(EsCajaBanco,'')='CA'),0)
SET @Si='SI'
SET @No='NO'

CREATE TABLE #Auxiliar10 
						(
						 IdRubroContable INTEGER, 
						 Fecha DATETIME, 
						 Comprobante VARCHAR(20), 
						 Importe NUMERIC(18,2),
						 IdBanco INTEGER, 
						 EntreCuentasPropias VARCHAR(2)
 						)
CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (IdRubroContable,Fecha) ON [PRIMARY]

CREATE TABLE #Auxiliar11 
						(
						 IdCuenta INTEGER, 
						 Debe NUMERIC(18, 2), 
						 Haber NUMERIC(18, 2), 
						 Saldo NUMERIC(18, 2), 
						 DebeInicial NUMERIC(18, 2), 
						 HaberInicial NUMERIC(18, 2), 
						 SaldoInicial NUMERIC(18, 2)
						)
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (IdCuenta) ON [PRIMARY]

CREATE TABLE #Auxiliar12 (Importe NUMERIC(18,2))

CREATE TABLE #Auxiliar13 (Importe NUMERIC(18,2),Cantidad NUMERIC(18,2))

CREATE TABLE #Auxiliar14 (IdTipoValor INTEGER, TotalIngresos NUMERIC(18,2),TotalEgresos NUMERIC(18,2))

CREATE TABLE #Auxiliar15 
						(
						 Debe NUMERIC(18, 2), 
						 Haber NUMERIC(18, 2), 
						 Saldo NUMERIC(18, 2), 
						 DebeInicial NUMERIC(18, 2), 
						 HaberInicial NUMERIC(18, 2), 
						 SaldoInicial NUMERIC(18, 2)
						)

CREATE TABLE #Auxiliar16 
						(
						 IdAux INTEGER,
						 CodigoEmpresa VARCHAR(20),
						 Proveedor VARCHAR(50),
						 FechaVencimiento DATETIME,
						 NumeroComprobante VARCHAR(30),
						 Orden INTEGER,
						 CodigoEmpresa2 VARCHAR(20),
						 Proveedor2 VARCHAR(50),
						 Detalle VARCHAR(100),
						 FechaVencimiento2 DATETIME,
						 RubroFinanciero VARCHAR(30),
						 ImporteCuota NUMERIC(18, 2),
						 SaldoCuota NUMERIC(18, 2),
						 DiasVencido INTEGER,
						 DiasAVencer INTEGER,
						 SaldoVencido NUMERIC(18, 2),
						 Saldo_0_30 NUMERIC(18, 2),
						 Saldo_30_60 NUMERIC(18, 2),
						 Saldo_60_90 NUMERIC(18, 2),
						 Saldo_90_120 NUMERIC(18, 2),
						 Saldo_120_150 NUMERIC(18, 2),
						 Saldo_150_180 NUMERIC(18, 2),
						 Saldo_180_270 NUMERIC(18, 2),
						 Saldo_270_365 NUMERIC(18, 2),
						 Saldo_1_2 NUMERIC(18, 2),
						 Saldo_2_3 NUMERIC(18, 2),
						 Saldo_Mas3 NUMERIC(18, 2),
						 Observaciones2 VARCHAR(1000),
						 IdTipoComprobante INTEGER,
						 IdComprobante INTEGER,
						 NumeroObra VARCHAR(13),
						 IdOrdenPagoCancelacion INTEGER,
						 FechaComprobante DATETIME,
						 CancelacionInmediataDeDeuda VARCHAR(2),
						 DebitoAutomatico VARCHAR(2),
						 NumeroComprobanteCancelacion VARCHAR(30)
						)
CREATE NONCLUSTERED INDEX IX__Auxiliar16 ON #Auxiliar16 (Proveedor, FechaVencimiento, NumeroComprobante) ON [PRIMARY]

CREATE TABLE #Auxiliar17 
						(
						 IdValor INTEGER,
						 Banco VARCHAR(50),
						 NumeroInterno INTEGER,
						 NumeroValor NUMERIC(18, 0),
						 FechaValor DATETIME,
						 Importe NUMERIC(18, 2),
						 Moneda VARCHAR(15),
						 FechaComprobante DATETIME,
						 TipoComprobante VARCHAR(5),
						 NumeroComprobante INTEGER,
						 Proveedor VARCHAR(50),
						 DiasAVencer INTEGER,
						 Detalle VARCHAR(30),
						 Observaciones VARCHAR(1000),
						 IdTipoComprobante INTEGER,
						 IdComprobante INTEGER
						)
CREATE NONCLUSTERED INDEX IX__Auxiliar17 ON #Auxiliar17 (IdValor) ON [PRIMARY]

SET @proc_name='RubrosContables_TX_EntreFechas'
INSERT INTO #Auxiliar10 
	EXECUTE @proc_name -1, @FechaInicial, @FechaFinal, @Formato

-- Esto lo hago en falso porque sino me da error --
SET @proc_name='Cuentas_TX_MayorPorIdCuentaEntreFechas'
TRUNCATE TABLE #Auxiliar11
INSERT INTO #Auxiliar11 
	EXECUTE @proc_name @IdCuenta, @FechaInicial, @FechaFinal, @Formato

-- Esto lo hago en falso porque sino me da error --
SET @proc_name='Valores_TX_EnCarteraAFecha'
TRUNCATE TABLE #Auxiliar12
INSERT INTO #Auxiliar12 
	EXECUTE @proc_name @FechaInicial

-- Esto lo hago en falso porque sino me da error --
SET @proc_name='Conciliaciones_TX_NoConciliadosAFecha'
TRUNCATE TABLE #Auxiliar14
INSERT INTO #Auxiliar14 
	EXECUTE @proc_name @FechaInicial, @Formato

CREATE TABLE #Auxiliar100 (IdDetalleDefinicionFlujoCaja INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar100 ON #Auxiliar100 (IdDetalleDefinicionFlujoCaja) ON [PRIMARY]

CREATE TABLE #Auxiliar20 
						(
						 IdAux INTEGER IDENTITY (1, 1), 
						 Codigo INTEGER, 
						 ImporteCuentasInicial NUMERIC(18, 2), 
						 ImporteCuentasFinal NUMERIC(18, 2), 
						 ImporteRubros NUMERIC(18, 2), 
						 ImporteOtrosConceptosInicial NUMERIC(18, 2),
						 ImporteOtrosConceptosFinal NUMERIC(18, 2),
						 ImportePresupuestado NUMERIC(18, 2),
						 ImporteProyectado1 NUMERIC(18, 2),
						 ImporteProyectado2 NUMERIC(18, 2),
						 ImporteProyectado3 NUMERIC(18, 2),
						 ImporteProyectado4 NUMERIC(18, 2),
						 ImporteProyectado5 NUMERIC(18, 2),
						 ImporteProyectado6 NUMERIC(18, 2),
						 Entidad VARCHAR(50),
						 OtroConcepto VARCHAR(50),
						 TipoProveedor INTEGER,
						 ImporteMesMenosUno NUMERIC(18, 2)
						)
CREATE NONCLUSTERED INDEX IX__Auxiliar20 ON #Auxiliar20 (Codigo, Entidad) ON [PRIMARY]

CREATE TABLE #Auxiliar21 
						(
						 Codigo INTEGER, 
						 ImporteOtrosConceptos NUMERIC(18, 2),
						 ImporteProyectado1 NUMERIC(18, 2),
						 ImporteProyectado2 NUMERIC(18, 2),
						 ImporteProyectado3 NUMERIC(18, 2),
						 ImporteProyectado4 NUMERIC(18, 2),
						 ImporteProyectado5 NUMERIC(18, 2),
						 ImporteProyectado6 NUMERIC(18, 2),
						 Entidad VARCHAR(50),
						 OtroConcepto VARCHAR(50),
						 TipoProveedor INTEGER
						)
CREATE NONCLUSTERED INDEX IX__Auxiliar21 ON #Auxiliar21 (Codigo, Entidad) ON [PRIMARY]

INSERT INTO #Auxiliar100 
 SELECT IdDetalleDefinicionFlujoCaja
 FROM DetalleDefinicionesFlujoCajaCuentas

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleDefinicionFlujoCaja FROM #Auxiliar100 ORDER BY IdDetalleDefinicionFlujoCaja
OPEN Cur 
FETCH NEXT FROM Cur INTO @IdDetalleDefinicionFlujoCaja
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @IdDefinicionFlujoCaja=IsNull((Select Top 1 IdDefinicionFlujoCaja From DetalleDefinicionesFlujoCajaCuentas Where IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja),0)
	SET @IdCuenta=IsNull((Select Top 1 IdCuenta From DetalleDefinicionesFlujoCajaCuentas Where IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja),0)
	SET @IdRubroContable=IsNull((Select Top 1 IdRubroContable From DetalleDefinicionesFlujoCajaCuentas Where IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja),0)
	SET @OtroConcepto=IsNull((Select Top 1 OtroConcepto From DetalleDefinicionesFlujoCajaCuentas Where IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja),'')

	SET @Codigo=IsNull((Select Top 1 Codigo From DefinicionesFlujoCaja Where IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja),0)
	SET @TipoConcepto=IsNull((Select Top 1 TipoConcepto From DefinicionesFlujoCaja Where IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja),1)
	IF @TipoConcepto<>1
		SET @Coeficiente=1
	ELSE
		SET @Coeficiente=-1

	SET @FechaInicial2=Convert(datetime,'1/1/2000',103)
	SET @FechaFinal2=@Fecha
	SET @FechaInicial2MenosUno=DateAdd(day,-1,@Fecha)
	
	IF @IdCuenta>0
	  BEGIN
		SET @proc_name='Cuentas_TX_MayorPorIdCuentaEntreFechas'
		TRUNCATE TABLE #Auxiliar11
		INSERT INTO #Auxiliar11 
			EXECUTE @proc_name @IdCuenta, @FechaInicial2, @Fecha, @Formato

		SET @Importe1=IsNull((Select Top 1 IsNull(SaldoInicial,0) From #Auxiliar11),0) * @Coeficiente
		SET @Importe2=IsNull((Select Top 1 IsNull(SaldoInicial,0)+IsNull(Saldo,0) From #Auxiliar11),0) * @Coeficiente

		TRUNCATE TABLE #Auxiliar11
		INSERT INTO #Auxiliar11 
			EXECUTE @proc_name @IdCuenta, @FechaInicialMesAnterior, @FechaFinalMesAnterior, @Formato

		SET @ImporteMesMenosUno=IsNull((Select Top 1 IsNull(Saldo,0) From #Auxiliar11),0) * @Coeficiente

		IF @Formato='SinObra'
			SET @IdObra=0
		ELSE
			SET @IdObra=0

		SET @IdEjercicioContable=IsNull((Select Top 1 IdEjercicioContable From EjerciciosContables Where Convert(datetime,'01/' + Convert(varchar,@Mes) + '/' + Convert(varchar,@Año)) between FechaInicio and FechaFinalizacion),0)
		--SET @Presupuesto=IsNull((Select 
		--						 Case When @Mes=1  Then Sum(IsNull(PresupuestoTeoricoMes01,0)) When @Mes=2  Then Sum(IsNull(PresupuestoTeoricoMes02,0)) When @Mes=3  Then Sum(IsNull(PresupuestoTeoricoMes03,0))
		--								When @Mes=4  Then Sum(IsNull(PresupuestoTeoricoMes04,0)) When @Mes=5  Then Sum(IsNull(PresupuestoTeoricoMes05,0)) When @Mes=6  Then Sum(IsNull(PresupuestoTeoricoMes06,0))
		--								When @Mes=7  Then Sum(IsNull(PresupuestoTeoricoMes07,0)) When @Mes=8  Then Sum(IsNull(PresupuestoTeoricoMes08,0)) When @Mes=9  Then Sum(IsNull(PresupuestoTeoricoMes09,0))
		--								When @Mes=10 Then Sum(IsNull(PresupuestoTeoricoMes10,0)) When @Mes=11 Then Sum(IsNull(PresupuestoTeoricoMes11,0)) When @Mes=12 Then Sum(IsNull(PresupuestoTeoricoMes12,0))
		--								Else 0
		--						 End
		--						 From CuentasEjerciciosContables Where IdCuenta=@IdCuenta and IdEjercicioContable=@IdEjercicioContable),0)

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado, ImporteMesMenosUno)
			VALUES 
			(@Codigo, @Importe1, @Importe2, 0, 0, 0, @Presupuesto, @ImporteMesMenosUno)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteCuentasInicial=IsNull(ImporteCuentasInicial,0)+@Importe1, ImporteCuentasFinal=IsNull(ImporteCuentasFinal,0)+@Importe2, 
				ImporteMesMenosUno=IsNull(ImporteMesMenosUno,0)+@ImporteMesMenosUno
			WHERE IdAux=@IdAux
	  END

	IF @IdRubroContable>0
	  BEGIN
		IF @Formato='SinObra'
			SET @IdObra=0
		ELSE
			SET @IdObra=IsNull((Select Top 1 IdObra From RubrosContables Where IdRubroContable=@IdRubroContable),0)

		SET @Importe1=IsNull((Select Sum(IsNull(Importe,0)) From #Auxiliar10 Where IdRubroContable=@IdRubroContable),0) * @Coeficiente * -1
		SET @Presupuesto=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0)) From PresupuestoFinanciero Where IdRubroContable=@IdRubroContable and IsNull(Tipo,'M')='A'),0)

		SET @FechaAux=@Fecha
		IF Day(@FechaAux)<=7
			SET @Semana=1
		IF Day(@FechaAux)>7 and Day(@FechaAux)<=14
			SET @Semana=2
		IF Day(@FechaAux)>14 and Day(@FechaAux)<=21
			SET @Semana=3
		IF Day(@FechaAux)>21
			SET @Semana=4
		SET @ImporteProyectado1=IsNull((Select Top 1 IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0)
										From PresupuestoFinanciero
										Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana=@Semana),0)

		SET @FechaAux=DateAdd(d, 7, @Fecha)
		IF Day(@FechaAux)<=7
			SET @Semana=1
		IF Day(@FechaAux)>7 and Day(@FechaAux)<=14
			SET @Semana=2
		IF Day(@FechaAux)>14 and Day(@FechaAux)<=21
			SET @Semana=3
		IF Day(@FechaAux)>21
			SET @Semana=4
		SET @ImporteProyectado2=IsNull((Select Top 1 IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0)
										From PresupuestoFinanciero
										Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana=@Semana),0)

		SET @FechaAux=DateAdd(d, 14, @Fecha)
		IF Day(@FechaAux)<=7
			SET @Semana=1
		IF Day(@FechaAux)>7 and Day(@FechaAux)<=14
			SET @Semana=2
		IF Day(@FechaAux)>14 and Day(@FechaAux)<=21
			SET @Semana=3
		IF Day(@FechaAux)>21
			SET @Semana=4
		SET @ImporteProyectado3=IsNull((Select Top 1 IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0)
										From PresupuestoFinanciero
										Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana=@Semana),0)
		SET @UltimaSemana=@Semana
		
		SET @FechaAux=DateAdd(d, 21, @Fecha)
		IF Day(@FechaAux)<=7
			SET @Semana=1
		IF Day(@FechaAux)>7 and Day(@FechaAux)<=14
			SET @Semana=2
		IF Day(@FechaAux)>14 and Day(@FechaAux)<=21
			SET @Semana=3
		IF Day(@FechaAux)>21
			SET @Semana=4
		IF @Semana=@UltimaSemana
		  BEGIN
			SET @FechaAux=DateAdd(m, 1, @Fecha)
			SET @Semana=1
		  END
		SET @ImporteProyectado4=IsNull((Select Top 1 IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0)
										From PresupuestoFinanciero
										Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana=@Semana),0)

		SET @FechaAux=DateAdd(m, 1, @Fecha)
		SET @FechaAux2=DateAdd(m, 2, @Fecha)
		IF Day(@FechaAux)<=7
			SET @ImporteProyectado5=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M'),0)
		IF Day(@FechaAux)>7 and Day(@FechaAux)<=14
			SET @ImporteProyectado5=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana>=2),0) + 
									IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux2) and Mes=Month(@FechaAux2) and Tipo='M' and Semana<2),0)
		IF Day(@FechaAux)>14 and Day(@FechaAux)<=21
			SET @ImporteProyectado5=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana>=3),0) + 
									IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux2) and Mes=Month(@FechaAux2) and Tipo='M' and Semana<3),0)
		IF Day(@FechaAux)>21
			SET @ImporteProyectado5=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana>=4),0) + 
									IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux2) and Mes=Month(@FechaAux2) and Tipo='M' and Semana<4),0)

		SET @FechaAux=DateAdd(m, 2, @Fecha)
		SET @FechaAux2=convert(datetime,'01/'+Convert(varchar,Month(DateAdd(m, 3, @Fecha)))+'/'+Convert(varchar,Year(DateAdd(m, 3, @Fecha))),103)
		IF Day(@FechaAux)<=7
			SET @ImporteProyectado6=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M'),0) + 
									IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Convert(datetime,'01/'+Convert(varchar,Mes)+'/'+Convert(varchar,Año),103)>=@FechaAux2 and Tipo='M'),0)
		IF Day(@FechaAux)>7 and Day(@FechaAux)<=14
			SET @ImporteProyectado6=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana>=2),0) + 
									IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Convert(datetime,'01/'+Convert(varchar,Mes)+'/'+Convert(varchar,Año),103)>=@FechaAux2 and Tipo='M'),0)
		IF Day(@FechaAux)>14 and Day(@FechaAux)<=21
			SET @ImporteProyectado6=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana>=3),0) + 
									IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Convert(datetime,'01/'+Convert(varchar,Mes)+'/'+Convert(varchar,Año),103)>=@FechaAux2 and Tipo='M'),0)
		IF Day(@FechaAux)>21
			SET @ImporteProyectado6=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Año=Year(@FechaAux) and Mes=Month(@FechaAux) and Tipo='M' and Semana>=4),0) + 
									IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0))
											From PresupuestoFinanciero
											Where IdRubroContable=@IdRubroContable and Convert(datetime,'01/'+Convert(varchar,Mes)+'/'+Convert(varchar,Año),103)>=@FechaAux2 and Tipo='M'),0)

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado, 
			 ImporteProyectado1, ImporteProyectado2, ImporteProyectado3, ImporteProyectado4, ImporteProyectado5, ImporteProyectado6)
			VALUES 
			(@Codigo, 0, 0, @Importe1, 0, 0, @Presupuesto, @ImporteProyectado1, @ImporteProyectado2, @ImporteProyectado3, @ImporteProyectado4, 
			 @ImporteProyectado5, @ImporteProyectado6)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteRubros=IsNull(ImporteRubros,0)+@Importe1
			WHERE IdAux=@IdAux

	  END

	IF @OtroConcepto='Cheques recibidos y no depositados'
	  BEGIN
		IF @Formato='SinObra'
			SET @IdObra=0
		ELSE
			SET @IdObra=0
		
		SET @proc_name='Valores_TX_EnCarteraAFecha'
		TRUNCATE TABLE #Auxiliar12
		INSERT INTO #Auxiliar12 
			EXECUTE @proc_name @FechaInicial2MenosUno
		SET @Importe1=IsNull((Select Top 1 Importe From #Auxiliar12),0)

		TRUNCATE TABLE #Auxiliar12
		INSERT INTO #Auxiliar12 
			EXECUTE @proc_name @FechaFinal2
		SET @Importe2=IsNull((Select Top 1 Importe From #Auxiliar12),0)

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
			VALUES 
			(@Codigo, 0, 0, 0, @Importe1, @Importe2, 0)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
			WHERE IdAux=@IdAux
	  END

	IF @OtroConcepto='Cheques depositados y no acreditados'
	  BEGIN
		IF @Formato='SinObra'
			SET @IdObra=0
		ELSE
			SET @IdObra=0

		SET @proc_name='Valores_TX_DepositadosNoAcreditadosAFecha'
		TRUNCATE TABLE #Auxiliar12
		INSERT INTO #Auxiliar12 
			EXECUTE @proc_name @FechaInicial2MenosUno
		SET @Importe1=IsNull((Select Top 1 Importe From #Auxiliar12),0)

		TRUNCATE TABLE #Auxiliar12
		INSERT INTO #Auxiliar12 
			EXECUTE @proc_name @FechaFinal2
		SET @Importe2=IsNull((Select Top 1 Importe From #Auxiliar12),0)

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
			VALUES 
			(@Codigo, 0, 0, 0, @Importe1, @Importe2, 0)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
			WHERE IdAux=@IdAux
	  END

	IF @OtroConcepto='Cheques emitidos y no pagados'
	  BEGIN
		IF @Formato='SinObra'
			SET @IdObra=0
		ELSE
			SET @IdObra=0

		SET @proc_name='Valores_TX_EmitidosNoAcreditadosAFecha'
		TRUNCATE TABLE #Auxiliar12
		INSERT INTO #Auxiliar12 
			EXECUTE @proc_name @FechaInicial2MenosUno
		SET @Importe1=IsNull((Select Top 1 Importe From #Auxiliar12),0)

		TRUNCATE TABLE #Auxiliar12
		INSERT INTO #Auxiliar12 
			EXECUTE @proc_name @FechaFinal2
		SET @Importe2=IsNull((Select Top 1 Importe From #Auxiliar12),0)

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
			VALUES 
			(@Codigo, 0, 0, 0, @Importe1, @Importe2, 0)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
			WHERE IdAux=@IdAux
	  END
	IF @OtroConcepto='Saldo bancos (segun extractos)'
	  BEGIN
		IF @Formato='SinObra'
			SET @IdObra=0
		ELSE
			SET @IdObra=0

		SET @proc_name='Conciliaciones_TX_SaldosSegunExtractos'
/*
		TRUNCATE TABLE #Auxiliar13
		INSERT INTO #Auxiliar13 
			EXECUTE @proc_name @FechaInicial2MenosUno
		SET @Importe1=IsNull((Select Top 1 Importe From #Auxiliar13),0)
		SET @Cantidad1=IsNull((Select Top 1 Cantidad From #Auxiliar13),0)
*/
		TRUNCATE TABLE #Auxiliar13
		INSERT INTO #Auxiliar13 
			EXECUTE @proc_name @FechaFinal2
		SET @Importe1=IsNull((Select Top 1 Cantidad From #Auxiliar13),0)
		SET @Importe2=IsNull((Select Top 1 Importe From #Auxiliar13),0)

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
			VALUES 
			(@Codigo, 0, 0, 0, @Importe1, @Importe2, 0)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
			WHERE IdAux=@IdAux
	  END

	IF @OtroConcepto='Movim.inexistentes en resumen bancarios a fecha'
	  BEGIN
		IF @Formato='SinObra'
			SET @IdObra=0
		ELSE
			SET @IdObra=0

		SET @proc_name='Conciliaciones_TX_NoConciliadosAFecha'
		TRUNCATE TABLE #Auxiliar14
		INSERT INTO #Auxiliar14 
			EXECUTE @proc_name @FechaInicial2MenosUno, @Formato
		SET @Importe1=IsNull((Select Top 1 Sum(IsNull(TotalIngresos,0)-IsNull(TotalEgresos,0)) From #Auxiliar14 Where IdTipoValor=6),0) * -1

		TRUNCATE TABLE #Auxiliar14
		INSERT INTO #Auxiliar14 
			EXECUTE @proc_name @FechaFinal2, @Formato
		SET @Importe2=IsNull((Select Top 1 Sum(IsNull(TotalIngresos,0)-IsNull(TotalEgresos,0)) From #Auxiliar14 Where IdTipoValor=6),0) * -1

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
			VALUES 
			(@Codigo, 0, 0, 0, @Importe1, @Importe2, 0)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
			WHERE IdAux=@IdAux
	  END

	IF @OtroConcepto='Saldo contable cajas'
	  BEGIN
		SET @Formato2=''
		SET @IdAux2=-1
		SET @proc_name='Cuentas_TX_MayorPorIdCuentaEntreFechas'
		TRUNCATE TABLE #Auxiliar15
		INSERT INTO #Auxiliar15 
			EXECUTE @proc_name @IdAux2, @FechaInicial2, @FechaFinal2, @Formato2, @IdTipoCuentaGrupoCajas
		SET @Importe1=IsNull((Select Top 1 IsNull(SaldoInicial,0) From #Auxiliar15),0) * @Coeficiente
		SET @Importe2=IsNull((Select Top 1 IsNull(SaldoInicial,0)+IsNull(Saldo,0) From #Auxiliar15),0) * @Coeficiente

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
			VALUES 
			(@Codigo, 0, 0, 0, @Importe1, @Importe2, 0)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
			WHERE IdAux=@IdAux
	  END

	IF @OtroConcepto='Saldo contable fondos fijos'
	  BEGIN
		SET @Formato2=''
		SET @IdAux2=-1
		SET @proc_name='Cuentas_TX_MayorPorIdCuentaEntreFechas'
		TRUNCATE TABLE #Auxiliar15
		INSERT INTO #Auxiliar15 
			EXECUTE @proc_name @IdAux2, @FechaInicial2, @FechaFinal2, @Formato2, @IdTipoCuentaGrupoFF
		SET @Importe1=IsNull((Select Top 1 IsNull(SaldoInicial,0) From #Auxiliar15),0) * @Coeficiente
		SET @Importe2=IsNull((Select Top 1 IsNull(SaldoInicial,0)+IsNull(Saldo,0) From #Auxiliar15),0) * @Coeficiente

		SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo),0)
		IF @IdAux=0 
			INSERT INTO #Auxiliar20
			(Codigo, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
			VALUES 
			(@Codigo, 0, 0, 0, @Importe1, @Importe2, 0)
		ELSE
			UPDATE #Auxiliar20
			SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
			WHERE IdAux=@IdAux
	  END

	IF @OtroConcepto='Saldos cuentas a pagar'
	  BEGIN
		SET @Formato2=''
		SET @IdAux2=-1
		SET @proc_name='CtasCtesA_TX_DeudaVencida'
		TRUNCATE TABLE #Auxiliar21
		TRUNCATE TABLE #Auxiliar16
		INSERT INTO #Auxiliar16 
			EXECUTE @proc_name @Fecha, @IdAux2, @Formato2, @Formato2, @IdAux2, @IdAux2, @Si, @No, @No, @No, @Si, @IdAux2

		DECLARE @CodigoEmpresa varchar(20), @Proveedor varchar(50), @FechaVencimiento datetime, @NumeroComprobante varchar(30), @Orden int,
				@CodigoEmpresa2 varchar(20), @Proveedor2 varchar(50), @Detalle varchar(100), @FechaVencimiento2 datetime, @RubroFinanciero varchar(30), 
				@ImporteCuota numeric(18, 2), @SaldoCuota numeric(18, 2), @DiasVencido int, @DiasAVencer int, @SaldoVencido numeric(18, 2), @Saldo_0_30 numeric(18, 2), 
				@Saldo_30_60 numeric(18, 2), @Saldo_60_90 numeric(18, 2), @Saldo_90_120 numeric(18, 2), @Saldo_120_150 numeric(18, 2), @Saldo_150_180 numeric(18, 2), 
				@Saldo_180_270 numeric(18, 2), @Saldo_270_365 numeric(18, 2), @Saldo_1_2 numeric(18, 2), @Saldo_2_3 numeric(18, 2), @Saldo_Mas3 numeric(18, 2), 
				@Observaciones2 varchar(1000), @IdTipoComprobante int, @IdComprobante int, @NumeroObra varchar(13), @IdOrdenPagoCancelacion int, @TipoProveedor int, 
				@FechaComprobante datetime,	@CancelacionInmediataDeDeuda varchar(2), @DebitoAutomatico varchar(2), @NumeroComprobanteCancelacion varchar(30)

		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR 
				SELECT IdAux, CodigoEmpresa, Proveedor, FechaVencimiento, NumeroComprobante, Orden, CodigoEmpresa2, Proveedor2, Detalle, FechaVencimiento2, 
						RubroFinanciero, ImporteCuota, SaldoCuota, DiasVencido, DiasAVencer, SaldoVencido, Saldo_0_30, Saldo_30_60, Saldo_60_90, Saldo_90_120, 
						Saldo_120_150, Saldo_150_180, Saldo_180_270, Saldo_270_365, Saldo_1_2, Saldo_2_3, Saldo_Mas3, Observaciones2, IdTipoComprobante,IdComprobante,
						NumeroObra, IdOrdenPagoCancelacion, FechaComprobante, CancelacionInmediataDeDeuda, DebitoAutomatico, NumeroComprobanteCancelacion
				FROM #Auxiliar16
				ORDER BY Proveedor, FechaVencimiento, NumeroComprobante
		OPEN Cur2
		FETCH NEXT FROM Cur2 INTO @IdAux, @CodigoEmpresa, @Proveedor, @FechaVencimiento, @NumeroComprobante, @Orden, @CodigoEmpresa2, @Proveedor2, @Detalle, @FechaVencimiento2, 
									@RubroFinanciero, @ImporteCuota, @SaldoCuota, @DiasVencido, @DiasAVencer, @SaldoVencido, @Saldo_0_30, @Saldo_30_60, @Saldo_60_90, 
									@Saldo_90_120, @Saldo_120_150, @Saldo_150_180, @Saldo_180_270, @Saldo_270_365, @Saldo_1_2, @Saldo_2_3, @Saldo_Mas3, @Observaciones2, 
									@IdTipoComprobante, @IdComprobante, @NumeroObra, @IdOrdenPagoCancelacion, @FechaComprobante, @CancelacionInmediataDeDeuda, @DebitoAutomatico, 
									@NumeroComprobanteCancelacion
		WHILE @@FETCH_STATUS = 0
		  BEGIN
			SET @Importe1=0
			SET @ImporteProyectado1=0
			SET @ImporteProyectado2=0
			SET @ImporteProyectado3=0
			SET @ImporteProyectado4=0
			SET @ImporteProyectado5=0
			SET @ImporteProyectado6=0

			SET @TipoProveedor=IsNull((Select Top 1 TipoProveedor From Proveedores Where CodigoEmpresa=@CodigoEmpresa),0)

			IF IsNull(@DiasAVencer,0)>0
			  BEGIN
				IF @DiasAVencer>0 and @DiasAVencer<=7
					SET @ImporteProyectado1=@SaldoCuota
				IF @DiasAVencer>7 and @DiasAVencer<=14
					SET @ImporteProyectado2=@SaldoCuota
				IF @DiasAVencer>14 and @DiasAVencer<=21
					SET @ImporteProyectado3=@SaldoCuota
				IF @DiasAVencer>21 and @DiasAVencer<=28
					SET @ImporteProyectado4=@SaldoCuota
				IF @DiasAVencer>28 and @DiasAVencer<=60
					SET @ImporteProyectado5=@SaldoCuota
				IF @DiasAVencer>60
					SET @ImporteProyectado6=@SaldoCuota
			  END
			ELSE
				SET @Importe1=@SaldoCuota

			INSERT INTO #Auxiliar21
			(Codigo, ImporteOtrosConceptos, ImporteProyectado1, ImporteProyectado2, ImporteProyectado3, ImporteProyectado4, ImporteProyectado5, ImporteProyectado6, 
			 Entidad, OtroConcepto, TipoProveedor)
			VALUES 
			(@Codigo, @Importe1, @ImporteProyectado1, @ImporteProyectado2, @ImporteProyectado3, @ImporteProyectado4, @ImporteProyectado5, @ImporteProyectado6, 
			 @Proveedor, @OtroConcepto, @TipoProveedor)

			FETCH NEXT FROM Cur2 INTO @IdAux, @CodigoEmpresa, @Proveedor, @FechaVencimiento, @NumeroComprobante, @Orden, @CodigoEmpresa2, @Proveedor2, @Detalle, @FechaVencimiento2, 
										@RubroFinanciero, @ImporteCuota, @SaldoCuota, @DiasVencido, @DiasAVencer, @SaldoVencido, @Saldo_0_30, @Saldo_30_60, @Saldo_60_90, 
										@Saldo_90_120, @Saldo_120_150, @Saldo_150_180, @Saldo_180_270, @Saldo_270_365, @Saldo_1_2, @Saldo_2_3, @Saldo_Mas3, @Observaciones2, 
										@IdTipoComprobante, @IdComprobante, @NumeroObra, @IdOrdenPagoCancelacion, @FechaComprobante, @CancelacionInmediataDeDeuda, @DebitoAutomatico, 
										@NumeroComprobanteCancelacion
		  END
		CLOSE Cur2
		DEALLOCATE Cur2

		INSERT INTO #Auxiliar20
		 SELECT Codigo, 0, 0, 0, 0, Sum(IsNull(ImporteOtrosConceptos,0)), 0, Sum(IsNull(ImporteProyectado1,0)), Sum(IsNull(ImporteProyectado2,0)), 
				Sum(IsNull(ImporteProyectado3,0)), Sum(IsNull(ImporteProyectado4,0)), Sum(IsNull(ImporteProyectado5,0)), Sum(IsNull(ImporteProyectado6,0)), Entidad, 
				Max(OtroConcepto), Max(TipoProveedor), Null
		 FROM #Auxiliar21
		 GROUP BY Codigo, Entidad

		DELETE #Auxiliar20
		WHERE OtroConcepto=@OtroConcepto and ImporteOtrosConceptosFinal=0 and ImporteProyectado1=0 and ImporteProyectado2=0 and ImporteProyectado3=0 and 
				 ImporteProyectado4=0 and ImporteProyectado5=0 and ImporteProyectado6=0
	  END

	IF @OtroConcepto='Valores diferidos'
	  BEGIN
		SET @Formato2=''
		SET @IdAux2=-1
		SET @proc_name='Bancos_TX_InformeChequesDiferidos1'
		TRUNCATE TABLE #Auxiliar21
		TRUNCATE TABLE #Auxiliar17
		INSERT INTO #Auxiliar17 
			EXECUTE @proc_name @Fecha, @IdAux2, @Si

		DECLARE @IdValor int, @Banco varchar(50), @NumeroInterno int, @FechaValor datetime, @Importe numeric(18, 2), @Moneda varchar(15), @TipoComprobante varchar(5), 
				@NumeroValor numeric(18, 0)

		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR 
				SELECT IdValor, Banco, NumeroInterno, NumeroValor, FechaValor, Importe, Moneda, FechaComprobante, TipoComprobante, NumeroComprobante, Proveedor, 
						DiasAVencer, Detalle, Observaciones, IdTipoComprobante, IdComprobante
				FROM #Auxiliar17
				ORDER BY IdValor
		OPEN Cur2
		FETCH NEXT FROM Cur2 INTO @IdValor, @Banco, @NumeroInterno, @NumeroValor, @FechaValor, @Importe, @Moneda, @FechaComprobante, @TipoComprobante, @NumeroComprobante, 
									@Proveedor, @DiasAVencer, @Detalle, @Observaciones2, @IdTipoComprobante, @IdComprobante
		WHILE @@FETCH_STATUS = 0
		  BEGIN
			SET @Importe1=0
			SET @ImporteProyectado1=0
			SET @ImporteProyectado2=0
			SET @ImporteProyectado3=0
			SET @ImporteProyectado4=0
			SET @ImporteProyectado5=0
			SET @ImporteProyectado6=0

			IF IsNull(@DiasAVencer,0)>0
			  BEGIN
				IF @DiasAVencer>0 and @DiasAVencer<=7
					SET @ImporteProyectado1=@Importe
				IF @DiasAVencer>7 and @DiasAVencer<=14
					SET @ImporteProyectado2=@Importe
				IF @DiasAVencer>14 and @DiasAVencer<=21
					SET @ImporteProyectado3=@Importe
				IF @DiasAVencer>21 and @DiasAVencer<=28
					SET @ImporteProyectado4=@Importe
				IF @DiasAVencer>28 and @DiasAVencer<=60
					SET @ImporteProyectado5=@Importe
				IF @DiasAVencer>60
					SET @ImporteProyectado6=@Importe
			  END
			ELSE
				SET @Importe1=@Importe

			INSERT INTO #Auxiliar21
			(Codigo, ImporteOtrosConceptos, ImporteProyectado1, ImporteProyectado2, ImporteProyectado3, ImporteProyectado4, ImporteProyectado5, ImporteProyectado6, 
			 Entidad, OtroConcepto)
			VALUES 
			(@Codigo, @Importe1, @ImporteProyectado1, @ImporteProyectado2, @ImporteProyectado3, @ImporteProyectado4, @ImporteProyectado5, @ImporteProyectado6, 
			 @Proveedor, @OtroConcepto)

			FETCH NEXT FROM Cur2 INTO @IdValor, @Banco, @NumeroInterno, @NumeroValor, @FechaValor, @Importe, @Moneda, @FechaComprobante, @TipoComprobante, @NumeroComprobante, 
										@Proveedor, @DiasAVencer, @Detalle, @Observaciones2, @IdTipoComprobante, @IdComprobante
		  END
		CLOSE Cur2
		DEALLOCATE Cur2

		INSERT INTO #Auxiliar20
		 SELECT Codigo, 0, 0, 0, 0, Sum(IsNull(ImporteOtrosConceptos,0)), 0, Sum(IsNull(ImporteProyectado1,0)), Sum(IsNull(ImporteProyectado2,0)), 
				Sum(IsNull(ImporteProyectado3,0)), Sum(IsNull(ImporteProyectado4,0)), Sum(IsNull(ImporteProyectado5,0)), Sum(IsNull(ImporteProyectado6,0)), Null, 
				Max(OtroConcepto), Null, Null
		 FROM #Auxiliar21
		 GROUP BY Codigo
	  END

	FETCH NEXT FROM Cur INTO @IdDetalleDefinicionFlujoCaja
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT * 
FROM #Auxiliar20 
ORDER BY Codigo, TipoProveedor, ImporteOtrosConceptosFinal Desc, Entidad

DROP TABLE #Auxiliar100
DROP TABLE #Auxiliar20
DROP TABLE #Auxiliar21
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13
DROP TABLE #Auxiliar14
DROP TABLE #Auxiliar15
DROP TABLE #Auxiliar16
DROP TABLE #Auxiliar17