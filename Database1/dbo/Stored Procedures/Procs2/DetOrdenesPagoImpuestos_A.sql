CREATE Procedure [dbo].[DetOrdenesPagoImpuestos_A]

@IdDetalleOrdenPagoImpuestos int  output,
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

INSERT INTO [DetalleOrdenesPagoImpuestos]
(
 IdOrdenPago,
 TipoImpuesto,
 IdTipoRetencionGanancia,
 ImportePagado,
 ImpuestoRetenido,
 IdIBCondicion,
 NumeroCertificadoRetencionGanancias,
 NumeroCertificadoRetencionIIBB,
 AlicuotaAplicada,
 AlicuotaConvenioAplicada,
 PorcentajeATomarSobreBase,
 PorcentajeAdicional,
 ImpuestoAdicional,
 LeyendaPorcentajeAdicional,
 ImporteTotalFacturasMPagadasSujetasARetencion,
 IdDetalleImpuesto
)
VALUES
(
 @IdOrdenPago,
 @TipoImpuesto,
 @IdTipoRetencionGanancia,
 @ImportePagado,
 @ImpuestoRetenido,
 @IdIBCondicion,
 @NumeroCertificadoRetencionGanancias,
 @NumeroCertificadoRetencionIIBB,
 @AlicuotaAplicada,
 @AlicuotaConvenioAplicada,
 @PorcentajeATomarSobreBase,
 @PorcentajeAdicional,
 @ImpuestoAdicional,
 @LeyendaPorcentajeAdicional,
 @ImporteTotalFacturasMPagadasSujetasARetencion,
 @IdDetalleImpuesto
)

SELECT @IdDetalleOrdenPagoImpuestos=@@identity

RETURN(@IdDetalleOrdenPagoImpuestos)