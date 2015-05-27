



CREATE Procedure [dbo].[Empleados_TX_ParaHH]
AS 
SELECT 
 IdEmpleado,
 Nombre as [Apellido y nombre],
 Legajo,
 Interno as [Numero de interno],
 Sectores.Descripcion as [Sector],
 UsuarioNT as [Nombre de usuario en NT],
 Dominio as [Dominio NT],
 Email,
 Cargos.Descripcion as [Cargo],
 Administrador,
 Iniciales,
 HorasJornada as [Hs.jornada],
 GrupoDeCarga as [Grupo HH]
FROM Empleados
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Cargos ON Empleados.IdCargo=Cargos.IdCargo
WHERE IsNull(Empleados.SisMan,'NO')='SI'
ORDER BY Nombre,Legajo



