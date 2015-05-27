CREATE Procedure [dbo].[ActividadesProveedores_TX_PorDescripcion]

@Actividad varchar(50)

AS 

SELECT TOP 1 *
FROM [Actividades Proveedores]
WHERE Upper(@Actividad)=Upper(Descripcion)
