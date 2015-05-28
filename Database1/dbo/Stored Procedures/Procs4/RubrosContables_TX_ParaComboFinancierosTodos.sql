CREATE Procedure [dbo].[RubrosContables_TX_ParaComboFinancierosTodos]

@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

SELECT 
 RubrosContables.IdRubroContable,
 RubrosContables.Descripcion as [Titulo]
FROM RubrosContables 
WHERE RubrosContables.Financiero is not null and RubrosContables.Financiero='SI'  and (@IdObra=-1 or RubrosContables.IdObra=@IdObra)
ORDER BY RubrosContables.IngresoEgreso Desc, RubrosContables.Descripcion