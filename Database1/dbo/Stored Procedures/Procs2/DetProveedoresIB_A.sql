






















CREATE Procedure [dbo].[DetProveedoresIB_A]
@IdDetalleProveedorIB int  output,
@IdProveedor int,
@IdIBCondicion int,
@AlicuotaAAplicar numeric(6,2),
@FechaVencimiento datetime
AS 
Insert into [DetalleProveedoresIB]
(
 IdProveedor,
 IdIBCondicion,
 AlicuotaAAplicar,
 FechaVencimiento
)
Values
(
 @IdProveedor,
 @IdIBCondicion,
 @AlicuotaAAplicar,
 @FechaVencimiento
)
Select @IdDetalleProveedorIB=@@identity
Return(@IdDetalleProveedorIB)























