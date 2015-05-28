
CREATE Procedure [dbo].[wActividadesProveedores_TL]
AS 
SELECT IdActividad, Descripcion as [Titulo]
FROM [Actividades Proveedores]
ORDER BY Descripcion

