
CREATE Procedure [dbo].[wDetProveedoresContactos_T]

@IdDetalleProveedor int

AS 

SELECT *
FROM [DetalleProveedores]
WHERE (IdDetalleProveedor=@IdDetalleProveedor)

