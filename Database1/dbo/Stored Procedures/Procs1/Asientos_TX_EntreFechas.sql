




CREATE PROCEDURE [dbo].[Asientos_TX_EntreFechas]
@Desde datetime,
@Hasta datetime
AS
SELECT *
FROM Asientos
WHERE FechaAsiento between @Desde and @hasta
ORDER BY FechaAsiento, Substring(IsNull(Tipo,'BBBBB'),1,3), 
	Substring(IsNull(Tipo,'BBBBB'),4,2), NumeroAsiento




