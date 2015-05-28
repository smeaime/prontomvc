
CREATE Procedure [dbo].[Proveedores_E]
@IdProveedor int  
AS 
DELETE Proveedores
WHERE (IdProveedor=@IdProveedor)
