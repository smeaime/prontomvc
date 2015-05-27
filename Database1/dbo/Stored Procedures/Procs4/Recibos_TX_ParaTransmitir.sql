


CREATE Procedure [dbo].[Recibos_TX_ParaTransmitir]

AS 

SET NOCOUNT ON

UPDATE Recibos
SET CuitClienteTransmision=(Select Top 1 Clientes.Cuit 
				From Clientes 
				Where Clientes.IdCliente=Recibos.IdCliente)
WHERE IsNull(EnviarEmail,1)=1
SET NOCOUNT OFF

SELECT *
FROM Recibos
WHERE IsNull(EnviarEmail,1)=1


