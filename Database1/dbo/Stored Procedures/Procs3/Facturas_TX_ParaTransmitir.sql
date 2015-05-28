


CREATE Procedure [dbo].[Facturas_TX_ParaTransmitir]

AS 

SET NOCOUNT ON
UPDATE Facturas
SET CuitClienteTransmision=(Select Top 1 Clientes.Cuit 
				From Clientes 
				Where Clientes.IdCliente=Facturas.IdCliente)
WHERE IsNull(EnviarEmail,1)=1
SET NOCOUNT OFF

SELECT *
FROM Facturas
WHERE IsNull(EnviarEmail,1)=1


