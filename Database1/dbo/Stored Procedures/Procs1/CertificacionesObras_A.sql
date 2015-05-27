CREATE Procedure [dbo].[CertificacionesObras_A]

@IdCertificacionObras int output,
@IdNodoPadre int,
@Depth tinyint,
@Lineage varchar(255),
@TipoNodo int,
@IdObra int,
@Descripcion varchar(255),
@TipoPartida tinyint,
@IdUnidad int,
@UnidadAvance varchar(1),
@Cantidad numeric(18,2),
@Importe numeric(18,4),
@NumeroCertificado int,
@Item varchar(10),
@Adjunto1 varchar(100),
@NumeroProyecto int

AS 

INSERT INTO [CertificacionesObras]
(
 IdNodoPadre,
 Depth,
 Lineage,
 TipoNodo,
 IdObra,
 Descripcion,
 TipoPartida,
 IdUnidad,
 UnidadAvance,
 Cantidad,
 Importe,
 NumeroCertificado,
 Item,
 Adjunto1,
 NumeroProyecto
)
VALUES
(
 @IdNodoPadre,
 @Depth,
 @Lineage,
 @TipoNodo,
 @IdObra,
 @Descripcion,
 @TipoPartida,
 @IdUnidad,
 @UnidadAvance,
 @Cantidad,
 @Importe,
 @NumeroCertificado,
 @Item,
 @Adjunto1,
 @NumeroProyecto
)

SELECT @IdCertificacionObras=@@identity

RETURN(@IdCertificacionObras)