
CREATE Procedure [dbo].[DetValoresCuentas_T]
@IdDetalleValorCuentas int
AS 
SELECT *
FROM DetalleValoresCuentas
WHERE (IdDetalleValorCuentas=@IdDetalleValorCuentas)
