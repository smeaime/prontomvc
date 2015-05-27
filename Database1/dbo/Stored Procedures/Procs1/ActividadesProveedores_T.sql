CREATE Procedure [dbo].[ActividadesProveedores_T]

@IdActividad int

AS 

SELECT *
FROM [Actividades Proveedores]
WHERE (IdActividad=@IdActividad)