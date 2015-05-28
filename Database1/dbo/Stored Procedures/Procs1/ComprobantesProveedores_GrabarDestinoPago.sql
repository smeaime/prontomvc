
CREATE Procedure [dbo].[ComprobantesProveedores_GrabarDestinoPago]

@IdComprobanteProveedor int,
@DestinoPago varchar(1) = Null,
@NumeroOrdenPagoFondoReparo int = Null

AS

SET @DestinoPago=IsNull(@DestinoPago,'')
SET @NumeroOrdenPagoFondoReparo=IsNull(@NumeroOrdenPagoFondoReparo,0)

IF LEN(@DestinoPago)>0
	UPDATE ComprobantesProveedores
	SET DestinoPago=@DestinoPago
	WHERE IdComprobanteProveedor=@IdComprobanteProveedor

IF @NumeroOrdenPagoFondoReparo<>0
	UPDATE ComprobantesProveedores
	SET NumeroOrdenPagoFondoReparo=@NumeroOrdenPagoFondoReparo
	WHERE IdComprobanteProveedor=@IdComprobanteProveedor
