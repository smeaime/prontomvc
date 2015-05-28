





























CREATE  Procedure [dbo].[Reservas_TX_TT]
@IdReserva int
AS 
SELECT 
Reservas.IdReserva,
Reservas.NumeroReserva as [Reserva],
Case 	When Tipo='M' Then 'Manual'
	When Tipo='A' Then 'Automatica'
	Else Null
End as [Tipo de reserva],
Reservas.FechaReserva as [Fecha],
Reservas.Observaciones
FROM Reservas
WHERE (IdReserva=@IdReserva)






























