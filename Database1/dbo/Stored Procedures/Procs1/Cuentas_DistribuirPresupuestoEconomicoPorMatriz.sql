


CREATE Procedure [dbo].[Cuentas_DistribuirPresupuestoEconomicoPorMatriz]

@IdCuenta int, 
@IdDistribucionObra int,
@IdEjercicioContable int

As

Declare @PT_Mes01 numeric(18,2),@PT_Mes02 numeric(18,2),@PT_Mes03 numeric(18,2),
	@PT_Mes04 numeric(18,2),@PT_Mes05 numeric(18,2),@PT_Mes06 numeric(18,2),
	@PT_Mes07 numeric(18,2),@PT_Mes08 numeric(18,2),@PT_Mes09 numeric(18,2),
	@PT_Mes10 numeric(18,2),@PT_Mes11 numeric(18,2),@PT_Mes12 numeric(18,2)

Set @PT_Mes01=IsNull((Select Top 1 cec.PresupuestoTeoricoMes01
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes02=IsNull((Select Top 1 cec.PresupuestoTeoricoMes02
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes03=IsNull((Select Top 1 cec.PresupuestoTeoricoMes03
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes04=IsNull((Select Top 1 cec.PresupuestoTeoricoMes04
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes05=IsNull((Select Top 1 cec.PresupuestoTeoricoMes05
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes06=IsNull((Select Top 1 cec.PresupuestoTeoricoMes06
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes07=IsNull((Select Top 1 cec.PresupuestoTeoricoMes07
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes08=IsNull((Select Top 1 cec.PresupuestoTeoricoMes08
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes09=IsNull((Select Top 1 cec.PresupuestoTeoricoMes09
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes10=IsNull((Select Top 1 cec.PresupuestoTeoricoMes10
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes11=IsNull((Select Top 1 cec.PresupuestoTeoricoMes11
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)
Set @PT_Mes12=IsNull((Select Top 1 cec.PresupuestoTeoricoMes12
			From CuentasEjerciciosContables cec 
			Where cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable),0)

Declare @IdCuentaGasto int
Set @IdCuentaGasto=IsNull((Select Top 1 Cuentas.IdCuentaGasto
				From Cuentas Where Cuentas.IdCuenta=@IdCuenta),0)

CREATE TABLE #Auxiliar1 
			(
			 IdObra INTEGER,
			 Porcentaje NUMERIC(6,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Det.IdObra,
  IsNull(Det.Porcentaje,0)
 FROM DetalleDistribucionesObras Det
 WHERE Det.IdDistribucionObra=@IdDistribucionObra

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdObra) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdObra int, @Porcentaje numeric(6,2), @IdCuentaEjercicioContable int, @IdCuenta1 int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR
		SELECT IdObra, Porcentaje
		FROM #Auxiliar1
		ORDER BY IdObra
OPEN Cur
FETCH NEXT FROM Cur
	INTO @IdObra, @Porcentaje

WHILE @@FETCH_STATUS = 0
   BEGIN
	Set @IdCuentaEjercicioContable=IsNull((Select Top 1 cec.IdCuentaEjercicioContable
						From CuentasEjerciciosContables cec
						Left Outer Join Cuentas On cec.IdCuenta=Cuentas.IdCuenta
						Where cec.IdEjercicioContable=@IdEjercicioContable and 
							Cuentas.IdObra=@IdObra and 
							Cuentas.IdCuentaGasto=@IdCuentaGasto),0)
	If @IdCuentaEjercicioContable=0
	   BEGIN
		Set @IdCuenta1=IsNull((Select Top 1 Cuentas.IdCuenta 
					From Cuentas
					Where IsNull(Cuentas.IdObra,0)=@IdObra and 
						IsNull(Cuentas.IdCuentaGasto,0)=@IdCuentaGasto),0)
		Insert into [CuentasEjerciciosContables]
			(IdCuenta,IdEjercicioContable,PresupuestoTeoricoMes01,PresupuestoTeoricoMes02,
			 PresupuestoTeoricoMes03,PresupuestoTeoricoMes04,PresupuestoTeoricoMes05,
			 PresupuestoTeoricoMes06,PresupuestoTeoricoMes07,PresupuestoTeoricoMes08,
			 PresupuestoTeoricoMes09,PresupuestoTeoricoMes10,PresupuestoTeoricoMes11,
			 PresupuestoTeoricoMes12)
		Values	(@IdCuenta1,@IdEjercicioContable,Null,Null,Null,Null,Null,Null,Null,Null,
			 Null,Null,Null,Null)
		Set @IdCuentaEjercicioContable=@@identity
	   End
	Update CuentasEjerciciosContables
	Set 
		PresupuestoTeoricoMes01=Round(@PT_Mes01 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes02=Round(@PT_Mes02 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes03=Round(@PT_Mes03 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes04=Round(@PT_Mes04 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes05=Round(@PT_Mes05 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes06=Round(@PT_Mes06 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes07=Round(@PT_Mes07 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes08=Round(@PT_Mes08 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes09=Round(@PT_Mes09 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes10=Round(@PT_Mes10 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes11=Round(@PT_Mes11 * @Porcentaje / 100,2),
		PresupuestoTeoricoMes12=Round(@PT_Mes12 * @Porcentaje / 100,2)
	Where IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	FETCH NEXT FROM Cur
		INTO @IdObra, @Porcentaje
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1


