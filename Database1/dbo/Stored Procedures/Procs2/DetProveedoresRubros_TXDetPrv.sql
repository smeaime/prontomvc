




CREATE Procedure [dbo].[DetProveedoresRubros_TXDetPrv]
@IdProveedor int
AS  
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='001133'
set @vector_T='008800'
SELECT  
 DetalleProveedoresRubros.IdDetalleProveedorRubros,
 DetalleProveedoresRubros.IdProveedor,
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProveedoresRubros
LEFT OUTER JOIN Rubros ON Rubros.IdRubro=DetalleProveedoresRubros.IdRubro
LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro=DetalleProveedoresRubros.IdSubrubro
WHERE (DetalleProveedoresRubros.IdProveedor = @IdProveedor)




