CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_PorNodoPadre]

@IdNodoPadre int,
@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

SELECT pon.*
FROM PresupuestoObrasNodos pon
WHERE (@IdObra=-1 or IdObra=@IdObra) and IsNull(pon.idNodoPadre,0)=@IdNodoPadre
ORDER BY pon.TipoNodo, pon.Descripcion, pon.IdPresupuestoObrasNodo