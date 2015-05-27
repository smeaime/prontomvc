
CREATE PROCEDURE [dbo].[DetOrdenesPagoValores_TXOrdenPago]

@IdOrdenPago int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleOrdenPagoValores INTEGER,
			 Tipo VARCHAR(20),
			 NumeroInterno INTEGER,
			 NumeroValor NUMERIC(12,0),
			 FechaVencimiento DATETIME,
			 Banco VARCHAR(50),
			 Caja VARCHAR(50),
			 Importe NUMERIC(18, 2),
			 Anulado VARCHAR(2),
			 TarjetaCredito VARCHAR(50)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetOP.IdDetalleOrdenPagoValores,
  Case When DetOP.IdValor is not null Then TiposComprobante.DescripcionAB+' (Terc)'
	When IsNull(Valores.Anulado,'NO')='SI' Then TiposComprobante.DescripcionAB+' AN'
	Else TiposComprobante.DescripcionAB
  End,
  DetOP.NumeroInterno,
  DetOP.NumeroValor,
  DetOP.FechaVencimiento,
  Bancos.Nombre,
  Cajas.Descripcion,
  DetOP.Importe,
  IsNull(Valores.Anulado,'NO'),
  TarjetasCredito.Nombre
 FROM DetalleOrdenesPagoValores DetOP
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetOP.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetOP.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetOP.IdCaja
 LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=DetOP.IdTarjetaCredito
 LEFT OUTER JOIN Valores ON Valores.IdDetalleOrdenPagoValores=DetOP.IdDetalleOrdenPagoValores
 WHERE (DetOP.IdOrdenPago = @IdOrdenPago)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111133'
SET @vector_T='019124E3900'

SELECT
 IdDetalleOrdenPagoValores,
 Tipo as [Tipo],
 IdDetalleOrdenPagoValores as [IdAux],
 NumeroInterno as [Nro.Int.],
 NumeroValor as [Numero],
 FechaVencimiento as [Fec.Vto.],
 IsNull(Caja+' ','')+IsNull(TarjetaCredito+' ','')+IsNull(Banco+' ','') as [Banco / Caja],
 Importe,
 Anulado,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
ORDER BY NumeroInterno

DROP TABLE #Auxiliar1
