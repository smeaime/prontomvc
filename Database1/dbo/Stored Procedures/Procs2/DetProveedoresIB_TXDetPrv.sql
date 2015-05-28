CREATE Procedure [dbo].[DetProveedoresIB_TXDetPrv]

@IdProveedor int

AS  

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0011133'
SET @vector_T='0012400'

SELECT  
 DetalleProveedoresIB.IdDetalleProveedorIB,
 DetalleProveedoresIB.IdProveedor,
 IBCondiciones.Descripcion as [Jurisdiccion / Provincia],
 DetalleProveedoresIB.AlicuotaAAplicar as [% a aplicar],
 DetalleProveedoresIB.FechaVencimiento as [Fecha vto.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProveedoresIB
LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=DetalleProveedoresIB.IdIBCondicion
WHERE (DetalleProveedoresIB.IdProveedor = @IdProveedor)
