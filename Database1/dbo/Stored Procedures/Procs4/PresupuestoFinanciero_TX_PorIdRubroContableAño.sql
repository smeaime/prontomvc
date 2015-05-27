




CREATE Procedure [dbo].[PresupuestoFinanciero_TX_PorIdRubroContableAño]
@IdRubroContable int,
@Año int,
@Tipo varchar(1)
AS 
SELECT *
FROM PresupuestoFinanciero
WHERE IdRubroContable=@IdRubroContable and Año=@Año and IsNull(Tipo,'M')=@Tipo




