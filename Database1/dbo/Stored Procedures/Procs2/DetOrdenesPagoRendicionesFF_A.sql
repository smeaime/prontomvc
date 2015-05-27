CREATE Procedure [dbo].[DetOrdenesPagoRendicionesFF_A]

@IdDetalleOrdenPagoRendicionesFF int  output,
@IdOrdenPago int,
@NumeroRendicion int

AS 

INSERT INTO [DetalleOrdenesPagoRendicionesFF]
(
 IdOrdenPago,
 NumeroRendicion
)
VALUES
(
 @IdOrdenPago,
 @NumeroRendicion
)

SELECT @IdDetalleOrdenPagoRendicionesFF=@@identity

RETURN(@IdDetalleOrdenPagoRendicionesFF)