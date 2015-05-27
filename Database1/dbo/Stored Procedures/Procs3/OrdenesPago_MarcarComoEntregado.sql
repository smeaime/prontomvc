
CREATE Procedure [dbo].[OrdenesPago_MarcarComoEntregado]

@IdOrdenPago int,
@NumeroReciboProveedor int = Null,
@FechaReciboProveedor datetime = Null

AS 

SET @NumeroReciboProveedor=IsNull(@NumeroReciboProveedor,0)
SET @FechaReciboProveedor=IsNull(@FechaReciboProveedor,0)

UPDATE OrdenesPago
SET Estado='EN'
WHERE IdOrdenPago=@IdOrdenPago

IF @NumeroReciboProveedor>0
	UPDATE OrdenesPago
	SET NumeroReciboProveedor=@NumeroReciboProveedor, FechaReciboProveedor=@FechaReciboProveedor
	WHERE IdOrdenPago=@IdOrdenPago
