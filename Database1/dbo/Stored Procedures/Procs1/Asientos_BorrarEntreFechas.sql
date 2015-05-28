







CREATE PROCEDURE [dbo].[Asientos_BorrarEntreFechas]

@Desde datetime,
@Hasta datetime

AS

DELETE FROM DetalleAsientos
WHERE 
	(Select Asientos.IdCuentaSubdiario From Asientos
	 Where Asientos.IdAsiento = DetalleAsientos.IdAsiento) Is Not Null And 
	(Select Asientos.FechaAsiento From Asientos
	 Where Asientos.IdAsiento = DetalleAsientos.IdAsiento) between @Desde and @hasta

DELETE FROM Asientos
WHERE (Asientos.FechaAsiento between @Desde and @hasta) And 
	 IdCuentaSubdiario is Not Null







