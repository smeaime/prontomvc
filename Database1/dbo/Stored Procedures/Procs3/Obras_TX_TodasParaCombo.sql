
CREATE Procedure [dbo].[Obras_TX_TodasParaCombo]

@ParaPresupuesto varchar(2) = Null

AS 

SET @ParaPresupuesto=IsNull(@ParaPresupuesto,'')

SELECT IdObra, NumeroObra as Titulo
FROM Obras
WHERE @ParaPresupuesto='' or @ParaPresupuesto=IsNull(ActivarPresupuestoObra,'NO')
ORDER BY NumeroObra
