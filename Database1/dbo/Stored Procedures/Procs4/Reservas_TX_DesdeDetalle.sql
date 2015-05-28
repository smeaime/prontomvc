





























CREATE  Procedure [dbo].[Reservas_TX_DesdeDetalle]
@IdDetalleReserva int
AS 
SELECT 
	Reservas.IdReserva,
	Reservas.NumeroReserva
FROM DetalleReservas
LEFT OUTER JOIN Reservas ON DetalleReservas.IdReserva = Reservas.IdReserva
WHERE (DetalleReservas.IdDetalleReserva=@IdDetalleReserva)






























