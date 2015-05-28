CREATE PROCEDURE [dbo].[wBancos_TX_PosicionFinancieraAFecha]

@FechaPosicion datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar20 (IdMoneda INTEGER)
INSERT INTO #Auxiliar20 
 SELECT DISTINCT CuentasBancarias.IdMoneda FROM CuentasBancarias 
UNION ALL 
 SELECT DISTINCT Cajas.IdMoneda FROM Cajas 
UNION ALL 
 SELECT DISTINCT PlazosFijos.IdMoneda FROM PlazosFijos 

CREATE TABLE #Auxiliar21 (IdMoneda INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar21 ON #Auxiliar21 (IdMoneda) ON [PRIMARY]
INSERT INTO #Auxiliar21 
 SELECT IdMoneda FROM #Auxiliar20 GROUP BY IdMoneda ORDER BY IdMoneda


CREATE TABLE #Auxiliar30 
			(
			 MonedaDescripcion VARCHAR(50),
			 EntidadCodigo VARCHAR(15),
			 EntidadNombre VARCHAR(50),
			 CuentaCodigo INTEGER,
			 CuentaBancariaCuenta VARCHAR(50),
			 SaldosContableDiaAnterior NUMERIC(18, 2),
			 IngresosDelDia NUMERIC(18, 2),
			 EgresosDelDia NUMERIC(18, 2),
			 ChequesPosdatadosAnt NUMERIC(18, 2),
			 ChequesPosdatadosDia NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasDelDia NUMERIC(18, 2),
			 AportesDelDia NUMERIC(18, 2),
			 GastosBancariosDelDia NUMERIC(18, 2),
			 SaldosContableAFecha NUMERIC(18, 2),
			 SaldosTotal NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar31 
			(
			 IdCuentaBancaria INTEGER,
			 CuentaBancariaDetalle VARCHAR(50),
			 CuentaBancariaCuenta VARCHAR(50),
			 BancoNombre VARCHAR(50),
			 MonedaDescripcion VARCHAR(50),
			 ProvinciaNombre VARCHAR(50),
			 CuentaCodigo INTEGER,
			 DepositosPendientes NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasPendientes NUMERIC(18, 2),
			 ChequesPropiosAFecha NUMERIC(18, 2),
			 ChequesPropiosHastaViernesProximo NUMERIC(18, 2),
			 ChequesPropiosPosterioresAlViernesProximo NUMERIC(18, 2),
			 SaldosContableAFecha NUMERIC(18, 2),
			 DepositosDelDia NUMERIC(18, 2),
			 ChequesPropiosDelDia NUMERIC(18, 2),
			 GastosBancariosDelDia NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasDelDia NUMERIC(18, 2),
			 AportesDelDia NUMERIC(18, 2),
			 ChequesPosdatadosAnt NUMERIC(18, 2),
			 ChequesPosdatadosDia NUMERIC(18, 2),
			 SaldosContableDiaAnterior NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar32 
			(
			 IdCaja INTEGER,
			 IdCuenta INTEGER,
			 CajaNombre VARCHAR(50),
			 MonedaDescripcion VARCHAR(50),
			 CuentaCodigo INTEGER,
			 Saldo NUMERIC(18, 2),
			 SaldosAnterior NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar32 ON #Auxiliar32 (IdCaja) ON [PRIMARY]

CREATE TABLE #Auxiliar33 
			(
			 IdPlazoFijo INTEGER,
			 BancoNombre VARCHAR(50),
			 NumeroCertificado1 INTEGER,
			 DireccionEmisionYPago VARCHAR(50),
			 Titulares VARCHAR(50),
			 CodigoDeposito INTEGER,
			 CodigoClase INTEGER,
			 PlazoEnDias INTEGER,
			 TasaNominalAnual NUMERIC(18, 3),
			 Importe NUMERIC(18, 2),
			 TasaEfectivaMensual NUMERIC(18, 3),
			 FechaVencimiento DATETIME,
			 ImporteIntereses NUMERIC(18, 2),
			 RetencionGanancia NUMERIC(18, 2),
			 Orden VARCHAR(50),
			 Detalle VARCHAR(50),
			 IdPlazoFijoOrigen INTEGER,
			 FechaInicioPlazoFijo DATETIME,
			 MonedaDescripcion VARCHAR(50),
			 CotizacionMonedaAlInicio NUMERIC(18, 4),
			 CotizacionMonedaAlFinal NUMERIC(18, 4),
			 Finalizado VARCHAR(2)
			)

CREATE TABLE #Auxiliar34 
			(
			 Debe1 NUMERIC(18, 2),
			 Haber1 NUMERIC(18, 2),
			 Saldo1 NUMERIC(18, 2),
			 Debe2 NUMERIC(18, 2),
			 Haber2 NUMERIC(18, 2),
			 Saldo2 NUMERIC(18, 2)
			)

DECLARE @IdMoneda int, @Moneda varchar(50), @IdCaja int, @IdCuenta int, @CajaNombre varchar(50), @MonedaDescripcion varchar(50), @CuentaCodigo int, 
		@Saldo numeric(18,2), @SaldosAnterior numeric(18,2), @IngresoDia numeric(18,2), @EgresoDia numeric(18,2), @SaldoFinal numeric(18,2), @IdCuentaValores int

SET @IdCuentaValores=IsNull((Select Top 1 IdCuentaValores From Parametros Where IdParametro=1),0)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdMoneda FROM #Auxiliar21 ORDER BY IdMoneda
OPEN Cur
FETCH NEXT FROM Cur INTO @IdMoneda
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @Moneda=IsNull((Select Top 1 Nombre From Monedas Where IdMoneda=@IdMoneda),'')

	TRUNCATE TABLE #Auxiliar31
	INSERT INTO #Auxiliar31 EXEC Bancos_TX_PosicionFinancieraAFecha @FechaPosicion, 0, @IdMoneda

	TRUNCATE TABLE #Auxiliar32
	INSERT INTO #Auxiliar32 EXEC Cajas_TX_PosicionFinancieraAFecha @FechaPosicion, @IdMoneda, 'SI'

	TRUNCATE TABLE #Auxiliar33
	INSERT INTO #Auxiliar33 EXEC PlazosFijos_TX_ParaPosicionFinancieraAFecha @FechaPosicion, @IdMoneda

	INSERT INTO #Auxiliar30 
	 SELECT MonedaDescripcion, 'BANCOS', BancoNombre, CuentaCodigo, CuentaBancariaCuenta, SaldosContableDiaAnterior, DepositosDelDia, ChequesPropiosDelDia, 
			ChequesPosdatadosAnt, ChequesPosdatadosDia, TransferenciasEntreCuentasPropiasDelDia, AportesDelDia, GastosBancariosDelDia, SaldosContableAFecha, 0
	 FROM #Auxiliar31

	DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdCaja, IdCuenta, CajaNombre, MonedaDescripcion, CuentaCodigo, Saldo, SaldosAnterior FROM #Auxiliar32 ORDER BY IdCaja
	OPEN Cur1
	FETCH NEXT FROM Cur1 INTO @IdCaja, @IdCuenta, @CajaNombre, @MonedaDescripcion, @CuentaCodigo, @Saldo, @SaldosAnterior
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		IF @IdCaja>0
		  BEGIN
			TRUNCATE TABLE #Auxiliar34
			INSERT INTO #Auxiliar34 EXEC Cajas_TX_PosicionFinancieraAFechaPorIdCaja @IdCaja, @FechaPosicion
			SET @IngresoDia=IsNull((Select Top 1 IsNull(Debe2,0) From #Auxiliar34),0)
			SET @EgresoDia=IsNull((Select Top 1 IsNull(Haber2,0) From #Auxiliar34),0)
			SET @SaldoFinal=@Saldo
		  END
		IF @IdCaja<0
		  BEGIN
			TRUNCATE TABLE #Auxiliar34
			INSERT INTO #Auxiliar34 EXEC Cuentas_TX_MayorPorIdCuentaEntreFechas @IdCuenta, @FechaPosicion, @FechaPosicion
			SET @IngresoDia=IsNull((Select Top 1 IsNull(Debe1,0) From #Auxiliar34),0)
			SET @EgresoDia=IsNull((Select Top 1 IsNull(Haber1,0) From #Auxiliar34),0)
			SET @SaldoFinal=IsNull((Select Top 1 IsNull(Saldo1,0)+IsNull(Saldo2,0) From #Auxiliar34),0)
		  END
		IF @IdCaja=0
		  BEGIN
			TRUNCATE TABLE #Auxiliar34
			INSERT INTO #Auxiliar34 EXEC Cuentas_TX_MayorPorIdCuentaEntreFechas @IdCuentaValores, @FechaPosicion, @FechaPosicion
			SET @IngresoDia=IsNull((Select Top 1 IsNull(Debe1,0) From #Auxiliar34),0)
			SET @EgresoDia=IsNull((Select Top 1 IsNull(Haber1,0) From #Auxiliar34),0)
			SET @SaldoFinal=IsNull((Select Top 1 IsNull(Saldo1,0)+IsNull(Saldo2,0) From #Auxiliar34),0)
		  END

		INSERT INTO #Auxiliar30 
		(MonedaDescripcion, EntidadCodigo, EntidadNombre, CuentaCodigo, SaldosContableDiaAnterior, IngresosDelDia, EgresosDelDia, SaldosContableAFecha)
		VALUES
		(@MonedaDescripcion, 'CAJAS', @CajaNombre, @CuentaCodigo, @SaldosAnterior, @IngresoDia, @EgresoDia, @SaldoFinal)

		FETCH NEXT FROM Cur1 INTO @IdCaja, @IdCuenta, @CajaNombre, @MonedaDescripcion, @CuentaCodigo, @Saldo, @SaldosAnterior
	  END
	CLOSE Cur1
	DEALLOCATE Cur1

	INSERT INTO #Auxiliar30 
	 SELECT MonedaDescripcion, 'INVERSIONES', BancoNombre, Null, Convert(varchar,NumeroCertificado1), IsNull(Importe,0)+IsNull(ImporteIntereses,0)-IsNull(RetencionGanancia,0), 
			Null, Null, Null, Null, Null, Null, Null, IsNull(Importe,0)+IsNull(ImporteIntereses,0)-IsNull(RetencionGanancia,0), 0
	 FROM #Auxiliar33

	FETCH NEXT FROM Cur INTO @IdMoneda
  END
CLOSE Cur
DEALLOCATE Cur

UPDATE #Auxiliar30
SET SaldosTotal=IsNull(SaldosContableDiaAnterior,0)+IsNull(IngresosDelDia,0)+IsNull(EgresosDelDia,0)+IsNull(ChequesPosdatadosDia,0)+
				IsNull(TransferenciasEntreCuentasPropiasDelDia,0)+IsNull(AportesDelDia,0)+IsNull(GastosBancariosDelDia,0)

SET NOCOUNT OFF

SELECT * FROM #Auxiliar30

DROP TABLE #Auxiliar20
DROP TABLE #Auxiliar21
DROP TABLE #Auxiliar30
DROP TABLE #Auxiliar31
DROP TABLE #Auxiliar32
DROP TABLE #Auxiliar33
DROP TABLE #Auxiliar34