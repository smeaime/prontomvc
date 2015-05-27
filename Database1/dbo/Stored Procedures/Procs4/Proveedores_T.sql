
CREATE Procedure [dbo].[Proveedores_T]

@IdProveedor int

AS 

SELECT * 
FROM Proveedores
WHERE (IdProveedor=@IdProveedor)
