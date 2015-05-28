CREATE Procedure [dbo].[Bancos_TX_ParaDebitosClientes]

AS 

SELECT 
 Bancos.IdBanco [IdBanco],
 Bancos.Nombre as [Titulo]
FROM Bancos 
WHERE Exists(Select Top 1 Clientes.IdCliente From Clientes Where Clientes.IdBancoGestionador=Bancos.IdBanco)

UNION ALL

SELECT 
 TarjetasCredito.IdTarjetaCredito+1000000 [IdBanco],
 TarjetasCredito.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS as [Titulo]
FROM TarjetasCredito 
WHERE Exists(Select Top 1 Clientes.IdCliente From Clientes Where Clientes.IdTarjetaCredito=TarjetasCredito.IdTarjetaCredito)

ORDER BY [Titulo]