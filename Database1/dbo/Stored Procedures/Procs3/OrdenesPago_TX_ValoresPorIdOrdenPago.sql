CREATE PROCEDURE [dbo].[OrdenesPago_TX_ValoresPorIdOrdenPago]

@IdOrdenPago int,
@ConAnulados varchar(2) = Null

AS 

SET @ConAnulados=IsNull(@ConAnulados,'NO')

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00001111011111133'
SET @vector_T='00000224035399900'

SELECT
 DetOP.IdDetalleOrdenPagoValores,
 DetOP.IdOrdenPago,
 DetOP.IdTipoValor,
 DetOP.IdValor,
 Case When DetOP.IdValor is not null Then TiposComprobante.DescripcionAB+' (Terc.)'
	When IsNull(Valores.Anulado,'NO')='SI' Then TiposComprobante.DescripcionAB+' AN'
	Else TiposComprobante.DescripcionAB
 End  as [Tipo],
 DetOP.NumeroInterno as [Nro.Int.],
 DetOP.NumeroValor as [Numero],
 DetOP.FechaVencimiento as [Fec.Vto.],
 DetOP.IdBanco,
 Bancos.Nombre as [Banco],
 DetOP.Importe,
 Cajas.Descripcion as [Caja],
 DetOP.ChequesALaOrdenDe,
 OrdenesPago.NumeroOrdenPago as [NumeroOrdenPago], 
 OrdenesPago.FechaOrdenPago as [FechaOrdenPago], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPagoValores DetOP
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetOP.IdTipoValor
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetOP.IdBanco
LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetOP.IdCaja
LEFT OUTER JOIN Valores ON Valores.IdDetalleOrdenPagoValores=DetOP.IdDetalleOrdenPagoValores
WHERE DetOP.IdOrdenPago = @IdOrdenPago and 
	(@ConAnulados='SI' or IsNull(Valores.Anulado,'NO')<>'SI' or IsNull(OrdenesPago.Anulada,'NO')='SI')
ORDER BY  DetOP.FechaVencimiento, DetOP.NumeroValor