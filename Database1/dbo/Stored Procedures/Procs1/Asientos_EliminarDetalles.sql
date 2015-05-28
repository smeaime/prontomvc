
CREATE PROCEDURE [dbo].[Asientos_EliminarDetalles]

@IdAsiento int

AS

DELETE FROM DetalleAsientos
WHERE IdAsiento=@IdAsiento
