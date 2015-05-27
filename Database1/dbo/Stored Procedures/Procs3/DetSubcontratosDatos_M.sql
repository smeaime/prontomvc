CREATE Procedure [dbo].[DetSubcontratosDatos_M]

@IdDetalleSubcontratoDatos int,
@IdSubcontratoDatos int,
@NumeroCertificado int,
@FechaCertificado datetime,
@PorcentajeCertificacion numeric(6,2),
@PorcentajeFondoReparo numeric(6,2),
@OtrosDescuentos numeric(18,2),
@PorcentajeIVA numeric(6,2),
@Observaciones ntext,
@FechaCertificadoDesde datetime,
@FechaCertificadoHasta datetime,
@IdAprobo int,
@CircuitoFirmasCompleto varchar(2)

AS

UPDATE [DetalleSubcontratosDatos]
SET 
 IdSubcontratoDatos=@IdSubcontratoDatos,
 NumeroCertificado=@NumeroCertificado,
 FechaCertificado=@FechaCertificado,
 PorcentajeCertificacion=@PorcentajeCertificacion,
 PorcentajeFondoReparo=@PorcentajeFondoReparo,
 OtrosDescuentos=@OtrosDescuentos,
 PorcentajeIVA=@PorcentajeIVA,
 Observaciones=@Observaciones,
 FechaCertificadoDesde=@FechaCertificadoDesde,
 FechaCertificadoHasta=@FechaCertificadoHasta,
 IdAprobo=@IdAprobo,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto
WHERE (IdDetalleSubcontratoDatos=@IdDetalleSubcontratoDatos)

RETURN(@IdDetalleSubcontratoDatos)