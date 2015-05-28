





























CREATE Procedure [dbo].[ProveedoresRubros_TX_TT]
@IdProveedorRubro int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='001010101133'
set @vector_T='003010101100'
Select 
ProveedoresRubros.IdProveedorRubro,
ProveedoresRubros.IdProveedor,
Proveedores.RazonSocial as Proveedor,
ProveedoresRubros.IdRubro,
Rubros.Descripcion as Rubro,
ProveedoresRubros.IdSubrubro,
Subrubros.Descripcion as Subrubro,
ProveedoresRubros.IdFamilia,
Familias.Descripcion as Familia,
ProveedoresRubros.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM ProveedoresRubros
LEFT OUTER JOIN Proveedores ON  ProveedoresRubros.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Rubros ON  ProveedoresRubros.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON ProveedoresRubros.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Familias ON ProveedoresRubros.IdFamilia = Familias.IdFamilia
where (IdProveedorRubro=@IdProveedorRubro)
order by Proveedores.RazonSocial,Rubros.Descripcion,Subrubros.Descripcion,Familias.Descripcion






























