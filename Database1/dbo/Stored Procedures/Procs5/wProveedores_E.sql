
CREATE Procedure [dbo].[wProveedores_E]
@IdProveedor int  
AS 
DELETE Proveedores
WHERE (IdProveedor=@IdProveedor)

