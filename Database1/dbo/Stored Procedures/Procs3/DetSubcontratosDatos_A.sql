CREATE Procedure [dbo].[DetSubcontratosDatos_A]

@IdDetalleSubcontratoDatos int  output,
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

INSERT INTO [DetalleSubcontratosDatos]
(
 IdSubcontratoDatos,
 NumeroCertificado,
 FechaCertificado,
 PorcentajeCertificacion,
 PorcentajeFondoReparo,
 OtrosDescuentos,
 PorcentajeIVA,
 Observaciones,
 FechaCertificadoDesde,
 FechaCertificadoHasta,
 IdAprobo,
 CircuitoFirmasCompleto
)
VALUES 
(
 @IdSubcontratoDatos,
 @NumeroCertificado,
 @FechaCertificado,
 @PorcentajeCertificacion,
 @PorcentajeFondoReparo,
 @OtrosDescuentos,
 @PorcentajeIVA,
 @Observaciones,
 @FechaCertificadoDesde,
 @FechaCertificadoHasta,
 @IdAprobo,
 @CircuitoFirmasCompleto
)

SELECT @IdDetalleSubcontratoDatos=@@identity

RETURN(@IdDetalleSubcontratoDatos)