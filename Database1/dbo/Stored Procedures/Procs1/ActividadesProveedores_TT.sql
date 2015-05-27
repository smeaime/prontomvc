CREATE Procedure [dbo].[ActividadesProveedores_TT]

AS 

SELECT 
 IdActividad, 
 Descripcion as [Actividad],
 Agrupacion1 as [Grupo 1]
FROM [Actividades Proveedores]
ORDER BY Descripcion