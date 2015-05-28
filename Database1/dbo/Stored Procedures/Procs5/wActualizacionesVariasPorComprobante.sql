CREATE Procedure [dbo].[wActualizacionesVariasPorComprobante]

@IdTipoCOmprobante int,
@IdComprobante int,
@TipoMovimiento varchar(1)

AS

-- Requerimiento
IF @IdTipoCOmprobante=103
   BEGIN
	DECLARE @NumeroRequerimiento int, @Aprobo int, @CircuitoFirmasCompleto varchar(2), @TipoRequerimiento varchar(2), @IdOrigenTransmision int, @IdObra int, @GrupoObraParaFirmas integer, 
		@GrupoObraActual integer, @ObrasALaFirma varchar(1000)

	SET @Aprobo=(Select Top 1 Aprobo From Requerimientos Where IdRequerimiento = @IdComprobante)
	SET @CircuitoFirmasCompleto=(Select Top 1 CircuitoFirmasCompleto From Requerimientos Where IdRequerimiento = @IdComprobante)
	SET @IdOrigenTransmision=(Select Top 1 IdOrigenTransmision From Requerimientos Where IdRequerimiento = @IdComprobante)
	SET @IdObra=(Select Top 1 IdObra From Requerimientos Where IdRequerimiento = @IdComprobante)
	SET @TipoRequerimiento=(Select Top 1 TipoRequerimiento From Requerimientos Where IdRequerimiento = @IdComprobante)
   
	IF @TipoMovimiento='N' and @IdOrigenTransmision IS NULL
	   BEGIN
		SET @NumeroRequerimiento=IsNull((Select Top 1 ProximoNumeroRequerimiento From Parametros Where IdParametro=1),1)
	
		UPDATE Parametros
		SET ProximoNumeroRequerimiento=@NumeroRequerimiento+1
	   END
	
	IF IsNull(@Aprobo,0)>0 and IsNull(@CircuitoFirmasCompleto,'')<>'SI'
	   BEGIN
		SET @GrupoObraParaFirmas=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Grupo de obra para firma obligatoria'),0)
		SET @ObrasALaFirma=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Ids de obras para firma obligatoria'),'')
		SET @GrupoObraActual=Isnull((Select Top 1 IdGrupoObra From Obras Where IdObra=@IdObra),0)
		IF (IsNull(@TipoRequerimiento,'')='OP' or IsNull(@TipoRequerimiento,'')='OT') and @GrupoObraParaFirmas>0 and @GrupoObraActual<>@GrupoObraParaFirmas and Patindex('%('+Convert(varchar,@IdObra)+')%', @ObrasALaFirma)=0
		   BEGIN
			UPDATE Requerimientos
			SET CircuitoFirmasCompleto='SI'
			WHERE IdRequerimiento = @IdComprobante
		   END
	   END
	EXEC Requerimientos_ActualizarEstado @IdComprobante, Null
   END

-- Solicitud de cotizacion (Presupuesto)
IF @IdTipoCOmprobante=104
   BEGIN
	DECLARE @NumeroSolicitudCotizacion int, @SubNumero int

	SET @SubNumero=(Select Top 1 SubNumero From Presupuestos Where IdPresupuesto = @IdComprobante)
	IF @TipoMovimiento='N' and @SubNumero=1
	   BEGIN
		SET @NumeroSolicitudCotizacion=IsNull((Select Top 1 ProximoPresupuesto From Parametros Where IdParametro=1),1)
	
		UPDATE Parametros
		SET ProximoPresupuesto=@NumeroSolicitudCotizacion+1
	   END

   END