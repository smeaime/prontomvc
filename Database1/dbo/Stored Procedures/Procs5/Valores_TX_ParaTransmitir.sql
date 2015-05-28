


CREATE Procedure [dbo].[Valores_TX_ParaTransmitir]

AS 

SET NOCOUNT ON
UPDATE Valores
SET CuitClienteTransmision=(Select Top 1 Clientes.Cuit 
				From Clientes 
				Where Clientes.IdCliente=Valores.IdCliente)
WHERE IsNull(EnviarEmail,1)=1
SET NOCOUNT OFF

SELECT *
FROM Valores 
WHERE IsNull(EnviarEmail,1)=1


