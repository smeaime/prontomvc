












CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasPorIdVentaEnCuotas]

@IdVentaEnCuotas int

AS 

IF EXISTS(SELECT nd.NumeroCuota FROM NotasDebito nd
		WHERE (nd.IdVentaEnCuotas=@IdVentaEnCuotas))
	BEGIN
		SELECT nd.NumeroCuota,
			VentasEnCuotas.ImporteCuota
		FROM NotasDebito nd
		LEFT OUTER JOIN VentasEnCuotas ON VentasEnCuotas.IdVentaEnCuotas=@IdVentaEnCuotas
		WHERE (nd.IdVentaEnCuotas=@IdVentaEnCuotas)
		ORDER BY nd.NumeroCuota Desc
	END
ELSE
	BEGIN
		SELECT 1 AS [NumeroCuota],
			VentasEnCuotas.ImporteCuota
		FROM VentasEnCuotas
		WHERE (VentasEnCuotas.IdVentaEnCuotas=@IdVentaEnCuotas)
	END












