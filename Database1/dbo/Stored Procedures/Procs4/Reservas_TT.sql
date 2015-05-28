





























CREATE  Procedure [dbo].[Reservas_TT]
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
ORDER BY NumeroReserva






























