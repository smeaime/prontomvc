CREATE  Procedure [dbo].[Valores_TX_ADepositar]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111161111133'
SET @vector_T='0293440224500'

SELECT 
 Valores.IdValor,
 Valores.NumeroInterno as [Nro.Int.],
 Valores.IdValor as [IdVal],
 Valores.NumeroValor as [Numero],
 Valores.FechaValor as [Fecha Vto.],
 Valores.Importe as [Importe],
 Monedas.Abreviatura as [Mon.],
 Bancos.Nombre as [Banco origen],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Clientes.RazonSocial as [Cliente],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoValor=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
WHERE Valores.Estado is null and 
	(Valores.IdTipoComprobante<>17 or Valores.IdTipoComprobante is null) and 
	(Select top 1 TiposComprobante.Agrupacion1
	 From TiposComprobante 
	 Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) ='CHEQUES'
ORDER BY Valores.FechaValor,Valores.NumeroInterno