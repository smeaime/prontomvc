CREATE PROCEDURE [dbo].[Empleados_TX_ConEventosPendientes]

@IdEmpleado int

AS

DECLARE @ControlConsistencia varchar(2)

SET @ControlConsistencia=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
								 Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
								 Where pic.Clave='Activar control de consistencia al iniciar PRONTO' and ProntoIni.IdUsuario=@IdEmpleado),'')

SELECT nu.IdNovedadUsuarios
FROM NovedadesUsuarios nu
WHERE nu.IdEmpleado = @IdEmpleado and (nu.Confirmado is null or nu.Confirmado='NO') and (nu.IdEventoDelSistema<>501 or @ControlConsistencia='SI')
