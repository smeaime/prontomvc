






CREATE Procedure [dbo].[VentasEnCuotas_TX_DetallesPorIdVentaEnCuotasYCuota]

@IdVentaEnCuotas int,
@Cuota int

AS 

SELECT *
FROM DetalleVentasEnCuotas DetVta
WHERE DetVta.IdVentaEnCuotas=@IdVentaEnCuotas and DetVta.Cuota=@Cuota






