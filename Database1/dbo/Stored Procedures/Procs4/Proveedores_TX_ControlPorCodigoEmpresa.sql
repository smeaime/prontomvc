




CREATE Procedure [dbo].[Proveedores_TX_ControlPorCodigoEmpresa]
@CodigoEmpresa varchar(20),
@IdProveedor int
AS 
SELECT * 
FROM Proveedores
WHERE Eventual is null And CodigoEmpresa=@CodigoEmpresa and 
	(@IdProveedor<=0 or Proveedores.IdProveedor<>@IdProveedor)




