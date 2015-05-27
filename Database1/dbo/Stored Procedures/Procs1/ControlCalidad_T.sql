

CREATE Procedure [dbo].[ControlCalidad_T]

@IdDetalle int

AS

IF @IdDetalle>1000000
	SELECT *
	FROM DetalleOtrosIngresosAlmacen
	WHERE IdDetalleOtroIngresoAlmacen=@IdDetalle-1000000 
ELSE
	SELECT *
	FROM DetalleRecepciones
	WHERE IdDetalleRecepcion=@IdDetalle

