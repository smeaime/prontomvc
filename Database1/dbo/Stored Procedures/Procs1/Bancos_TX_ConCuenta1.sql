












CREATE Procedure [dbo].[Bancos_TX_ConCuenta1]
AS 
SELECT IdBanco,Nombre as Titulo
FROM Bancos 
WHERE IdCuenta is not null 
ORDER by Nombre














