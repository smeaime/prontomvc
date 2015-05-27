CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_PorCodigoPresupuesto]

@IdObra int = Null,
@NumeroPresupuesto int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)
SET @NumeroPresupuesto=IsNull(@NumeroPresupuesto,-1)

SELECT DISTINCT P.NumeroPresupuesto as [CodigoPresupuesto]
FROM PresupuestoObrasNodosPresupuestos P
 LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
WHERE (@IdObra=-1 or P.IdObra=@IdObra) and IsNull(O.ActivarPresupuestoObra,'NO')='SI' and (@NumeroPresupuesto=-1 or P.NumeroPresupuesto=@NumeroPresupuesto)
ORDER BY P.NumeroPresupuesto