CREATE Procedure [dbo].[DetOrdenesPagoImpuestos_M]

@IdDetalleOrdenPagoImpuestos int,
@IdOrdenPago int,
@TipoImpuesto varchar(10),
@IdTipoRetencionGanancia int,
@ImportePagado numeric(18,2),
@ImpuestoRetenido numeric(18,2),
@IdIBCondicion int,
@NumeroCertificadoRetencionGanancias int,
@NumeroCertificadoRetencionIIBB int,
@AlicuotaAplicada numeric(6,2),
@AlicuotaConvenioAplicada numeric(6,2),
@PorcentajeATomarSobreBase numeric(6,2),
@PorcentajeAdicional numeric(6,2),
@ImpuestoAdicional numeric(18,2),
@LeyendaPorcentajeAdicional varchar(50),
@ImporteTotalFacturasMPagadasSujetasARetencion numeric(18,2),
@IdDetalleImpuesto int

AS

UPDATE DetalleOrdenesPagoImpuestos
SET 
 IdOrdenPago=@IdOrdenPago,
 TipoImpuesto=@TipoImpuesto,
 IdTipoRetencionGanancia=@IdTipoRetencionGanancia,
 ImportePagado=@ImportePagado,
 ImpuestoRetenido=@ImpuestoRetenido,
 IdIBCondicion=@IdIBCondicion,
 NumeroCertificadoRetencionGanancias=@NumeroCertificadoRetencionGanancias,
 NumeroCertificadoRetencionIIBB=@NumeroCertificadoRetencionIIBB,
 AlicuotaAplicada=@AlicuotaAplicada,
 AlicuotaConvenioAplicada=@AlicuotaConvenioAplicada,
 PorcentajeATomarSobreBase=@PorcentajeATomarSobreBase,
 PorcentajeAdicional=@PorcentajeAdicional,
 ImpuestoAdicional=@ImpuestoAdicional,
 LeyendaPorcentajeAdicional=@LeyendaPorcentajeAdicional,
 ImporteTotalFacturasMPagadasSujetasARetencion=@ImporteTotalFacturasMPagadasSujetasARetencion,
 IdDetalleImpuesto=@IdDetalleImpuesto
WHERE (IdDetalleOrdenPagoImpuestos=@IdDetalleOrdenPagoImpuestos)

RETURN(@IdDetalleOrdenPagoImpuestos)