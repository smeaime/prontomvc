﻿































CREATE  Procedure [dbo].[Acopios_TXTLObra]
@IdObra int
AS 
SELECT IdAcopio,NumeroAcopio as Titulo
FROM Acopios
WHERE (IdObra=@IdObra)
































