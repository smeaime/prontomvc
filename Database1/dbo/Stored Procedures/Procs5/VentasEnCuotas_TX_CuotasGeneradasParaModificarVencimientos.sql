




CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasGeneradasParaModificarVencimientos]

@NumeroGeneracion int

AS 

SELECT 
 DetVta.*,
 vec.IdArticulo
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN VentasEnCuotas vec ON vec.IdVentaEnCuotas=DetVta.IdVentaEnCuotas
WHERE DetVta.NumeroGeneracion=@NumeroGeneracion
ORDER by vec.IdArticulo,DetVta.Cuota




