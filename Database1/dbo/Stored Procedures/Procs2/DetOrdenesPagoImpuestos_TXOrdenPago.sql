CREATE PROCEDURE [dbo].[DetOrdenesPagoImpuestos_TXOrdenPago]

@IdOrdenPago int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 IdDetalleOrdenPagoImpuestos INTEGER,
			 IdOrdenPago INTEGER,
			 Tipo VARCHAR(10),
			 IdTipo INTEGER,
			 IdTipoImpuesto INTEGER,
			 Categoria VARCHAR(50),
			 ImportePagado NUMERIC(18, 2),
			 ImpuestoRetenido NUMERIC(18, 2),
			 PagosMes NUMERIC(18, 2),
			 RetencionesMes NUMERIC(18, 2),
			 MinimoIIBB NUMERIC(18, 2),
			 AlicuotaIIBB NUMERIC(6, 2),
			 AlicuotaConvenioIIBB NUMERIC(6, 2),
			 PorcentajeATomarSobreBase NUMERIC(6, 2),
			 PorcentajeAdicional NUMERIC(6, 2),
			 ImpuestoAdicional NUMERIC(18, 2),
			 NumeroCertificadoRetencionGanancias INTEGER,
			 NumeroCertificadoRetencionIIBB INTEGER,
			 ImporteTotalFacturasMPagadasSujetasARetencion NUMERIC(18, 2),
			 IdDetalleImpuesto INTEGER
			)
INSERT INTO #Auxiliar 
 SELECT
  DetOP.IdDetalleOrdenPagoImpuestos,
  DetOP.IdOrdenPago,
  DetOP.TipoImpuesto,
  Case When IsNull(DetOP.IdTipoRetencionGanancia,0)>0 Then 1 When IsNull(DetOP.IdIBCondicion,0)>0 Then 2 Else 0 End,
  Case When IsNull(DetOP.IdTipoRetencionGanancia,0)>0 Then DetOP.IdTipoRetencionGanancia When IsNull(DetOP.IdIBCondicion,0)>0 Then DetOP.IdIBCondicion Else Null End,
  Null,
  DetOP.ImportePagado,
  DetOP.ImpuestoRetenido,
  0,
  0,
  0,
  DetOP.AlicuotaAplicada,
  DetOP.AlicuotaConvenioAplicada,
  DetOP.PorcentajeATomarSobreBase,
  DetOP.PorcentajeAdicional,
  DetOP.ImpuestoAdicional,
  DetOP.NumeroCertificadoRetencionGanancias,
  DetOP.NumeroCertificadoRetencionIIBB,
  DetOP.ImporteTotalFacturasMPagadasSujetasARetencion,
  DetOP.IdDetalleImpuesto
 FROM DetalleOrdenesPagoImpuestos DetOP
 WHERE DetOP.IdOrdenPago = @IdOrdenPago --and IsNull(DetOP.IdDetalleImpuesto,0)=0

UPDATE #Auxiliar
SET Categoria=(Select Top 1 TiposRetencionGanancia.Descripcion
				From TiposRetencionGanancia 
				Where TiposRetencionGanancia.IdTipoRetencionGanancia=#Auxiliar.IdTipoImpuesto)
WHERE #Auxiliar.IdTipo=1

UPDATE #Auxiliar
SET Categoria=(Select Top 1 IBCondiciones.Descripcion
				From IBCondiciones 
				Where IBCondiciones.IdIBCondicion=#Auxiliar.IdTipoImpuesto)
WHERE #Auxiliar.IdTipo=2

UPDATE #Auxiliar
SET Categoria=(Select Top 1 Descripcion From TiposComprobante 	Where TiposComprobante.IdTipoComprobante=Convert(int,#Auxiliar.Tipo))
WHERE IsNull(#Auxiliar.IdDetalleImpuesto,0)>0

UPDATE #Auxiliar
SET MinimoIIBB=(Select Top 1 IBCondiciones.ImporteTopeMinimo
				From IBCondiciones 
				Where IBCondiciones.IdIBCondicion=#Auxiliar.IdTipoImpuesto)
WHERE #Auxiliar.IdTipo=2

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111117777777711133'
SET @vector_T='00490223223550332500'

SELECT
 IdDetalleOrdenPagoImpuestos,
 IdOrdenPago,
 Tipo as [Tipo],
 IdTipoImpuesto,
 Categoria,
 ImportePagado as [Pago s/imp.],
 ImpuestoRetenido as [Retencion],
 PagosMes as [Pagos mes],
 RetencionesMes as [Ret. mes],
 MinimoIIBB as [Min.IIBB],
 AlicuotaIIBB as [Alicuota.IIBB],
 AlicuotaConvenioIIBB as [Alicuota Conv.Mul.],
 PorcentajeATomarSobreBase as [% a tomar s/base],
 PorcentajeAdicional as [% adic.],
 ImpuestoAdicional as [Impuesto adic.],
 NumeroCertificadoRetencionGanancias as [Certif.Gan.],
 NumeroCertificadoRetencionIIBB as [Certif.IIBB],
 ImporteTotalFacturasMPagadasSujetasARetencion as [Tot.Fact.M a Ret.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
ORDER BY Tipo,Categoria

DROP TABLE #Auxiliar
