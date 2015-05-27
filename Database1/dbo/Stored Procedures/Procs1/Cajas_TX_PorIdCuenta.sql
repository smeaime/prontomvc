




CREATE Procedure [dbo].[Cajas_TX_PorIdCuenta]
@IdCuenta int
AS 
SELECT *
FROM Cajas
WHERE (IdCuenta=@IdCuenta)





