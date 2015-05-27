CREATE Procedure [dbo].[DetOrdenesPagoRubrosContables_A]

@IdDetalleOrdenPagoRubrosContables int  output,
@IdOrdenPago int,
@IdRubroContable int,
@Importe numeric(18,2)

AS 

INSERT INTO [DetalleOrdenesPagoRubrosContables]
(
 IdOrdenPago,
 IdRubroContable,
 Importe
)
VALUES
(
 @IdOrdenPago,
 @IdRubroContable,
 @Importe
)

SELECT @IdDetalleOrdenPagoRubrosContables=@@identity

RETURN(@IdDetalleOrdenPagoRubrosContables)