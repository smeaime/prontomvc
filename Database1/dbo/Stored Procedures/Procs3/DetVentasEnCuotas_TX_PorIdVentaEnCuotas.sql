





CREATE PROCEDURE [dbo].[DetVentasEnCuotas_TX_PorIdVentaEnCuotas]

@IdVentaEnCuotas int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='001111133'
set @vector_T='003433300'

SELECT
 DetVta.IdDetalleVentaEnCuotas,
 DetVta.IdVentaEnCuotas,
 DetVta.Cuota as [Cuota],
 DetVta.FechaCobranza as [Fecha Cobro],
 DetVta.ImporteCobrado as [Imp.Cobrado],
 DetVta.Intereses as [Intereses],
 Recibos.NumeroRecibo as [Nro.Recibo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN VentasEnCuotas ON VentasEnCuotas.IdVentaEnCuotas = DetVta.IdVentaEnCuotas
LEFT OUTER JOIN Clientes ON Clientes.IdCliente = VentasEnCuotas.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=VentasEnCuotas.IdArticulo
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetVta.IdRecibo
WHERE (DetVta.IdVentaEnCuotas = @IdVentaEnCuotas)





