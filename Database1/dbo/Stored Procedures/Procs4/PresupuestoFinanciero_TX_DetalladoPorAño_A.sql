


CREATE Procedure [dbo].[PresupuestoFinanciero_TX_DetalladoPorAño_A]
@Año int
AS 
SELECT 
 Convert(varchar,@Año)+Convert(varchar,IdRubroContable) as [IdAux],
 Obras.NumeroObra as [Obra],
 RubrosContables.Codigo as [Codigo],
 RubrosContables.Descripcion as [Rubro Contable],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=1) as [Enero],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=2) as [Febrero],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=3) as [Marzo],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=4) as [Abril],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=5) as [Mayo],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=6) as [Junio],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=7) as [Julio],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=8) as [Agosto],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=9) as [Setiembre],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=10) as [Octubre],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=11) as [Noviembre],
 (Select Sum(IsNull(PF.PresupuestoIngresos,0)+IsNull(PF.PresupuestoEgresos,0))
  From PresupuestoFinanciero PF 
  Where IsNull(PF.Tipo,'M')='A' and PF.IdRubroContable=RubrosContables.IdRubroContable and 
	PF.Año=@Año and PF.Mes=12) as [Diciembre]
FROM RubrosContables 
LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
WHERE Financiero is not null and Financiero='SI'
ORDER by RubrosContables.Descripcion


