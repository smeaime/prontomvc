
CREATE Procedure [dbo].[wEstadosProveedores_TL]
AS 
SELECT IdEstado, Descripcion as [Titulo]
FROM [Estados Proveedores]
ORDER BY Descripcion

