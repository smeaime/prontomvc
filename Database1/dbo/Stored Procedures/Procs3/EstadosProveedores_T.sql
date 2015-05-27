
CREATE Procedure [dbo].[EstadosProveedores_T]
@IdEstado int
AS 
SELECT *
FROM [Estados Proveedores]
WHERE (IdEstado=@IdEstado)
