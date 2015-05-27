




CREATE Procedure [dbo].[DetProveedoresRubros_M]
@IdDetalleProveedorRubros int,
@IdProveedor int,
@IdRubro int,
@IdSubrubro int
As
Update [DetalleProveedoresRubros]
Set 
 IdProveedor=@IdProveedor,
 IdRubro=@IdRubro,
 IdSubrubro=@IdSubrubro
Where (IdDetalleProveedorRubros=@IdDetalleProveedorRubros)
Return(@IdDetalleProveedorRubros)





