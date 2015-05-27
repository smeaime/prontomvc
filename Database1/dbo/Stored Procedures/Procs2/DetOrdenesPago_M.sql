CREATE Procedure [dbo].[DetOrdenesPago_M]

@IdDetalleOrdenPago int,
@IdOrdenPago int,
@IdImputacion int,
@Importe numeric(18,2),
@ImporteRetencionIVA numeric(18,2),
@ImporteRetencionIngresosBrutos numeric(18,2),
@ImportePagadoSinImpuestos numeric(18,2),
@IdTipoRetencionGanancia int,
@IdIBCondicion int,
@ImporteRetencionSUSS numeric(18,2),
@SaldoAFondoDeReparo numeric(18,2)

AS

UPDATE DetalleOrdenesPago
SET 
 IdOrdenPago=@IdOrdenPago,
 IdImputacion=@IdImputacion,
 Importe=@Importe,
 ImporteRetencionIVA=@ImporteRetencionIVA,
 ImporteRetencionIngresosBrutos=@ImporteRetencionIngresosBrutos,
 ImportePagadoSinImpuestos=@ImportePagadoSinImpuestos,
 IdTipoRetencionGanancia=@IdTipoRetencionGanancia,
 IdIBCondicion=@IdIBCondicion,
 ImporteRetencionSUSS=@ImporteRetencionSUSS,
 SaldoAFondoDeReparo=@SaldoAFondoDeReparo
WHERE (IdDetalleOrdenPago=@IdDetalleOrdenPago)

RETURN(@IdDetalleOrdenPago)
