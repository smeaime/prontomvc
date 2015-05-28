
CREATE Procedure [dbo].[Vendedores_TX_PorNombre]

@Nombre varchar(50)

AS 

SELECT * 
FROM Vendedores
WHERE (Upper(Nombre)=Upper(@Nombre))
