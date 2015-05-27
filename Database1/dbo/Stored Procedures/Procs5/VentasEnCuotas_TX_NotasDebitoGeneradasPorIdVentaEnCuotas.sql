




CREATE Procedure [dbo].[VentasEnCuotas_TX_NotasDebitoGeneradasPorIdVentaEnCuotas]

@IdVentaEnCuotas int

AS 

SELECT 
 NotasDebito.IdNotaDebito,
 NotasDebito.NumeroNotaDebito,
 NotasDebito.FechaNotaDebito
FROM NotasDebito
WHERE IsNull(NotasDebito.Anulada,'NO')<>'SI' and 
	Exists(Select Top 1 DetVta.IdNotaDebito
		From DetalleVentasEnCuotas DetVta
		Where DetVta.IdNotaDebito=NotasDebito.IdNotaDebito and 
			DetVta.IdVentaEnCuotas=@IdVentaEnCuotas)
ORDER by NotasDebito.FechaNotaDebito,NotasDebito.NumeroNotaDebito




