CREATE Procedure [dbo].[DetFletes_A]

@IdDetalleFlete int  output,
@IdFlete int,
@Fecha datetime,
@Tara numeric(18,2),
@Ancho numeric(6,2),
@Largo numeric(6,2),
@Alto numeric(6,2),
@Capacidad numeric(18,2),
@Patente varchar(2),
@IdOrigenTransmision int

AS 

INSERT INTO [DetalleFletes]
(
 IdFlete,
 Fecha,
 Tara,
 Ancho,
 Largo,
 Alto,
 Capacidad,
 Patente,
 IdOrigenTransmision
)
VALUES
(
 @IdFlete,
 @Fecha,
 @Tara,
 @Ancho,
 @Largo,
 @Alto,
 @Capacidad,
 @Patente,
 @IdOrigenTransmision
)

SELECT @IdDetalleFlete=@@identity

RETURN(@IdDetalleFlete)