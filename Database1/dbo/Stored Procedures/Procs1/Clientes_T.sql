﻿
































CREATE Procedure [dbo].[Clientes_T]
@IdCliente int
AS 
SELECT * 
FROM Clientes
WHERE (IdCliente=@IdCliente)

































