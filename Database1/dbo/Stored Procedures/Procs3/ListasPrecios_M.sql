CREATE  Procedure [dbo].[ListasPrecios_M]

@IdListaPrecios int ,
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

UPDATE ListasPrecios
SET 
 Descripcion=@Descripcion,
 NumeroLista=@NumeroLista,
 FechaVigencia=@FechaVigencia,
 Activa=@Activa,
 IdMoneda=@IdMoneda,
 DescripcionPrecio1=@DescripcionPrecio1,
 DescripcionPrecio2=@DescripcionPrecio2,
 DescripcionPrecio3=@DescripcionPrecio3,
 IdObra=@IdObra
WHERE (IdListaPrecios=@IdListaPrecios)

RETURN(@IdListaPrecios)