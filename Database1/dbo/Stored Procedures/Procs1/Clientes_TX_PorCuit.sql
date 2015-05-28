
CREATE Procedure [dbo].[Clientes_TX_PorCuit]

@Cuit varchar(13)

AS 

SELECT * 
FROM Clientes
WHERE Cuit=@Cuit
