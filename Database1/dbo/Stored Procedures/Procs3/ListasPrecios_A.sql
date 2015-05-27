CREATE Procedure [dbo].[ListasPrecios_A]

@IdListaPrecios int  output,
@Descripcion varchar(50),
@NumeroLista int,
@FechaVigencia Datetime,
@Activa varchar(2),
@IdMoneda int,
@DescripcionPrecio1 varchar(20),
@DescripcionPrecio2 varchar(20),
@DescripcionPrecio3 varchar(20),
@IdObra int

AS 

INSERT INTO ListasPrecios
(
 Descripcion,
 NumeroLista,
 FechaVigencia,
 Activa,
 IdMoneda,
 DescripcionPrecio1,
 DescripcionPrecio2,
 DescripcionPrecio3,
 IdObra
)
VALUES
(
 @Descripcion,
 @NumeroLista,
 @FechaVigencia,
 @Activa,
 @IdMoneda,
 @DescripcionPrecio1,
 @DescripcionPrecio2,
 @DescripcionPrecio3,
 @IdObra
)

SELECT @IdListaPrecios=@@identity

RETURN(@IdListaPrecios)