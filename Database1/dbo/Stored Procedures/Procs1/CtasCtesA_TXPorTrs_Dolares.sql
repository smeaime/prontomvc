
CREATE Procedure [dbo].[CtasCtesA_TXPorTrs_Dolares]

@IdProveedor int,
@Todo int,
@FechaLimite datetime,
@FechaDesde datetime = Null

AS 

SET @FechaDesde=IsNull(@FechaDesde,Convert(datetime,'1/1/2000'))

DECLARE @IdTipoComprobanteOrdenPago int, @SaldoInicial numeric(18,2)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago
					From Parametros Where Parametros.IdParametro=1)

DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)
SET @vector_X='00111111188111111511133'
SET @vector_T='00099714455449993599900'
SET @vector_E='  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  |  '

SELECT 
 CtaCte.IdCtaCte,
 CtaCte.IdImputacion,
 TiposComprobante.DescripcionAB as [Comp.],
 CtaCte.IdTipoComp,
 CtaCte.IdComprobante,
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16 or 
		cp.IdComprobanteProveedor is null
	Then Substring(Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+
		Convert(varchar,CtaCte.NumeroComprobante),1,15)
	Else Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2),1,15)
 End as [Numero],
 CtaCte.NumeroComprobante as [Ref.],
 CtaCte.Fecha,
 CtaCte.FechaVencimiento as [Fecha vto.],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotalDolar*-1
	Else CtaCte.ImporteTotalDolar
 End as [Imp.orig.],
 Case When @Todo=-1
	Then 	Case When TiposComprobante.Coeficiente=1 Then CtaCte.SaldoDolar*-1
			Else CtaCte.SaldoDolar
		End 
	Else 	Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotalDolar*-1
			Else CtaCte.ImporteTotalDolar
		End 
 End as [Saldo Comp.],
 CtaCte.SaldoTrs,
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16
	Then Null
	Else cp.FechaComprobante 
 End as [Fecha cmp.],
 CtaCte.IdImputacion as [IdImpu],
 Convert(Numeric(18,2),CtaCte.Saldo)*TiposComprobante.Coeficiente*-1 as [Saldo],
 Case When CtaCte.IdCtaCte=IsNull(CtaCte.IdImputacion,0) Then '0' Else '1' End as [Cabeza],
 Monedas.Abreviatura as [Mon.origen],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago 
	Then IsNull(Convert(varchar(1000),OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else IsNull(Convert(varchar(1000),cp.Observaciones),'')
 End as [Observaciones],
 CtaCte.IdProveedor,
 CtaCte.IdCtaCte as [IdAux1],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and 
				CtaCte.IdTipoComp<>@IdTipoComprobanteOrdenPago and CtaCte.IdTipoComp<>16
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=CtaCte.IdComprobante and 
				(CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16)
LEFT OUTER JOIN Monedas ON CtaCte.IdMoneda=Monedas.IdMoneda
WHERE CtaCte.IdProveedor=@IdProveedor and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite)
ORDER by CtaCte.IdImputacion,[Cabeza],CtaCte.Fecha,CtaCte.NumeroComprobante
