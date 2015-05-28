CREATE Procedure [dbo].[DetOrdenesPago_A]

@IdDetalleOrdenPago int  output,
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

INSERT INTO [DetalleOrdenesPago]
(
 IdOrdenPago,
 IdImputacion,
 Importe,
 ImporteRetencionIVA,
 ImporteRetencionIngresosBrutos,
 ImportePagadoSinImpuestos,
 IdTipoRetencionGanancia,
 IdIBCondicion,
 ImporteRetencionSUSS,
 SaldoAFondoDeReparo
)
VALUES
(
 @IdOrdenPago,
 @IdImputacion,
 @Importe,
 @ImporteRetencionIVA,
 @ImporteRetencionIngresosBrutos,
 @ImportePagadoSinImpuestos,
 @IdTipoRetencionGanancia,
 @IdIBCondicion,
 @ImporteRetencionSUSS,
 @SaldoAFondoDeReparo
)

SELECT @IdDetalleOrdenPago=@@identity

RETURN(@IdDetalleOrdenPago)