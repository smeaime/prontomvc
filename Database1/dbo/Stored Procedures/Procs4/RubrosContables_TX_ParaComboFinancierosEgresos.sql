CREATE Procedure [dbo].[RubrosContables_TX_ParaComboFinancierosEgresos]

@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

DECLARE @IdObraParaRubrosFinancierosAdicionales int

SET @IdObraParaRubrosFinancierosAdicionales=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdObraParaRubrosFinancierosAdicionales'),-1)

SELECT 
 RubrosContables.IdRubroContable,
 RubrosContables.Descripcion as [Titulo]
FROM RubrosContables 
WHERE RubrosContables.Financiero is not null and RubrosContables.Financiero='SI' and IngresoEgreso='E' and 
	(@IdObra=-1 or RubrosContables.IdObra=@IdObra or RubrosContables.IdObra=@IdObraParaRubrosFinancierosAdicionales)
ORDER BY RubrosContables.Descripcion