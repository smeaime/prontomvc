CREATE Procedure [dbo].[CtasCtesA_TXParaImputar]

@IdProveedor int

AS 

DECLARE @IdTipoComprobanteOrdenPago int, @vector_X varchar(30), @vector_T varchar(30)

SET @IdTipoComprobanteOrdenPago=IsNull((Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1),0)
SET @vector_X='0001111111111133'
SET @vector_T='000151435550B400'

SELECT 
 CtaCte.IdCtaCte as [IdCtaCte],
 CtaCte.IdImputacion as [IdImputacion],
 CtaCte.IdComprobante as [IdComprobante],
 TiposComprobante.DescripcionAB as [Comp.],
 Case When CtaCte.IdTipoComp<>14 Then Substring(IsNull(cp.Letra+'-'+Convert(varchar,cp.NumeroComprobante1)+'-'+Convert(Varchar,cp.NumeroComprobante2),Convert(varchar,CtaCte.NumeroComprobante)),1,15) Else Null End as [Nro.comp.],
 CtaCte.NumeroComprobante as [Numero],
 CtaCte.Fecha as [Fecha],
 Null as [Pedido],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal Else CtaCte.ImporteTotal*-1 End as [Imp.orig.],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.Saldo Else CtaCte.Saldo*-1 End as [Saldo Comp.],
 CtaCte.SaldoTrs,
 CtaCte.Marca as [*],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago 
	Then IsNull(Convert(varchar(1000),OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else IsNull(Convert(varchar(1000),cp.Observaciones),'')
 End as [Observaciones],
 IsNull((Select Top 1 cca.Fecha From CuentasCorrientesAcreedores cca Where cca.IdCtaCte=CtaCte.IdImputacion),CtaCte.Fecha) as [FechaImputacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=CtaCte.IdComprobante
WHERE (CtaCte.IdProveedor=@IdProveedor)
ORDER BY [FechaImputacion], [IdImputacion], [Fecha]