
CREATE Procedure [dbo].[EstadosProveedores_TT]
AS 
SELECT IdEstado, Descripcion, Activo
FROM [Estados Proveedores]
ORDER BY Descripcion
