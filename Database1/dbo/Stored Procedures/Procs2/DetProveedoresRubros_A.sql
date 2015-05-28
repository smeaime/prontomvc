




CREATE Procedure [dbo].[DetProveedoresRubros_A]
@IdDetalleProveedorRubros int  output,
@IdProveedor int,
@IdRubro int,
@IdSubrubro int
As 
Insert into [DetalleProveedoresRubros]
(
 IdProveedor,
 IdRubro,
 IdSubrubro
)
Values
(
 @IdProveedor,
 @IdRubro,
 @IdSubrubro
)
Select @IdDetalleProveedorRubros=@@identity
Return(@IdDetalleProveedorRubros)





