
CREATE Procedure [dbo].[wDetProveedoresContactos_TT]

@IdProveedor int

AS 

SELECT Det.*
FROM DetalleProveedores Det
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Det.IdProveedor
WHERE Det.IdProveedor=@IdProveedor

