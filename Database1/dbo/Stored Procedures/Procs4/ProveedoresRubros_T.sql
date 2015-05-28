





























CREATE Procedure [dbo].[ProveedoresRubros_T]
@IdProveedorRubro int
AS 
SELECT *
FROM ProveedoresRubros
where (IdProveedorRubro=@IdProveedorRubro)






























