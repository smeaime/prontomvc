


CREATE Procedure [dbo].[CtasCtesD_TX_ParaTransmitir]

AS 

SET NOCOUNT ON
UPDATE CuentasCorrientesDeudores
SET CuitClienteTransmision=(Select Top 1 Clientes.Cuit 
				From Clientes 
				Where Clientes.IdCliente=CuentasCorrientesDeudores.IdCliente)
WHERE IsNull(EnviarEmail,1)=1
SET NOCOUNT OFF

SELECT *
FROM CuentasCorrientesDeudores 
WHERE IsNull(EnviarEmail,1)=1


