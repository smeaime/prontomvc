CREATE Procedure [dbo].[DetRecibosRubrosContables_Actualizar]

@IdDetalleReciboRubrosContables int,
@IdRecibo int,
@IdRubroContable int,
@Importe numeric(18,2),
@Eliminar varchar(2)

AS 

IF @IdDetalleReciboRubrosContables<=0
	INSERT INTO [DetalleRecibosRubrosContables]
	(IdRecibo, IdRubroContable, Importe)
	VALUES
	(@IdRecibo, @IdRubroContable, @Importe)
IF @IdDetalleReciboRubrosContables>0 and @Eliminar<>'SI'
	UPDATE DetalleRecibosRubrosContables
	SET 
	 IdRecibo=@IdRecibo,
	 IdRubroContable=@IdRubroContable,
	 Importe=@Importe
	WHERE (IdDetalleReciboRubrosContables=@IdDetalleReciboRubrosContables)
IF @Eliminar='SI'
	DELETE DetalleRecibosRubrosContables
	WHERE (IdDetalleReciboRubrosContables=@IdDetalleReciboRubrosContables)