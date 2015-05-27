
CREATE Procedure [dbo].[DetRequerimientos_TX_SetearComoTransmitido]

@IdObra int = Null

AS

SET NOCOUNT ON

IF @IdObra is null 
	SET @IdObra=-1

SET NOCOUNT OFF

UPDATE DetalleRequerimientos
SET EnviarEmail=0
WHERE EnviarEmail<>0 and 
	(@IdObra<=0 or IsNull((Select R.IdObra From Requerimientos R 
				Where R.IdRequerimiento=DetalleRequerimientos.IdRequerimiento),-1)=@IdObra)

