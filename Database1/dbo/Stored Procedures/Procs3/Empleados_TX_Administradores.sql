CREATE Procedure [dbo].[Empleados_TX_Administradores]

AS 

SELECT *, Nombre as Titulo
FROM Empleados
WHERE IsNull(Administrador,'NO')='SI' and IsNull(Activo,'SI')='SI'
ORDER BY Nombre