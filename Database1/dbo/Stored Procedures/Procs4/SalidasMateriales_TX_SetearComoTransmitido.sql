
CREATE Procedure [dbo].[SalidasMateriales_TX_SetearComoTransmitido]

@IdObra int = Null

AS

SET NOCOUNT ON

IF @IdObra is null 
	SET @IdObra=-1

SET NOCOUNT OFF

UPDATE DetalleSalidasMateriales
SET EnviarEmail=0
WHERE IsNull(EnviarEmail,1)<>0 and (@IdObra<=0 or IsNull(IdObra,-1)=@IdObra)
