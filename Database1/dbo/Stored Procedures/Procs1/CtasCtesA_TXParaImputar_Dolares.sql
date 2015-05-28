CREATE Procedure [dbo].[CtasCtesA_TXParaImputar_Dolares]

@IdProveedor int

AS 

Declare @IdTipoComprobanteOrdenPago int
Set @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago
					From Parametros Where Parametros.IdParametro=1)

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001111111111133'
set @vector_T='0001514355501400'

SELECT 
 CtaCte.IdCtaCte,
 CtaCte.IdImputacion,
 CtaCte.IdComprobante,
 TiposComprobante.DescripcionAB as [Comp.],
 CASE 
	WHEN CtaCte.IdTipoComp<>14
	 THEN Substring(cp.Letra+'-'+Convert(varchar,cp.NumeroComprobante1)+'-'+Convert(Varchar,cp.NumeroComprobante2),1,15)
	ELSE Null
 END as [Nro.comp.],
 CtaCte.NumeroComprobante as [Numero],
 CtaCte.Fecha,
 Null as [Pedido],
 CASE 
	WHEN TiposComprobante.Coeficiente=1 THEN CtaCte.ImporteTotalDolar
	ELSE CtaCte.ImporteTotalDolar*-1
 END as [Imp.orig.],
 CASE 
	WHEN TiposComprobante.Coeficiente=1 THEN CtaCte.SaldoDolar
	ELSE CtaCte.SaldoDolar*-1
 END as [Saldo Comp.],
 CtaCte.SaldoTrs,
 CtaCte.Marca as [*],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago 
	Then IsNull(Convert(varchar(1000),OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else IsNull(Convert(varchar(1000),cp.Observaciones),'')
 End as [Observaciones],
 (Select Top 1 cca.Fecha From CuentasCorrientesAcreedores cca Where cca.IdCtaCte=CtaCte.IdImputacion) as [FechaImputacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=CtaCte.IdComprobante
WHERE (CtaCte.IdProveedor=@IdProveedor)
ORDER by CtaCte.IdImputacion,CtaCte.Fecha