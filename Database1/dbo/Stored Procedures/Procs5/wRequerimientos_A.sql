
/*
exec [wCtasCtesA_TXPorMayorParaInfoProv] 100


*/



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


CREATE Procedure [dbo].[wRequerimientos_A]

@IdRequerimiento int,
@NumeroRequerimiento int,
@FechaRequerimiento datetime,
@LugarEntrega ntext,
@Observaciones ntext,
@IdObra int,
@IdSolicito int,
@IdSector int,
@MontoPrevisto numeric(12,2),
@IdComprador int,
@Aprobo int,
@FechaAprobacion datetime,
@MontoParaCompra numeric(12,2),
@Cumplido varchar(2),
@UsuarioAnulacion varchar(6),
@FechaAnulacion datetime,
@MotivoAnulacion ntext,
@IdRequerimientoOriginal int,
@IdOrigenTransmision int,
@IdAutorizoCumplido int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
@IdMoneda int,
@Detalle varchar(50),
@Confirmado varchar(2),
@FechaImportacionTransmision datetime,
@IdEquipoDestino int,
@Impresa varchar(2),
@Recepcionado varchar(2),
@Entregado varchar(2),
@TipoRequerimiento varchar(2),
@IdOrdenTrabajo int,
@IdTipoCompra int,
@IdImporto int,
@FechaLlegadaImportacion datetime,
@CircuitoFirmasCompleto varchar(2),
@ConfirmadoPorWeb varchar(2)
AS

DECLARE @ReturnValue int

IF IsNull(@IdRequerimiento,0)<=0
    BEGIN
	BEGIN TRAN
	
	SET @NumeroRequerimiento=IsNull((Select Top 1 P.ProximoNumeroRequerimiento
						From Parametros P Where P.IdParametro=1),1)
	UPDATE Parametros
	SET ProximoNumeroRequerimiento=@NumeroRequerimiento+1
	
	INSERT INTO Requerimientos
	(
	 NumeroRequerimiento,
	 FechaRequerimiento,
	 LugarEntrega,
	 Observaciones,
	 IdObra,
	 IdSolicito,
	 IdSector,
	 MontoPrevisto,
	 IdComprador,
	 Aprobo,
	 FechaAprobacion,
	 MontoParaCompra,
	 Cumplido,
	 UsuarioAnulacion,
	 FechaAnulacion,
	 MotivoAnulacion,
	 IdRequerimientoOriginal,
	 IdOrigenTransmision,
	 IdAutorizoCumplido,
	 IdDioPorCumplido,
	 FechaDadoPorCumplido,
	 ObservacionesCumplido,
	 IdMoneda,
	 Detalle,
	 Confirmado,
	 FechaImportacionTransmision,
	 IdEquipoDestino,
	 Impresa,
	 Recepcionado,
	 Entregado,
	 TipoRequerimiento,
	 IdOrdenTrabajo,
	 IdTipoCompra,
	 IdImporto,
	 FechaLlegadaImportacion,
	 CircuitoFirmasCompleto,
	 ConfirmadoPorWeb
	)
	VALUES
	(
	 @NumeroRequerimiento,
	 @FechaRequerimiento,
	 @LugarEntrega,
	 @Observaciones,
	 @IdObra,
	 @IdSolicito,
	 @IdSector,
	 @MontoPrevisto,
	 @IdComprador,
	 @Aprobo,
	 @FechaAprobacion,
	 @MontoParaCompra,
	 @Cumplido,
	 @UsuarioAnulacion,
	 @FechaAnulacion,
	 @MotivoAnulacion,
	 @IdRequerimientoOriginal,
	 @IdOrigenTransmision,
	 @IdAutorizoCumplido,
	 @IdDioPorCumplido,
	 @FechaDadoPorCumplido,
	 @ObservacionesCumplido,
	 @IdMoneda,
	 @Detalle,
	 @Confirmado,
	 @FechaImportacionTransmision,
	 @IdEquipoDestino,
	 @Impresa,
	 @Recepcionado,
	 @Entregado,
	 @TipoRequerimiento,
	 @IdOrdenTrabajo,
	 @IdTipoCompra,
	 @IdImporto,
	 @FechaLlegadaImportacion,
	 @CircuitoFirmasCompleto,
	 @ConfirmadoPorWeb
	)
	
	SELECT @ReturnValue = SCOPE_IDENTITY()
	
	IF @@ERROR <> 0
	    BEGIN
		ROLLBACK TRAN
		RETURN -1
	    END
	ELSE
	    BEGIN
		COMMIT TRAN
	    END
    END
ELSE
    BEGIN
	UPDATE Requerimientos
	SET 
	 NumeroRequerimiento=@NumeroRequerimiento,
	 FechaRequerimiento=@FechaRequerimiento,
	 LugarEntrega=@LugarEntrega,
	 Observaciones=@Observaciones,
	 IdObra=@IdObra,
	 IdSolicito=@IdSolicito,
	 IdSector=@IdSector,
	 MontoPrevisto=@MontoPrevisto,
	 IdComprador=@IdComprador,
	 Aprobo=@Aprobo,
	 FechaAprobacion=@FechaAprobacion,
	 MontoParaCompra=@MontoParaCompra,
	 Cumplido=@Cumplido,
	 UsuarioAnulacion=@UsuarioAnulacion,
	 FechaAnulacion=@FechaAnulacion,
	 MotivoAnulacion=@MotivoAnulacion,
	 IdRequerimientoOriginal=@IdRequerimientoOriginal,
	 IdOrigenTransmision=@IdOrigenTransmision,
	 IdAutorizoCumplido=@IdAutorizoCumplido,
	 IdDioPorCumplido=@IdDioPorCumplido,
	 FechaDadoPorCumplido=@FechaDadoPorCumplido,
	 ObservacionesCumplido=@ObservacionesCumplido,
	 IdMoneda=@IdMoneda,
	 Detalle=@Detalle,
	 Confirmado=@Confirmado,
	 FechaImportacionTransmision=@FechaImportacionTransmision,
	 IdEquipoDestino=@IdEquipoDestino,
	-- Impresa=@Impresa
	 Recepcionado=@Recepcionado,
	 Entregado=@Entregado,
	 TipoRequerimiento=@TipoRequerimiento,
	 IdOrdenTrabajo=@IdOrdenTrabajo,
	 IdTipoCompra=@IdTipoCompra,
	 IdImporto=@IdImporto,
	 FechaLlegadaImportacion=@FechaLlegadaImportacion,
	 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
	 ConfirmadoPorWeb=@ConfirmadoPorWeb
	WHERE (IdRequerimiento=@IdRequerimiento)

	SELECT @ReturnValue = @IdRequerimiento
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @ReturnValue

