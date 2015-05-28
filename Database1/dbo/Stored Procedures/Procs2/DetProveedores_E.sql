



CREATE Procedure [dbo].[DetProveedores_E]
@IdDetalleProveedor int  
As 
Delete DetalleProveedores
Where (IdDetalleProveedor=@IdDetalleProveedor)



