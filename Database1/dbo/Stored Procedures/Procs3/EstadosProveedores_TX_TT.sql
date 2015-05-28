
CREATE Procedure [dbo].[EstadosProveedores_TX_TT]
@IdEstado int
AS 
SELECT IdEstado, Descripcion, Activo
FROM [Estados Proveedores]
WHERE (IdEstado=@IdEstado)
