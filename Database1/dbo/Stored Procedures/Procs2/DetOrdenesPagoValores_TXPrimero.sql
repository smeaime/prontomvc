
CREATE PROCEDURE [dbo].[DetOrdenesPagoValores_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111133'
SET @vector_T='01912425900'

SELECT TOP 1
 DetOP.IdDetalleOrdenPagoValores,
 Case When DetOP.IdValor is not null Then TiposComprobante.DescripcionAB+' (Terc)'
	When IsNull(Valores.Anulado,'NO')='SI' Then TiposComprobante.DescripcionAB+' AN'
	Else TiposComprobante.DescripcionAB
 End [Tipo],
 DetOP.IdDetalleOrdenPagoValores as [IdAux],
 DetOP.NumeroInterno as [Nro.Int.],
 DetOP.NumeroValor as [Numero],
 DetOP.FechaVencimiento as [Fec.Vto.],
 Bancos.Nombre as [Banco / Caja],
 DetOP.Importe,
 IsNull(Valores.Anulado,'NO') as [Anulado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPagoValores DetOP
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetOP.IdTipoValor
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetOP.IdBanco
LEFT OUTER JOIN Valores ON Valores.IdDetalleOrdenPagoValores=DetOP.IdDetalleOrdenPagoValores
