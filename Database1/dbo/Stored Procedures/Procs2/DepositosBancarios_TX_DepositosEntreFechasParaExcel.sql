



CREATE PROCEDURE [dbo].[DepositosBancarios_TX_DepositosEntreFechasParaExcel]
	@Desde datetime,
	@Hasta datetime
AS
declare @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(30)
set @vector_X='0111111111111333'
set @vector_T='0555555555555000'
set @vector_E=' DNNCCNNCDINC   '
SELECT 
	DepositosBancarios.IdDepositoBancario, 
	DepositosBancarios.FechaDeposito AS [Fecha dep.], 
	DepositosBancarios.NumeroDeposito AS [Deposito], 
	Recibos.NumeroRecibo as [Recibo],
	(Select Bancos.Nombre From Bancos 
		Where Bancos.IdBanco=DepositosBancarios.IdBanco) as [Banco dep.],
	'CH' as [Tipo],
	Valores.NumeroInterno as [Nro.Int.],
	Valores.NumeroValor as [Numero valor],
	(Select Bancos.Nombre From Bancos 
		Where Bancos.IdBanco=Valores.IdBanco) as [Banco orig.],
	Valores.FechaValor as [Fec.Vto.],
	Valores.Importe as [Importe valor],
	Clientes.CodigoCliente AS [Codigo],
	Clientes.RazonSocial AS [Cliente],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM DetalleDepositosBancarios DetDep
LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=DetDep.IdDepositoBancario
LEFT OUTER JOIN Valores ON Valores.IdValor=DetDep.IdValor
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN DetalleRecibosValores ON Valores.IdDetalleReciboValores=DetalleRecibosValores.IdDetalleReciboValores
LEFT OUTER JOIN Recibos ON DetalleRecibosValores.IdRecibo=Recibos.IdRecibo
WHERE DepositosBancarios.FechaDeposito between @Desde and @hasta

UNION ALL 

SELECT 
	DepositosBancarios.IdDepositoBancario, 
	DepositosBancarios.FechaDeposito AS [Fecha dep.], 
	DepositosBancarios.NumeroDeposito AS [Deposito], 
	Null AS [Recibo],
	Bancos.Nombre as [Banco dep.],
	'EF' as [Tipo],
	Null as [Nro.Int.],
	Null as [Numero],
	'EFECTIVO' as [Banco orig.],
	Null as [Fec.Vto.],
	DepositosBancarios.Efectivo as [Importe valor],
	Null as [Codigo],
	Null as [Cliente],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM DepositosBancarios 
LEFT OUTER JOIN Bancos ON DepositosBancarios.IdBanco = Bancos.IdBanco
WHERE (DepositosBancarios.FechaDeposito between @Desde and @hasta) And 
	(DepositosBancarios.Efectivo is not null And DepositosBancarios.Efectivo<>0)
ORDER BY [Banco dep.],[Fecha dep.],[Deposito],[Nro.Int.]



