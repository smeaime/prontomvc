CREATE Procedure [dbo].[Clientes_TX_PorRazonSocial]

@RazonSocial varchar(100)

AS 

SELECT * 
FROM Clientes
WHERE (RazonSocial=@RazonSocial)