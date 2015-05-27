CREATE Procedure [dbo].[Polizas_A]

@IdPoliza int  output,
@Tipo varchar(10),
@Numero varchar(30),
@IdProveedor int,
@FechaVigencia datetime,
@FechaFinalizacionCobertura datetime,
@FechaVencimientoPrimerCuota datetime,
@CantidadCuotas int,
@ImporteAsegurado numeric(18,2),
@ImportePrima numeric(18,2),
@ImportePremio numeric(18,2),
@MotivoContratacion ntext,
@Observaciones ntext,
@NumeroEndoso varchar(30),
@TipoFacturacion int,
@Certificado varchar(30),
@IdTipoPoliza int,
@IdMoneda int

AS 

INSERT INTO [Polizas]
(
 Tipo,
 Numero,
 IdProveedor,
 FechaVigencia,
 FechaFinalizacionCobertura,
 FechaVencimientoPrimerCuota,
 CantidadCuotas,
 ImporteAsegurado,
 ImportePrima,
 ImportePremio,
 MotivoContratacion,
 Observaciones,
 NumeroEndoso,
 TipoFacturacion,
 Certificado,
 IdTipoPoliza,
 IdMoneda
)
VALUES
(
 @Tipo,
 @Numero,
 @IdProveedor,
 @FechaVigencia,
 @FechaFinalizacionCobertura,
 @FechaVencimientoPrimerCuota,
 @CantidadCuotas,
 @ImporteAsegurado,
 @ImportePrima,
 @ImportePremio,
 @MotivoContratacion,
 @Observaciones,
 @NumeroEndoso,
 @TipoFacturacion,
 @Certificado,
 @IdTipoPoliza,
 @IdMoneda
)

SELECT @IdPoliza=@@identity

RETURN(@IdPoliza)