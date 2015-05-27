






















CREATE Procedure [dbo].[DetProveedoresIB_M]
@IdDetalleProveedorIB int,
@IdProveedor int,
@IdIBCondicion int,
@AlicuotaAAplicar numeric(6,2),
@FechaVencimiento datetime
as
Update [DetalleProveedoresIB]
SET 
 IdProveedor=@IdProveedor,
 IdIBCondicion=@IdIBCondicion,
 AlicuotaAAplicar=@AlicuotaAAplicar,
 FechaVencimiento=@FechaVencimiento
Where (IdDetalleProveedorIB=@IdDetalleProveedorIB)
Return(@IdDetalleProveedorIB)























