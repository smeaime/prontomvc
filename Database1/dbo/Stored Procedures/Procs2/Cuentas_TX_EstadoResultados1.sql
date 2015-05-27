
CREATE Procedure [dbo].[Cuentas_TX_EstadoResultados1]

@Mes int,
@Año int

AS 

SET NOCOUNT ON

DECLARE @IdEjercicioContable int, @Proc varchar(100), @Mes1 int

IF @Mes<=0
	SET @Mes1=1
ELSE
	SET @Mes1=@Mes
SET @IdEjercicioContable=IsNull((Select Top 1 EjerciciosContables.IdEjercicioContable
				 From EjerciciosContables
				 Where Convert(datetime,'01/' + Convert(varchar,@Mes1) + '/' + 
					Convert(varchar,@Año)) between FechaInicio and FechaFinalizacion),0)

SET @Proc='Cuentas_TX_PresupuestoEconomicoParaCubo'
EXEC @Proc @IdEjercicioContable,''

CREATE TABLE #Auxiliar1 
			(
			 A_Jerarquia1 VARCHAR(60),
			 A_Jerarquia2 VARCHAR(60),
			 A_Jerarquia3 VARCHAR(60),
			 A_Jerarquia4 VARCHAR(60),
			 A_Descripcion  VARCHAR(60),
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
INSERT INTO #Auxiliar1 
 SELECT 
  Jerarquia1,
  Jerarquia2,
  Jerarquia3,
  Jerarquia4,
  Cuenta,
  SUM(IsNull(PresupuestoTeoricoMes01,0)),
  SUM(IsNull(SaldoMes01,0)),
  SUM(IsNull(PresupuestoTeoricoMes02,0)),
  SUM(IsNull(SaldoMes02,0)),
  SUM(IsNull(PresupuestoTeoricoMes03,0)),
  SUM(IsNull(SaldoMes03,0)),
  SUM(IsNull(PresupuestoTeoricoMes04,0)),
  SUM(IsNull(SaldoMes04,0)),
  SUM(IsNull(PresupuestoTeoricoMes05,0)),
  SUM(IsNull(SaldoMes05,0)),
  SUM(IsNull(PresupuestoTeoricoMes06,0)),
  SUM(IsNull(SaldoMes06,0)),
  SUM(IsNull(PresupuestoTeoricoMes07,0)),
  SUM(IsNull(SaldoMes07,0)),
  SUM(IsNull(PresupuestoTeoricoMes08,0)),
  SUM(IsNull(SaldoMes08,0)),
  SUM(IsNull(PresupuestoTeoricoMes09,0)),
  SUM(IsNull(SaldoMes09,0)),
  SUM(IsNull(PresupuestoTeoricoMes10,0)),
  SUM(IsNull(SaldoMes10,0)),
  SUM(IsNull(PresupuestoTeoricoMes11,0)),
  SUM(IsNull(SaldoMes11,0)),
  SUM(IsNull(PresupuestoTeoricoMes12,0)),
  SUM(IsNull(SaldoMes12,0))
 FROM _TempCuboPresupuestoEconomico
 GROUP BY Jerarquia1, Jerarquia2, Jerarquia3, Jerarquia4, Cuenta

SET NOCOUNT OFF

SELECT 
 A_Jerarquia1 as [Nivel1],
 A_Jerarquia2 as [Nivel2],
 A_Jerarquia3 as [Nivel3],
 A_Jerarquia4 as [Nivel4],
 A_Descripcion as [Cuenta],
 Case When @Mes=1 Then A_SaldoMes01
	When @Mes=2 Then A_SaldoMes02
	When @Mes=3 Then A_SaldoMes03
	When @Mes=4 Then A_SaldoMes04
	When @Mes=5 Then A_SaldoMes05
	When @Mes=6 Then A_SaldoMes06
	When @Mes=7 Then A_SaldoMes07
	When @Mes=8 Then A_SaldoMes08
	When @Mes=9 Then A_SaldoMes09
	When @Mes=10 Then A_SaldoMes10
	When @Mes=11 Then A_SaldoMes11
	When @Mes=12 Then A_SaldoMes12
 End as [Real],
 Case When @Mes=1 Then A_PresupuestoTeoricoMes01
	When @Mes=2 Then A_PresupuestoTeoricoMes02
	When @Mes=3 Then A_PresupuestoTeoricoMes03
	When @Mes=4 Then A_PresupuestoTeoricoMes04
	When @Mes=5 Then A_PresupuestoTeoricoMes05
	When @Mes=6 Then A_PresupuestoTeoricoMes06
	When @Mes=7 Then A_PresupuestoTeoricoMes07
	When @Mes=8 Then A_PresupuestoTeoricoMes08
	When @Mes=9 Then A_PresupuestoTeoricoMes09
	When @Mes=10 Then A_PresupuestoTeoricoMes10
	When @Mes=11 Then A_PresupuestoTeoricoMes11
	When @Mes=12 Then A_PresupuestoTeoricoMes12
 End as [Teorico],
 Case When @Mes=1 Then A_SaldoMes01
	When @Mes=2 Then A_SaldoMes01+A_SaldoMes02
	When @Mes=3 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03
	When @Mes=4 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04
	When @Mes=5 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05
	When @Mes=6 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05+A_SaldoMes06
	When @Mes=7 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05+A_SaldoMes06+A_SaldoMes07
	When @Mes=8 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05+A_SaldoMes06+A_SaldoMes07+A_SaldoMes08
	When @Mes=9 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05+A_SaldoMes06+A_SaldoMes07+A_SaldoMes08+
			A_SaldoMes09
	When @Mes=10 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05+A_SaldoMes06+A_SaldoMes07+A_SaldoMes08+
			A_SaldoMes09+A_SaldoMes10
	When @Mes=11 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05+A_SaldoMes06+A_SaldoMes07+A_SaldoMes08+
			A_SaldoMes09+A_SaldoMes10+A_SaldoMes11
	When @Mes=12 Then A_SaldoMes01+A_SaldoMes02+A_SaldoMes03+A_SaldoMes04+
			A_SaldoMes05+A_SaldoMes06+A_SaldoMes07+A_SaldoMes08+
			A_SaldoMes09+A_SaldoMes10+A_SaldoMes11+A_SaldoMes12
 End as [AcumuladoReal],
 Case When @Mes=1 Then A_PresupuestoTeoricoMes01
	When @Mes=2 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02
	When @Mes=3 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03
	When @Mes=4 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04
	When @Mes=5 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05
	When @Mes=6 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05+A_PresupuestoTeoricoMes06
	When @Mes=7 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05+A_PresupuestoTeoricoMes06+
			A_PresupuestoTeoricoMes07
	When @Mes=8 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05+A_PresupuestoTeoricoMes06+
			A_PresupuestoTeoricoMes07+A_PresupuestoTeoricoMes08
	When @Mes=9 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05+A_PresupuestoTeoricoMes06+
			A_PresupuestoTeoricoMes07+A_PresupuestoTeoricoMes08+
			A_PresupuestoTeoricoMes09
	When @Mes=10 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05+A_PresupuestoTeoricoMes06+
			A_PresupuestoTeoricoMes07+A_PresupuestoTeoricoMes08+
			A_PresupuestoTeoricoMes09+A_PresupuestoTeoricoMes10
	When @Mes=11 Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05+A_PresupuestoTeoricoMes06+
			A_PresupuestoTeoricoMes07+A_PresupuestoTeoricoMes08+
			A_PresupuestoTeoricoMes09+A_PresupuestoTeoricoMes10+
			A_PresupuestoTeoricoMes11
	When @Mes=12 or @Mes<=0 
			Then A_PresupuestoTeoricoMes01+A_PresupuestoTeoricoMes02+
			A_PresupuestoTeoricoMes03+A_PresupuestoTeoricoMes04+
			A_PresupuestoTeoricoMes05+A_PresupuestoTeoricoMes06+
			A_PresupuestoTeoricoMes07+A_PresupuestoTeoricoMes08+
			A_PresupuestoTeoricoMes09+A_PresupuestoTeoricoMes10+
			A_PresupuestoTeoricoMes11+A_PresupuestoTeoricoMes12
 End as [AcumuladoTeorico],
 A_PresupuestoTeoricoMes01,
 A_PresupuestoTeoricoMes02,
 A_PresupuestoTeoricoMes03,
 A_PresupuestoTeoricoMes04,
 A_PresupuestoTeoricoMes05,
 A_PresupuestoTeoricoMes06,
 A_PresupuestoTeoricoMes07,
 A_PresupuestoTeoricoMes08,
 A_PresupuestoTeoricoMes09,
 A_PresupuestoTeoricoMes10,
 A_PresupuestoTeoricoMes11, A_PresupuestoTeoricoMes12,
 A_SaldoMes01,
 A_SaldoMes02,
 A_SaldoMes03,
 A_SaldoMes04,
 A_SaldoMes05,
 A_SaldoMes06,
 A_SaldoMes07,
 A_SaldoMes08,
 A_SaldoMes09,
 A_SaldoMes10,
 A_SaldoMes11,
 A_SaldoMes12
FROM #Auxiliar1
ORDER BY A_Jerarquia1, A_Jerarquia2, A_Jerarquia3, A_Jerarquia4, A_Descripcion

DROP TABLE #Auxiliar1
