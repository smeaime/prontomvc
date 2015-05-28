





















CREATE Procedure [dbo].[DetProveedoresIB_TX_PorIdProveedorIdIBCondicion]
@IdProveedor int,
@IdIBCondicion int
AS  
SELECT *
FROM DetalleProveedoresIB
WHERE DetalleProveedoresIB.IdProveedor = @IdProveedor and 
	 DetalleProveedoresIB.IdIBCondicion = @IdIBCondicion






















