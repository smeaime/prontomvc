




CREATE Procedure [dbo].[CtasCtesA_TX_PorTrsParaCubo]

@FechaLimite datetime

AS 

Declare @IdTempCtaCte int
Set @IdTempCtaCte=0

SELECT 
 @IdTempCtaCte as [IdTempCtaCte],
 IdCtaCte,
 IdProveedor,
 Fecha,
 IdTipoComp,
 IdComprobante,
 NumeroComprobante,
 IdImputacion,
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal*-1
	Else CtaCte.ImporteTotal
 End as [ImporteTotal],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal*-1
	Else CtaCte.ImporteTotal
 End as [Saldo],
 Case When CtaCte.IdCtaCte=IsNull(CtaCte.IdImputacion,0) Then '0' Else '1' End as [Cabeza]
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE CtaCte.Fecha<=@FechaLimite
ORDER BY CtaCte.IdProveedor,CtaCte.IdImputacion,[Cabeza],CtaCte.Fecha,CtaCte.NumeroComprobante




