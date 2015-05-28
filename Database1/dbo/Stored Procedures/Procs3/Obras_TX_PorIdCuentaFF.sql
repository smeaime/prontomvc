

CREATE Procedure [dbo].[Obras_TX_PorIdCuentaFF]
@IdCuentaContableFF int
AS 
SELECT *
FROM Obras
WHERE (IdCuentaContableFF=@IdCuentaContableFF)

