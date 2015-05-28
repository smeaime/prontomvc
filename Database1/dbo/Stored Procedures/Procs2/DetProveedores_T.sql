



CREATE Procedure [dbo].[DetProveedores_T]
@IdDetalleProveedor int
AS 
SELECT *
FROM DetalleProveedores
WHERE (IdDetalleProveedor=@IdDetalleProveedor)



