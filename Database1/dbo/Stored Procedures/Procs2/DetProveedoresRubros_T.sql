




CREATE Procedure [dbo].[DetProveedoresRubros_T]
@IdDetalleProveedorRubros int
AS 
SELECT *
FROM DetalleProveedoresRubros
WHERE (IdDetalleProveedorRubros=@IdDetalleProveedorRubros)





