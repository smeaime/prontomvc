CREATE  Procedure [dbo].[OrdenesPago_TX_PorRendicionFF]

@IdCuentaFF int,
@NumeroRendicionFF int

AS

SELECT 
	Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)+
	' del '+Convert(varchar,OrdenesPago.FechaOrdenPago,103)+' '+IsNull(Monedas.Abreviatura,'')+
	' '+Convert(varchar,OrdenesPago.Valores) as [OP], OrdenesPago.IdOrdenPago
FROM OrdenesPago
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=OrdenesPago.IdMoneda
WHERE IsNull(OrdenesPago.Anulada,'')<>'SI' and IsNull(OrdenesPago.IdCuenta,0)=@IdCuentaFF and IsNull(OrdenesPago.NumeroRendicionFF,0)=@NumeroRendicionFF
ORDER BY OrdenesPago.FechaOrdenPago, OrdenesPago.NumeroOrdenPago