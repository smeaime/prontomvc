CREATE  Procedure [dbo].[CertificacionesObras_M]

@IdCertificacionObras int ,
@IdNodoPadre int,
@Depth tinyint,
@Lineage varchar(255),
@TipoNodo int,
@IdObra int,
@Descripcion varchar(200),
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

UPDATE CertificacionesObras
SET
 IdNodoPadre=@IdNodoPadre,
 Depth=@Depth,
 Lineage=@Lineage,
 TipoNodo=@TipoNodo,
 IdObra=@IdObra,
 Descripcion=@Descripcion,
 TipoPartida=@TipoPartida,
 IdUnidad=@IdUnidad,
 UnidadAvance=@UnidadAvance,
 Cantidad=@Cantidad,
 Importe=@Importe,
 NumeroCertificado=@NumeroCertificado,
 Item=@Item,
 Adjunto1=@Adjunto1,
 NumeroProyecto=@NumeroProyecto
WHERE (IdCertificacionObras=@IdCertificacionObras)

RETURN(@IdCertificacionObras)