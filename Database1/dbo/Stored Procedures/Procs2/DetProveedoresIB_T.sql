






















CREATE Procedure [dbo].[DetProveedoresIB_T]
@IdDetalleProveedorIB int
AS 
SELECT *
FROM DetalleProveedoresIB
WHERE (IdDetalleProveedorIB=@IdDetalleProveedorIB)























