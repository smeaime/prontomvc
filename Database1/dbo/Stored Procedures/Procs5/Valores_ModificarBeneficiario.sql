CREATE  Procedure [dbo].[Valores_ModificarBeneficiario]

@IdValor int,
@ChequesALaOrdenDe varchar(100),
@NoALaOrden varchar(2)


AS 

DECLARE @IdDetalleOrdenPagoValores as int
SET @IdDetalleOrdenPagoValores=(Select Top 1 Valores.IdDetalleOrdenPagoValores From Valores Where Valores.IdValor=@IdValor)

UPDATE DetalleOrdenesPagoValores
SET 	ChequesALaOrdenDe=@ChequesALaOrdenDe,
	NoALaOrden=@NoALaOrden
WHERE DetalleOrdenesPagoValores.IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores