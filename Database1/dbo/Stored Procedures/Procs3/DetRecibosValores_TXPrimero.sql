
CREATE PROCEDURE [dbo].[DetRecibosValores_TXPrimero]

As

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111111133'
set @vector_T='0010414300'

SELECT TOP 1
 DetRec.IdDetalleReciboValores,
 TiposComprobante.DescripcionAB as [Tipo],
 DetRec.NumeroInterno as [Nro.Int.],
 DetRec.NumeroValor as [Numero],
 DetRec.FechaVencimiento as [Fec.Vto.],
 Bancos.Nombre as [Banco / Caja],
 DetRec.Importe,
 DetRec.CuitLibrador,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecibosValores DetRec
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetRec.IdTipoValor
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetRec.IdBanco
