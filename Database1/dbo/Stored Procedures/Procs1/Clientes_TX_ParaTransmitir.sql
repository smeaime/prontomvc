


CREATE Procedure [dbo].[Clientes_TX_ParaTransmitir]

AS 

SELECT *
FROM Clientes
WHERE EnviarEmail=1 or Exists(Select Top 1 Facturas.IdFactura 
				From Facturas
				Where Facturas.IdCliente=Clientes.IdCliente and IsNull(Facturas.EnviarEmail,1)=1)


