CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_PorItem]

@Item varchar(20),
@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

SELECT *
FROM PresupuestoObrasNodos 
WHERE (@IdObra=-1 or IdObra=@IdObra) and IsNull(Item,'')=@Item