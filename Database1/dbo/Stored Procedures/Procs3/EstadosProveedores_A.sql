
CREATE Procedure [dbo].[EstadosProveedores_A]
@IdEstado int  output,
@Descripcion varchar(50),
@Activo varchar(2)
AS 
INSERT INTO [Estados Proveedores]
(
 Descripcion,
 Activo
)
VALUES
(
 @Descripcion,
 @Activo
)
SELECT @IdEstado=@@identity
RETURN(@IdEstado)
