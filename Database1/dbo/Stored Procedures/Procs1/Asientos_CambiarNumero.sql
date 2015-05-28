





CREATE PROCEDURE [dbo].[Asientos_CambiarNumero]

@IdAsiento int,
@NumeroNuevo int

AS

UPDATE Asientos
SET NumeroAsiento=@NumeroNuevo
WHERE IdAsiento=@IdAsiento

UPDATE Valores
SET NumeroComprobante=(Select Top 1 Asientos.NumeroAsiento
			From DetalleAsientos
			Left Outer Join Asientos On Asientos.IdAsiento=DetalleAsientos.IdAsiento
			Where DetalleAsientos.IdDetalleAsiento=Valores.IdDetalleAsiento)
WHERE Valores.IdDetalleAsiento is not null and 
	(Select Top 1 DetalleAsientos.IdAsiento
	 From DetalleAsientos
	 Where DetalleAsientos.IdDetalleAsiento=Valores.IdDetalleAsiento)=@IdAsiento





