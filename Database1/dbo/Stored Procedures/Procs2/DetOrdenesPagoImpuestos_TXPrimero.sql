CREATE PROCEDURE [dbo].[DetOrdenesPagoImpuestos_TXPrimero]

AS

Declare @PagosMes numeric(18,2),@RetencionesMes numeric(18,2),
	@MinimoIIBB numeric(18,2),@AlicuotaIIBB numeric(6,2),
	@AlicuotaConvenioIIBB numeric(6,2)
Set @PagosMes=0
Set @RetencionesMes=0
Set @MinimoIIBB=0
Set @AlicuotaIIBB=0
Set @AlicuotaConvenioIIBB=0

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='00111117777777711133'
Set @vector_T='00490223223550332500'

SELECT TOP 1
 DetOP.IdDetalleOrdenPagoImpuestos,
 DetOP.IdOrdenPago,
 DetOP.TipoImpuesto as [Tipo],
 DetOP.IdTipoRetencionGanancia as [IdTipoImpuesto],
 TiposRetencionGanancia.Descripcion as [Categoria],
 DetOP.ImportePagado as [Pago s/imp.],
 DetOP.ImpuestoRetenido as [Retencion],
 @PagosMes as [Pagos mes],
 @RetencionesMes as [Ret. mes],
 @MinimoIIBB as [Min.IIBB],
 @AlicuotaIIBB as [Alicuota.IIBB],
 @AlicuotaConvenioIIBB as [Alicuota Conv.Mul.],
 PorcentajeATomarSobreBase as [% a tomar s/base],
 PorcentajeAdicional as [% adic.],
 ImpuestoAdicional as [Impuesto adic.],
 Null as [Certif.Gan.],
 Null as [Certif.IIBB],
 ImporteTotalFacturasMPagadasSujetasARetencion as [Tot.Fact.M a Ret.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPagoImpuestos DetOP
LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=DetOP.IdTipoRetencionGanancia