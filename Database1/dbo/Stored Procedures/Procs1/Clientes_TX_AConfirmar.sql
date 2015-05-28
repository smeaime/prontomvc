CREATE  Procedure [dbo].[Clientes_TX_AConfirmar]

AS 

SELECT 
 Clientes.IdCliente, 
 Clientes.RazonSocial as [Razon social],
 Clientes.Codigo as [Codigo],
 Clientes.Direccion, 
 Clientes.CodigoPostal, 
 Clientes.Telefono, 
 Clientes.Email, 
 Clientes.Cuit,
 Clientes.CodigoPresto as [Codigo PRESTO]
FROM Clientes 
WHERE Clientes.Confirmado is not null and Clientes.Confirmado='NO'
ORDER BY Clientes.RazonSocial