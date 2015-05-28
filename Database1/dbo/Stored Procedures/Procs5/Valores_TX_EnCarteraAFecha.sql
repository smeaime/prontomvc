CREATE  Procedure [dbo].[Valores_TX_EnCarteraAFecha]

@Fecha datetime

AS

SELECT SUM(Valores.Importe) as [Importe]
FROM Valores 
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoValor=TiposComprobante.IdTipoComprobante
WHERE Valores.FechaComprobante<=@Fecha and 
	(Valores.Estado is null or (Valores.Estado='D' and Valores.FechaDeposito>@Fecha)) and 
	(Valores.IdTipoComprobante<>17 or Valores.IdTipoComprobante is null) and 
	IsNull(TiposComprobante.Agrupacion1,'')='CHEQUES'