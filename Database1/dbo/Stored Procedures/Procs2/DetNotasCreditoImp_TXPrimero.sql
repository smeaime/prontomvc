




CREATE PROCEDURE [dbo].[DetNotasCreditoImp_TXPrimero]

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00011111133'
set @vector_T='00001433300'

SELECT TOP 1
 DetCre.IdDetalleNotaCreditoImputaciones,
 DetCre.IdNotaCredito,
 DetCre.IdImputacion,
 TiposComprobante.DescripcionAB as [Comp.],
 CuentasCorrientesDeudores.NumeroComprobante as [Numero],
 CuentasCorrientesDeudores.Fecha,
 CuentasCorrientesDeudores.ImporteTotal,
 CuentasCorrientesDeudores.Saldo,
 DetCre.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasCreditoImputaciones DetCre
LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetCre.IdImputacion
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesDeudores.IdTipoComp




