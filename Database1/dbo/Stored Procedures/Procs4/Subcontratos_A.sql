
CREATE Procedure [dbo].[Subcontratos_A]

@IdSubcontrato int output,
@IdNodoPadre int,
@Depth tinyint,
@Lineage varchar(255),
@TipoNodo int,
@Descripcion varchar(255),
@TipoPartida tinyint,
@IdUnidad int,
@UnidadAvance varchar(1),
@Cantidad numeric(18,2),
@Importe numeric(18,2),
@NumeroSubcontrato int,
@Item varchar(20)

AS 

INSERT INTO [Subcontratos]
(
 IdNodoPadre,
 Depth,
 Lineage,
 TipoNodo,
 Descripcion,
 TipoPartida,
 IdUnidad,
 UnidadAvance,
 Importe,
 Cantidad,
 NumeroSubcontrato,
 Item
)
VALUES
(
 @IdNodoPadre,
 @Depth,
 @Lineage,
 @TipoNodo,
 @Descripcion,
 @TipoPartida,
 @IdUnidad,
 @UnidadAvance,
 @Importe,
 @Cantidad,
 @NumeroSubcontrato,
 @Item
)

SELECT @IdSubcontrato=@@identity
RETURN(@IdSubcontrato)
