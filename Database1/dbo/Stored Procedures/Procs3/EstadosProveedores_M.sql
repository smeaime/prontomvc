
CREATE  Procedure [dbo].[EstadosProveedores_M]
@IdEstado int ,
@Descripcion varchar(50),
@Activo varchar(2)
AS
UPDATE [Estados Proveedores]
SET
 Descripcion=@Descripcion,
 Activo=@Activo
WHERE (IdEstado=@IdEstado)
RETURN(@IdEstado)
