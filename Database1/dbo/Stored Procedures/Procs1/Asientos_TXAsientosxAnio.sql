


































CREATE PROCEDURE [dbo].[Asientos_TXAsientosxAnio]
@Anio int
AS
SELECT 
		Asientos.IdAsiento, 
		Asientos.NumeroAsiento AS [Numero], 
		Asientos.FechaAsiento AS [FechaAsiento]
FROM Asientos 
where YEAR(Asientos.FechaAsiento)=@anio
ORDER BY Asientos.NumeroAsiento


































