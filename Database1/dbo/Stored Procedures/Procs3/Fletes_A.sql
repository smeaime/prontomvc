CREATE Procedure [dbo].[Fletes_A]

@IdFlete int  output,
@Descripcion varchar(50),
@Patente varchar(6),
@NumeroInterno int,
@IdTransportista int,
@IdChofer int,
@Capacidad numeric(18,2),
@Tara int,
@TouchCarga varchar(5),
@TouchDescarga varchar(5),
@IdMarca int, 
@IdModelo int, 
@Año int, 
@Ancho numeric(6,2),
@Largo numeric(6,2),
@Alto numeric(6,2),
@ModalidadFacturacion tinyint,
@IdTarifaFlete int,
@PathImagen1 varchar(200),
@IdOrigenTransmision int

AS 

INSERT INTO [Fletes]
(
 Descripcion,
 Patente,
 NumeroInterno,
 IdTransportista,
 IdChofer,
 Capacidad,
 Tara,
 TouchCarga,
 TouchDescarga,
 IdMarca, 
 IdModelo,
 Año,
 Ancho,
 Largo,
 Alto,
 ModalidadFacturacion,
 IdTarifaFlete,
 PathImagen1,
 IdOrigenTransmision
)
VALUES
(
 @Descripcion,
 @Patente,
 @NumeroInterno,
 @IdTransportista,
 @IdChofer,
 @Capacidad,
 @Tara,
 @TouchCarga,
 @TouchDescarga,
 @IdMarca, 
 @IdModelo,
 @Año,
 @Ancho,
 @Largo,
 @Alto,
 @ModalidadFacturacion,
 @IdTarifaFlete,
 @PathImagen1,
 @IdOrigenTransmision
)

SELECT @IdFlete=@@identity

RETURN(@IdFlete)