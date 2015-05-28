

CREATE Procedure [dbo].[Empleados_TX_PorNombre]
@Nombre varchar(50)
AS 
SELECT *
FROM Empleados
WHERE Nombre=@Nombre and IsNull(Activo,'SI')='SI'

