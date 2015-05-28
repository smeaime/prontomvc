CREATE  Procedure [dbo].[ActividadesProveedores_M]

@IdActividad int ,
@Descripcion varchar(50),
@Agrupacion1 int

AS

UPDATE [Actividades Proveedores]
SET
 Descripcion=@Descripcion,
 Agrupacion1=@Agrupacion1
WHERE (IdActividad=@IdActividad)

RETURN(@IdActividad)