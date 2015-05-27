CREATE Procedure [dbo].[DetImpuestos_TXDet]

@IdImpuesto int

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobante int, @vector_X varchar(30), @vector_T varchar(30)

SET @IdTipoComprobante=IsNull((Select Top 1 IdTipoComprobante From Impuestos Where IdImpuesto=@IdImpuesto),0)

CREATE TABLE #Auxiliar 
			(
			 IdDetalleOrdenPagoImpuestos INTEGER,
			 IdOrdenPago INTEGER,
			 IdDetalleImpuesto INTEGER,
			 NumeroOrdenPago INTEGER,
			 FechaOrdenPago DATETIME
			)
INSERT INTO #Auxiliar 
 SELECT
  dopi.IdDetalleOrdenPagoImpuestos,
  dopi.IdOrdenPago,
  dopi.IdDetalleImpuesto,
  OrdenesPago.NumeroOrdenPago,
  OrdenesPago.FechaOrdenPago
 FROM DetalleOrdenesPagoImpuestos dopi
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopi.IdOrdenPago
 WHERE dopi.IdDetalleImpuesto is not null and 
	Exists(Select Top 1 di.IdDetalleImpuesto From DetalleImpuestos di Where di.IdDetalleImpuesto=dopi.IdDetalleImpuesto and di.IdImpuesto=@IdImpuesto)

SET NOCOUNT OFF

SET @vector_X='0011111111111133'
IF @IdTipoComprobante=110
	SET @vector_T='0055599995555500'
ELSE
	SET @vector_T='0059955555555500'

SELECT
 di.IdDetalleImpuesto,
 di.IdImpuesto,
 di.Cuota as [Cuota],
 di.Año as [Año],
 di.Importe as [Importe],
 di.Importe as [Capital],
 di.Intereses1 as [Int.Fin.],
 di.Intereses2 as [Int.Resarc.],
 IsNull(di.Importe,0)+IsNull(di.Intereses1,0)+IsNull(di.Intereses2,0) as [Subtotal],
 di.FechaVencimiento1 as [Fecha Vto.1],
 di.FechaVencimiento2 as [Fecha Vto.2],
 di.FechaVencimiento3 as [Fecha Vto.3],
 (Select Top 1 NumeroOrdenPago From #Auxiliar a Where a.IdDetalleImpuesto=di.IdDetalleImpuesto) as [Nro.OP],
 (Select Top 1 FechaOrdenPago From #Auxiliar a Where a.IdDetalleImpuesto=di.IdDetalleImpuesto) as [Fecha OP],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleImpuestos di 
WHERE (di.IdImpuesto = @IdImpuesto)
ORDER BY di.Año, di.Cuota

DROP TABLE #Auxiliar