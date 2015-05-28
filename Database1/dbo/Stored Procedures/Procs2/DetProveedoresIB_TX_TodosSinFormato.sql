






















CREATE Procedure [dbo].[DetProveedoresIB_TX_TodosSinFormato]
@IdProveedor int
AS 
SELECT *
FROM DetalleProveedoresIB
WHERE (IdProveedor=@IdProveedor)























