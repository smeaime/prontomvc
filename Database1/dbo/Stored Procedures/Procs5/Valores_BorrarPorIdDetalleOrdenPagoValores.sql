CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleOrdenPagoValores]

@IdDetalleOrdenPagoValores int

AS 

SET NOCOUNT ON

DECLARE @IdValor int, @IdOrdenPago int, @IdUsuario int, @NumeroValor numeric(18,0), @IdBancoChequera int

SET @IdValor=IsNull((SELECT TOP 1 IdValor FROM Valores WHERE IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores),0)
SET @IdOrdenPago=IsNull((SELECT TOP 1 IdOrdenPago FROM DetalleOrdenesPagoValores WHERE IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores),0)
SET @NumeroValor=IsNull((SELECT TOP 1 NumeroValor FROM DetalleOrdenesPagoValores WHERE IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores),0)
SET @IdBancoChequera=IsNull((SELECT TOP 1 IdBancoChequera FROM DetalleOrdenesPagoValores WHERE IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores),0)
SET @IdUsuario=IsNull((SELECT TOP 1 IsNull(IdUsuarioAnulo,IdUsuarioModifico) FROM OrdenesPago WHERE IdOrdenPago=@IdOrdenPago),0)

IF @IdValor>0
    BEGIN
	INSERT INTO [Log](Tipo, IdComprobante, IdDetalleComprobante, FechaRegistro, AuxNum1, AuxNum2, AuxNum3, AuxNum4, Detalle)
	VALUES ('CH-EL', @IdOrdenPago, @IdValor, GetDate(), @IdUsuario, @NumeroValor, @IdDetalleOrdenPagoValores, @IdBancoChequera, 
		'Eliminacion de cheque '+Convert(varchar,@NumeroValor)+' - IdDetalleOrdenPagoValores '+Convert(varchar,@IdDetalleOrdenPagoValores))

	DELETE FROM DetalleAsientos
	WHERE IsNull(IdValor,-1)=@IdValor
    END

DELETE FROM Valores
WHERE (IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores and IsNull(Anulado,'NO')<>'SI')

SET NOCOUNT OFF