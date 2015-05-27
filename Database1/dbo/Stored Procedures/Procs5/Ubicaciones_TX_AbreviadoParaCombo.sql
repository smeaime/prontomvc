CREATE Procedure [dbo].[Ubicaciones_TX_AbreviadoParaCombo]

@IdUsuario int = Null

AS 

SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @LimitarUbicacionesAsignadas varchar(2)

SET @LimitarUbicacionesAsignadas='NO'
IF @IdUsuario>0
	SET @LimitarUbicacionesAsignadas=IsNull((Select Top 1 LimitarUbicacionesAsignadas From Empleados Where IdEmpleado=@IdUsuario),'NO')

SELECT 
 Ubicaciones.IdUbicacion,
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Titulo]
FROM Ubicaciones
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE @IdUsuario=-1 or @LimitarUbicacionesAsignadas='NO' or Ubicaciones.IdUbicacion In (Select deu.IdUbicacion From DetalleEmpleadosUbicaciones deu Where deu.IdEmpleado=@IdUsuario)
ORDER BY [Titulo]