
CREATE PROCEDURE [dbo].[DetRequerimientos_TX_ParaTransmitir]

@IdObra int = Null,
@NumeroRequerimiento int = Null,
@NumeroItem int = Null

AS

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @NumeroRequerimiento=IsNull(@NumeroRequerimiento,-1)
SET @NumeroItem=IsNull(@NumeroItem,-1)

SET NOCOUNT OFF

SELECT Det.* 
FROM DetalleRequerimientos Det
LEFT OUTER JOIN Requerimientos ON Det.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE Det.EnviarEmail=1 and (@IdObra<=0 or IsNull(Requerimientos.IdObra,-1)=@IdObra) and 
	(@NumeroRequerimiento<=0 or (Requerimientos.NumeroRequerimiento=@NumeroRequerimiento and Det.NumeroItem=@NumeroItem))
