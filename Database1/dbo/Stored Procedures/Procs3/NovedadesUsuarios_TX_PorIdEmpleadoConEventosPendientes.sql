CREATE PROCEDURE [dbo].[NovedadesUsuarios_TX_PorIdEmpleadoConEventosPendientes]

@IdEmpleado int

AS

DECLARE @ControlConsistencia varchar(2)

SET @ControlConsistencia=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
								 Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
								 Where pic.Clave='Activar control de consistencia al iniciar PRONTO' and ProntoIni.IdUsuario=@IdEmpleado),'')

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111133'
SET @vector_T='0314200'

SELECT 
 NU.IdNovedadUsuarios,
 Ev.Descripcion as [Evento],
 NU.Detalle,
 NU.FechaEvento as [Fecha evento],
 Case When IsNull(NU.IdEnviadoPor,0)=0 Then 'PRONTO' Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=NU.IdEnviadoPor) End as [Enviado por],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM NovedadesUsuarios NU
LEFT OUTER JOIN EventosDelSistema Ev ON NU.IdEventoDelSistema=Ev.IdEventoDelSistema
WHERE NU.IdEmpleado = @IdEmpleado and (NU.Confirmado is null or NU.Confirmado='NO') and (nu.IdEventoDelSistema<>501 or @ControlConsistencia='SI')

