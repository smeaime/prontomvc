
CREATE  Procedure [dbo].[Subcontratos_M]

@IdSubcontrato int ,
@IdNodoPadre int,
@Depth tinyint,
@Lineage varchar(255),
@TipoNodo int,
@Descripcion varchar(200),
@TipoPartida tinyint,
@IdUnidad int,
@UnidadAvance varchar(1),
@Cantidad numeric(18,2),
@Importe numeric(18,2),
@NumeroSubcontrato int,
@Item varchar(20)

AS

UPDATE Subcontratos
SET
 IdNodoPadre=@IdNodoPadre,
 Depth=@Depth,
 Lineage=@Lineage,
 TipoNodo=@TipoNodo,
 Descripcion=@Descripcion,
 TipoPartida=@TipoPartida,
 IdUnidad=@IdUnidad,
 UnidadAvance=@UnidadAvance,
 Importe=@Importe,
 Cantidad=@Cantidad,
 NumeroSubcontrato=@NumeroSubcontrato,
 Item=@Item
WHERE (IdSubcontrato=@IdSubcontrato)

RETURN(@IdSubcontrato)
