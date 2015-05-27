
CREATE PROCEDURE [dbo].[Asientos_Eliminar]

@IdAsiento int

AS

DELETE FROM Valores
WHERE Valores.IdDetalleAsiento is not null and
	(Select Top 1 DetalleAsientos.IdAsiento
	 From DetalleAsientos
	 Where DetalleAsientos.IdDetalleAsiento=Valores.IdDetalleAsiento)=@IdAsiento

DELETE FROM DetalleAsientos
WHERE DetalleAsientos.IdAsiento=@IdAsiento

DELETE FROM Asientos
WHERE Asientos.IdAsiento=@IdAsiento
