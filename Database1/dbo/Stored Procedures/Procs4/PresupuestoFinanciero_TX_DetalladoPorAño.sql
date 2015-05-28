




CREATE Procedure [dbo].[PresupuestoFinanciero_TX_DetalladoPorAño]
@Año int
AS 
SELECT 
 Convert(varchar,@Año)+Convert(varchar,IdRubroContable) as [IdAux],
 Obras.NumeroObra as [Obra],
 RubrosContables.Codigo as [Codigo],
 RubrosContables.Descripcion as [Rubro Contable]
FROM RubrosContables 
LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
WHERE Financiero is not null and Financiero='SI'
ORDER by RubrosContables.Descripcion




