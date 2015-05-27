















CREATE Procedure [dbo].[VentasEnCuotas_TX_PorId]
@IdVentaEnCuotas int
AS 
SELECT *
FROM VentasEnCuotas
WHERE (IdVentaEnCuotas=@IdVentaEnCuotas)

















