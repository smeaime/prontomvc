
CREATE Procedure [dbo].[DetValoresCuentas_E]
@IdDetalleValorCuentas int
AS 
DELETE DetalleValoresCuentas
WHERE (IdDetalleValorCuentas=@IdDetalleValorCuentas)
