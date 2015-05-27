



CREATE Procedure [dbo].[DetProveedores_TX_TodosSinFormato]
@IdProveedor int
AS 
SELECT *
FROM DetalleProveedores
WHERE (IdProveedor=@IdProveedor)



