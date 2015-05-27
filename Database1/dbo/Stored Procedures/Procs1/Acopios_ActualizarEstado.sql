






CREATE PROCEDURE [dbo].[Acopios_ActualizarEstado]

@IdAcopio int,
@IdDetalleAcopios int

AS

IF @IdDetalleAcopios>0
	SET @IdAcopio=IsNull((Select Top 1 DetAco.IdAcopio
				From DetalleAcopios DetAco
				Where DetAco.IdDetalleAcopios=@IdDetalleAcopios),0)

UPDATE Acopios
SET Estado=Null
WHERE Acopios.IdAcopio=@IdAcopio  

UPDATE Acopios
SET Estado='SI'
WHERE Acopios.IdAcopio=@IdAcopio and 
	not exists(Select Top 1 DetAco.IdAcopio
			From DetalleAcopios DetAco
			Where DetAco.IdAcopio=@IdAcopio and 
				(IsNull(DetAco.Cumplido,'NO')='NO' or IsNull(DetAco.Cumplido,'NO')='PA'))







