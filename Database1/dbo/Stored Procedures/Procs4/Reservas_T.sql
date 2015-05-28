





























CREATE Procedure [dbo].[Reservas_T]
@IdReserva int
AS 
SELECT * 
FROM Reservas
WHERE (IdReserva=@IdReserva)






























