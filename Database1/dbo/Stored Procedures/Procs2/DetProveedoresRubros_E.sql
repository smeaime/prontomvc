




CREATE Procedure [dbo].[DetProveedoresRubros_E]
@IdDetalleProveedorRubros int  
As 
Delete DetalleProveedoresRubros
Where (IdDetalleProveedorRubros=@IdDetalleProveedorRubros)





