
































CREATE PROCEDURE [dbo].[Recibos_TXRecibosxAnio]
@Anio int
AS
SELECT 
	Recibos.IdRecibo, 
	Recibos.NumeroRecibo AS Recibo, 
	Recibos.FechaRecibo AS [Fecha Recibo], 
	Clientes.RazonSocial AS Cliente
FROM Recibos 
INNER JOIN Clientes ON  Recibos.IdCliente = Clientes.IdCliente 
where YEAR(Recibos.FechaRecibo)=@anio
ORDER BY Recibos.NumeroRecibo

































