
CREATE Procedure [dbo].[EstadosProveedores_TL]
AS 
SELECT IdEstado, Descripcion as [Titulo]
FROM [Estados Proveedores]
ORDER BY Descripcion
