




CREATE Procedure [dbo].[PresupuestoFinanciero_TX_PorAño]
AS 
SELECT 
 Año
FROM PresupuestoFinanciero
GROUP BY Año
ORDER BY Año desc




