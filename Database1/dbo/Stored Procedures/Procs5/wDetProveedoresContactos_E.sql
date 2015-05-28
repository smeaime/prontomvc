
CREATE Procedure [dbo].[wDetProveedoresContactos_E]

@IdDetalleProveedor int  

AS 

DELETE [DetalleProveedores]
WHERE (IdDetalleProveedor=@IdDetalleProveedor)

