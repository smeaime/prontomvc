﻿


































CREATE Procedure [dbo].[Asientos_TXCod]
@NroAju int
As
SELECT IdAsiento, FechaAsiento,NumeroAsiento
FROM Asientos
WHERE (NumeroAsiento = @NroAju)


































