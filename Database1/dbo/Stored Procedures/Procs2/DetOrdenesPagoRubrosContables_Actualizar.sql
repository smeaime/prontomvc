CREATE Procedure [dbo].[DetOrdenesPagoRubrosContables_Actualizar]

@IdDetalleOrdenPagoRubrosContables int,
@IdOrdenPago int,
@IdRubroContable int,
@Importe numeric(18,2),
@Eliminar varchar(2)

AS 

IF @IdDetalleOrdenPagoRubrosContables<=0
	INSERT INTO [DetalleOrdenesPagoRubrosContables]
	(IdOrdenPago, IdRubroContable, Importe)
	VALUES
	(@IdOrdenPago, @IdRubroContable, @Importe)
IF @IdDetalleOrdenPagoRubrosContables>0 and @Eliminar<>'SI'
	UPDATE DetalleOrdenesPagoRubrosContables
	SET 
	 IdOrdenPago=@IdOrdenPago,
	 IdRubroContable=@IdRubroContable,
	 Importe=@Importe
	WHERE (IdDetalleOrdenPagoRubrosContables=@IdDetalleOrdenPagoRubrosContables)
IF @Eliminar='SI'
	DELETE DetalleOrdenesPagoRubrosContables
	WHERE (IdDetalleOrdenPagoRubrosContables=@IdDetalleOrdenPagoRubrosContables)