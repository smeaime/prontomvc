
CREATE  Procedure [dbo].[Proveedores_TX_Contactos]

@IdProveedor int = Null

AS 

SET @IdProveedor=IsNull(@IdProveedor,0)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111111133'
SET @vector_T='0029110HI00'

SELECT 
 Proveedores.IdProveedor,
 1 as [Aux_Orden],
 Proveedores.RazonSocial as [Proveedor], 
 Proveedores.IdProveedor as [IdAux],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.Email as [Email],
 'Principal' as [Contacto],
 Null as [Puesto],
 Proveedores.Telefono1 as [Telefono],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Proveedores
WHERE Email is not null and (@IdProveedor=0 or Proveedores.IdProveedor=@IdProveedor)

UNION ALL

SELECT 
 DetalleProveedores.IdProveedor,
 2 as [Aux_Orden],
 Proveedores.RazonSocial as [Proveedor], 
 Proveedores.IdProveedor as [IdAux],
 Proveedores.CodigoEmpresa as [Codigo],
 DetalleProveedores.Email COLLATE SQL_Latin1_General_CP1_CI_AS as [Email],
 DetalleProveedores.Contacto,
 DetalleProveedores.Puesto as [Puesto],
 DetalleProveedores.Telefono COLLATE SQL_Latin1_General_CP1_CI_AS as [Telefono],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProveedores
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=DetalleProveedores.IdProveedor
WHERE DetalleProveedores.Email is not null and (@IdProveedor=0 or Proveedores.IdProveedor=@IdProveedor)

ORDER BY [Proveedor], [Aux_Orden], [Email]
