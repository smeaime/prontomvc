
CREATE  Procedure [dbo].[Valores_TX_DepositadosNoAcreditadosAFecha]

@Fecha datetime

AS

SELECT SUM(Valores.Importe) as [Importe]
FROM Valores 
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoValor=TiposComprobante.IdTipoComprobante
WHERE Valores.FechaComprobante<=@Fecha and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.Estado='D' and Valores.FechaDeposito<=@Fecha) and 
	(Valores.IdTipoComprobante<>17 or Valores.IdTipoComprobante is null) and 
	IsNull(TiposComprobante.Agrupacion1,'')='CHEQUES' and 
	(IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO' or 
	 (IsNull(Valores.MovimientoConfirmadoBanco,'NO')='SI' and 
	  Valores.FechaConfirmacionBanco>@Fecha))
