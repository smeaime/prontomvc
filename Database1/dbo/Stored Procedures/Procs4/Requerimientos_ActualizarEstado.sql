CREATE PROCEDURE [dbo].[Requerimientos_ActualizarEstado]

@IdRequerimiento int,
@IdDetalleRequerimiento int

AS

IF @IdDetalleRequerimiento>0
	SET @IdRequerimiento=IsNull((Select Top 1 DetReq.IdRequerimiento From DetalleRequerimientos DetReq Where DetReq.IdDetalleRequerimiento=@IdDetalleRequerimiento),0)

UPDATE Requerimientos
SET Cumplido=Null
WHERE Requerimientos.IdRequerimiento=@IdRequerimiento  

UPDATE Requerimientos
SET Cumplido='SI'
WHERE Requerimientos.IdRequerimiento=@IdRequerimiento and 
	not exists(Select Top 1 DetReq.IdRequerimiento
			From DetalleRequerimientos DetReq
			Where DetReq.IdRequerimiento=@IdRequerimiento and (IsNull(DetReq.Cumplido,'NO')='NO' or IsNull(DetReq.Cumplido,'NO')='PA'))
UPDATE Requerimientos
SET Cumplido='AN'
WHERE Requerimientos.IdRequerimiento=@IdRequerimiento and 
	not exists(Select Top 1 DetReq.IdRequerimiento
			From DetalleRequerimientos DetReq
			Where DetReq.IdRequerimiento=@IdRequerimiento and IsNull(DetReq.Cumplido,'NO')<>'AN')