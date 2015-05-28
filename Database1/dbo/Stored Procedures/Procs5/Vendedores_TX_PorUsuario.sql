
CREATE Procedure [dbo].[Vendedores_TX_PorUsuario]

@IdEmpleado int

AS 

SELECT * 
FROM Vendedores
WHERE IdEmpleado=@IdEmpleado
