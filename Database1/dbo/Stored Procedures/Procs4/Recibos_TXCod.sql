
CREATE Procedure [dbo].[Recibos_TXCod]
@PuntoVenta int,
@NumeroRecibo int
AS 
SELECT *
FROM Recibos
WHERE PuntoVenta=@PuntoVenta and NumeroRecibo=@NumeroRecibo
