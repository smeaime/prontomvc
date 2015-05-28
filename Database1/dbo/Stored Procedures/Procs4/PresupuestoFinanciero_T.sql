






CREATE Procedure [dbo].[PresupuestoFinanciero_T]
@IdPresupuestoFinanciero int
AS 
SELECT *
FROM PresupuestoFinanciero
WHERE IdPresupuestoFinanciero=@IdPresupuestoFinanciero






