CREATE PROCEDURE [dbo].[DetRequerimientosLogSituacion_AgregarLog]

@IdDetalleRequerimiento int = Null,
@IdUsuarioModifico int = Null,
@Observaciones ntext = Null,
@CambiarSituacion varchar(2) = Null

AS

SET NOCOUNT ON

SET @CambiarSituacion=IsNull(@CambiarSituacion,'NO')

DECLARE @Situacion varchar(1), @NuevaSituacion varchar(1)

SET @Situacion=IsNull((Select Top 1 Situacion From DetalleRequerimientosLogSituacion Where IdDetalleRequerimiento=@IdDetalleRequerimiento Order By Fecha Desc),'A')
IF @CambiarSituacion='SI' 
	IF @Situacion='A'
		SET @NuevaSituacion='I'
	ELSE
		SET @NuevaSituacion='A'
ELSE
	SET @NuevaSituacion=@Situacion

INSERT INTO DetalleRequerimientosLogSituacion
(IdDetalleRequerimiento, Situacion, Fecha, IdUsuarioModifico, Observaciones, CambioSituacion)
VALUES
(@IdDetalleRequerimiento, @NuevaSituacion, getdate(), @IdUsuarioModifico, @Observaciones, @CambiarSituacion) 

SET NOCOUNT OFF

