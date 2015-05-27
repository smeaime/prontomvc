CREATE Procedure [dbo].[DefinicionesFlujoCaja_TX_ResumenCalculado]

@Año int = Null,
@Formato varchar(10) = Null

AS 

SET NOCOUNT ON

SET @Año=IsNull(@Año,Year(GetDate()))
SET @Formato=IsNull(@Formato,'SinObra')

DECLARE @proc_name varchar(1000), @FechaInicial datetime, @FechaFinal datetime, @FechaInicial2 datetime, @FechaInicial2MenosUno datetime, @FechaFinal2 datetime, 
		@IdDetalleDefinicionFlujoCaja int, @IdDefinicionFlujoCaja int, @IdCuenta int, @IdRubroContable int, @OtroConcepto varchar(50), @IdObra int, @Codigo int, 
		@Importe1 numeric(18,2), @Importe2 numeric(18,2), @Cantidad1 numeric(18,2), @Cantidad2 numeric(18,2), @Mes int, @IdAux int, @TipoConcepto int, @Coeficiente int, 
		@Presupuesto numeric(18,2), @IdEjercicioContable int, @IdTipoCuentaGrupoFF int, @IdTipoCuentaGrupoCajas int, @Formato2 varchar(10), @IdAux2 int

SET @FechaInicial=Convert(datetime,'1/1/'+Convert(varchar,@Año),103)
SET @FechaFinal=Convert(datetime,'31/12/'+Convert(varchar,@Año),103)

SET @IdTipoCuentaGrupoFF=IsNull((Select Top 1 IdTipoCuentaGrupoFF From Parametros Where IdParametro=1),0)
SET @IdTipoCuentaGrupoCajas=IsNull((Select Top 1 IdTipoCuentaGrupo From TiposCuentaGrupos Where IsNull(EsCajaBanco,'')='CA'),0)

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
						 IdObra INTEGER, 
						 Año INTEGER, 
						 Mes INTEGER, 
						 ImporteCuentasInicial NUMERIC(18, 2), 
						 ImporteCuentasFinal NUMERIC(18, 2), 
						 ImporteRubros NUMERIC(18, 2), 
						 ImporteOtrosConceptosInicial NUMERIC(18, 2),
						 ImporteOtrosConceptosFinal NUMERIC(18, 2),
						 ImportePresupuestado NUMERIC(18, 2)
						)
