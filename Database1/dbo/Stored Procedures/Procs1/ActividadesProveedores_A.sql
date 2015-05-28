CREATE Procedure [dbo].[ActividadesProveedores_A]

@IdActividad int  output,
@Descripcion varchar(50),
@Agrupacion1 int

AS 

INSERT INTO [Actividades Proveedores]
(
 Descripcion,
 Agrupacion1
)
VALUES
(
 @Descripcion,
 @Agrupacion1
)

SELECT @IdActividad=@@identity

RETURN(@IdActividad)