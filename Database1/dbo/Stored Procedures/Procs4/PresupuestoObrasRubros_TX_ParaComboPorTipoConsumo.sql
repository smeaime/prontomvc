
CREATE Procedure [dbo].[PresupuestoObrasRubros_TX_ParaComboPorTipoConsumo]

@TipoConsumo int = Null

AS 

SET @TipoConsumo=IsNull(@TipoConsumo,3)

SELECT 
 IdPresupuestoObraRubro,
 Descripcion as [Titulo]
FROM PresupuestoObrasRubros
WHERE @TipoConsumo=3 or TipoConsumo=3 or TipoConsumo=@TipoConsumo
ORDER BY Descripcion
