






















CREATE Procedure [dbo].[DetProveedoresIB_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0011133'
set @vector_T='0012400'
SELECT TOP 1 
 DetalleProveedoresIB.IdDetalleProveedorIB,
 DetalleProveedoresIB.IdProveedor,
 IBCondiciones.Descripcion as [Jurisdiccion / Provincia],
 DetalleProveedoresIB.AlicuotaAAplicar as [% a aplicar],
 DetalleProveedoresIB.FechaVencimiento as [Fecha vto.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProveedoresIB
LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=DetalleProveedoresIB.IdIBCondicion






