CREATE NONCLUSTERED INDEX IX__Auxiliar20 ON #Auxiliar20 (Codigo, IdObra, Año, Mes) ON [PRIMARY]

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

	SET @Mes=1
	WHILE @Mes<=12
	  BEGIN
		SET @FechaInicial2=Convert(datetime,'1/'+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año),103)
		SET @FechaFinal2=DateAdd(day,-1,DateAdd(m,1,@FechaInicial2))
		SET @FechaInicial2MenosUno=DateAdd(day,-1,@FechaInicial2)
		
		IF @IdCuenta>0
		  BEGIN
			SET @proc_name='Cuentas_TX_MayorPorIdCuentaEntreFechas'
			TRUNCATE TABLE #Auxiliar11
			INSERT INTO #Auxiliar11 
				EXECUTE @proc_name @IdCuenta, @FechaInicial2, @FechaFinal2, @Formato

			IF @Formato='SinObra'
				SET @IdObra=0
			ELSE
				SET @IdObra=0

			SET @Importe1=IsNull((Select Top 1 IsNull(SaldoInicial,0) From #Auxiliar11),0) * @Coeficiente
			SET @Importe2=IsNull((Select Top 1 IsNull(SaldoInicial,0)+IsNull(Saldo,0) From #Auxiliar11),0) * @Coeficiente

			SET @IdEjercicioContable=IsNull((Select Top 1 IdEjercicioContable From EjerciciosContables Where Convert(datetime,'01/' + Convert(varchar,@Mes) + '/' + Convert(varchar,@Año)) between FechaInicio and FechaFinalizacion),0)
			SET @Presupuesto=IsNull((Select 
									 Case When @Mes=1  Then Sum(IsNull(PresupuestoTeoricoMes01,0)) When @Mes=2  Then Sum(IsNull(PresupuestoTeoricoMes02,0)) When @Mes=3  Then Sum(IsNull(PresupuestoTeoricoMes03,0))
										When @Mes=4  Then Sum(IsNull(PresupuestoTeoricoMes04,0)) When @Mes=5  Then Sum(IsNull(PresupuestoTeoricoMes05,0)) When @Mes=6  Then Sum(IsNull(PresupuestoTeoricoMes06,0))
										When @Mes=7  Then Sum(IsNull(PresupuestoTeoricoMes07,0)) When @Mes=8  Then Sum(IsNull(PresupuestoTeoricoMes08,0)) When @Mes=9  Then Sum(IsNull(PresupuestoTeoricoMes09,0))
										When @Mes=10 Then Sum(IsNull(PresupuestoTeoricoMes10,0)) When @Mes=11 Then Sum(IsNull(PresupuestoTeoricoMes11,0)) When @Mes=12 Then Sum(IsNull(PresupuestoTeoricoMes12,0))
										Else 0
									 End
									 From CuentasEjerciciosContables Where IdCuenta=@IdCuenta and IdEjercicioContable=@IdEjercicioContable),0)

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, @Importe1, @Importe2, 0, 0, 0, @Presupuesto)
			ELSE
				UPDATE #Auxiliar20
				SET ImporteCuentasInicial=IsNull(ImporteCuentasInicial,0)+@Importe1, ImporteCuentasFinal=IsNull(ImporteCuentasFinal,0)+@Importe2
				WHERE IdAux=@IdAux
		  END

		IF @IdRubroContable>0
		  BEGIN
			IF @Formato='SinObra'
				SET @IdObra=0
			ELSE
				SET @IdObra=IsNull((Select Top 1 IdObra From RubrosContables Where IdRubroContable=@IdRubroContable),0)

			SET @Importe1=IsNull((Select Sum(IsNull(Importe,0)) From #Auxiliar10 Where IdRubroContable=@IdRubroContable and Year(Fecha)=@Año and Month(Fecha)=@Mes),0) * @Coeficiente * -1
			SET @Presupuesto=IsNull((Select Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0)) From PresupuestoFinanciero Where IdRubroContable=@IdRubroContable and Año=@Año and Mes=@Mes and IsNull(Tipo,'M')='A'),0)

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, @Importe1, 0, 0, @Presupuesto)
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

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, 0, @Importe1, @Importe2, 0)
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

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, 0, @Importe1, @Importe2, 0)
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

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, 0, @Importe1, @Importe2, 0)
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

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, 0, @Importe1, @Importe2, 0)
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

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, 0, @Importe1, @Importe2, 0)
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

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, 0, @Importe1, @Importe2, 0)
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

			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar20 Where Codigo=@Codigo and Año=@Año and Mes=@Mes and IdObra=@IdObra),0)
			IF @IdAux=0 
				INSERT INTO #Auxiliar20
				(Codigo, IdObra, Año, Mes, ImporteCuentasInicial, ImporteCuentasFinal, ImporteRubros, ImporteOtrosConceptosInicial, ImporteOtrosConceptosFinal, ImportePresupuestado)
				VALUES 
				(@Codigo, @IdObra, @Año, @Mes, 0, 0, 0, @Importe1, @Importe2, 0)
			ELSE
				UPDATE #Auxiliar20
				SET ImporteOtrosConceptosInicial=IsNull(ImporteOtrosConceptosInicial,0)+@Importe1, ImporteOtrosConceptosFinal=IsNull(ImporteOtrosConceptosFinal,0)+@Importe2
				WHERE IdAux=@IdAux
		  END

		SET @Mes=@Mes+1
	  END

	FETCH NEXT FROM Cur INTO @IdDetalleDefinicionFlujoCaja
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT * 
FROM #Auxiliar20 
ORDER BY Codigo, IdObra, Año, Mes

DROP TABLE #Auxiliar100
DROP TABLE #Auxiliar20
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13
DROP TABLE #Auxiliar14
DROP TABLE #Auxiliar15