


CREATE Procedure [dbo].[Cajas_TX_PorId]
@IdCaja int
AS 
SELECT *
FROM Cajas
WHERE (IdCaja=@IdCaja)


