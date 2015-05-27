




CREATE PROCEDURE [dbo].[DetNotasCreditoImp_TXCre]

@IdNotaCredito int

AS

SET NOCOUNT ON
DECLARE @IdMonedaPesos int,@IdMonedaDolar int
SET @IdMonedaPesos=(Select Parametros.IdMoneda From Parametros Where Parametros.IdParametro=1)
SET @IdMonedaDolar=(Select Parametros.IdMonedaDolar From Parametros Where Parametros.IdParametro=1)
SET NOCOUNT OFF

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00011111133'
set @vector_T='00001433300'

SELECT
 DetCre.IdDetalleNotaCreditoImputaciones,
 DetCre.IdNotaCredito,
 DetCre.IdImputacion,
 Case 	When DetCre.IdImputacion=-1 Then 'S/I'
	Else TiposComprobante.DescripcionAB
 End as [Comp.],
 CuentasCorrientesDeudores.NumeroComprobante as [Numero],
 CuentasCorrientesDeudores.Fecha,
 CASE WHEN NotasCredito.IdMoneda=@IdMonedaDolar
	THEN CuentasCorrientesDeudores.ImporteTotalDolar*TiposComprobante.Coeficiente
	ELSE CuentasCorrientesDeudores.ImporteTotal*TiposComprobante.Coeficiente
 END as [ImporteTotal],
 CASE WHEN NotasCredito.IdMoneda=@IdMonedaDolar
	THEN CuentasCorrientesDeudores.SaldoDolar*TiposComprobante.Coeficiente
	ELSE CuentasCorrientesDeudores.Saldo*TiposComprobante.Coeficiente
 END as [Saldo],
 DetCre.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasCreditoImputaciones DetCre
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=DetCre.IdNotaCredito
LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetCre.IdImputacion
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesDeudores.IdTipoComp
WHERE (DetCre.IdNotaCredito = @IdNotaCredito)




