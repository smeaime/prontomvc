
CREATE Procedure [dbo].[wEmpleados_TX_UsuarioNT]
@UsuarioNT varchar(50)
AS 
SELECT *
FROM Empleados
WHERE UsuarioNT=@UsuarioNT and IsNull(Activo,'SI')='SI'

