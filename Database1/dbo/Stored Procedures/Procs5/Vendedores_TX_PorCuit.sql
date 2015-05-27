
CREATE PROCEDURE [dbo].[Vendedores_TX_PorCuit]

@Cuit varchar(13)

AS 

SELECT * 
FROM Vendedores
WHERE (Cuit=@Cuit)
