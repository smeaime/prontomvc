




CREATE Procedure [dbo].[PresupuestoFinanciero_TX_PorIdRubroContable]
@IdRubroContable int
AS 
SELECT *
FROM PresupuestoFinanciero
WHERE IdRubroContable=@IdRubroContable




