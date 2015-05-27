CREATE Procedure [dbo].[ActividadesProveedores_TX_TT]

@IdActividad int

AS 

SELECT 
 IdActividad, 
 Descripcion as [Actividad],
 Agrupacion1 as [Grupo 1]
FROM [Actividades Proveedores]
WHERE (IdActividad=@IdActividad)