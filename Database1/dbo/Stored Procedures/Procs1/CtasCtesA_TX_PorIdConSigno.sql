



CREATE Procedure [dbo].[CtasCtesA_TX_PorIdConSigno]

@IdCtaCte int

AS 

Declare @IdTipoComprobanteOrdenPago int
Set @IdTipoComprobanteOrdenPago=IsNull((Select Top 1 Parametros.IdTipoComprobanteOrdenPago
					From Parametros Where Parametros.IdParametro=1),0)

SELECT 
 CtaCte.*,
 TiposComprobante.Coeficiente * -1 as [Coeficiente],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16
	Then CtaCte.Fecha
	Else cp.FechaComprobante 
 End as [FechaComprobante],
 IsNull(TiposComprobante.Agrupacion1,'') as [ComprobanteGrupo]
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante
WHERE (IdCtaCte=@IdCtaCte)



