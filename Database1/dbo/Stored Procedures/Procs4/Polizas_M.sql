CREATE  Procedure [dbo].[Polizas_M]

@IdPoliza int ,
@Tipo varchar(50),
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

UPDATE Polizas
SET
 Tipo=@Tipo,
 Numero=@Numero,
 IdProveedor=@IdProveedor,
 FechaVigencia=@FechaVigencia,
 FechaFinalizacionCobertura=@FechaFinalizacionCobertura,
 FechaVencimientoPrimerCuota=@FechaVencimientoPrimerCuota,
 CantidadCuotas=@CantidadCuotas,
 ImporteAsegurado=@ImporteAsegurado,
 ImportePrima=@ImportePrima,
 ImportePremio=@ImportePremio,
 MotivoContratacion=@MotivoContratacion,
 Observaciones=@Observaciones,
 NumeroEndoso=@NumeroEndoso,
 TipoFacturacion=@TipoFacturacion,
 Certificado=@Certificado,
 IdTipoPoliza=@IdTipoPoliza,
 IdMoneda=@IdMoneda
WHERE (IdPoliza=@IdPoliza)

RETURN(@IdPoliza)