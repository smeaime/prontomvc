




CREATE Procedure [dbo].[DetProveedoresRubros_TX_TodosSinFormato]
@IdProveedor int
AS 
SELECT *
FROM DetalleProveedoresRubros
WHERE (IdProveedor=@IdProveedor)





