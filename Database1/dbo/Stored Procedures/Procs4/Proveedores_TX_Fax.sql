


CREATE  Procedure [dbo].[Proveedores_TX_Fax]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011111133'
Set @vector_T='029110I00'

SELECT 
 Proveedores.IdProveedor,
 Proveedores.RazonSocial as [Proveedor], 
 Proveedores.IdProveedor as [IdAux],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.Fax as [Fax],
 Proveedores.Email as [Email],
 Proveedores.Telefono1 as [Telefono],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Proveedores
WHERE Fax is not null
ORDER BY Proveedores.RazonSocial



