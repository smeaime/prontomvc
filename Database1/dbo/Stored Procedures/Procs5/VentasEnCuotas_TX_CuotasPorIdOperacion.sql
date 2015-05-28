






CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasPorIdOperacion]

@IdVentaEnCuotas int

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111116116633'
Set @vector_T='0001343344200'

SELECT 
 DetVta.IdDetalleVentaEnCuotas, 
 DetVta.Cuota as [Cuota],
 NotasDebito.TipoABC as [A/B/E],
 NotasDebito.PuntoVenta as [Pto.vta.], 
 NotasDebito.NumeroNotaDebito as [Nota debito], 
 NotasDebito.FechaNotaDebito as [Fecha debito],
 NotasDebito.ImporteTotal as [Importe debito],
 Recibos.NumeroRecibo as [Nro.Recibo],
 Recibos.FechaRecibo as [Fecha cobro],
 DetalleRecibos.Importe as [Importe cobrado],
 DetVta.Intereses as [Intereses],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito = DetVta.IdNotaDebito
LEFT OUTER JOIN CuentasCorrientesDeudores Cta ON Cta.IdTipoComp = 3 and Cta.IdComprobante = DetVta.IdNotaDebito
LEFT OUTER JOIN DetalleRecibos ON DetalleRecibos.IdImputacion = Cta.IdCtaCte
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo = DetalleRecibos.IdRecibo
WHERE DetVta.IdVentaEnCuotas=@IdVentaEnCuotas 
ORDER by DetVta.Cuota,Recibos.FechaRecibo,Recibos.NumeroRecibo






