CREATE Procedure [dbo].[Requerimientos_ActualizarCumplido]

@IdDetalleRequerimiento int

AS

DECLARE @IdRequerimiento int

SET @IdRequerimiento=IsNull((Select Top 1 IdRequerimiento From DetalleRequerimientos Where IdDetalleRequerimiento=@IdDetalleRequerimiento),0)

UPDATE DetalleRequerimientos
SET Cumplido=Null
WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento

UPDATE Requerimientos
SET Cumplido=Null
WHERE Requerimientos.IdRequerimiento=@IdRequerimiento