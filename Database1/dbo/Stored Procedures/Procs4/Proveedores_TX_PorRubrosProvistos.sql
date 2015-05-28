




CREATE Procedure [dbo].[Proveedores_TX_PorRubrosProvistos]
AS  
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='054300'
SELECT  
 DetalleProveedoresRubros.IdDetalleProveedorRubros,
 Proveedores.RazonSocial,
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProveedoresRubros
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=DetalleProveedoresRubros.IdProveedor
LEFT OUTER JOIN Rubros ON Rubros.IdRubro=DetalleProveedoresRubros.IdRubro
LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro=DetalleProveedoresRubros.IdSubrubro




