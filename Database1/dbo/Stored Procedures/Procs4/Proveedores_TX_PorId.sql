CREATE Procedure [dbo].[Proveedores_TX_PorId]

@IdProveedor int

AS 

SELECT * 
FROM Proveedores
WHERE (IdProveedor=@IdProveedor)