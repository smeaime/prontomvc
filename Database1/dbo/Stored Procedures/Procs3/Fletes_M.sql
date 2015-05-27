CREATE  Procedure [dbo].[Fletes_M]

@IdFlete int ,
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

UPDATE Fletes
SET
 Descripcion=@Descripcion,
 Patente=@Patente,
 NumeroInterno=@NumeroInterno,
 IdTransportista=@IdTransportista,
 IdChofer=@IdChofer,
 Capacidad=@Capacidad,
 Tara=@Tara,
 TouchCarga=@TouchCarga,
 TouchDescarga=@TouchDescarga,
 IdMarca=@IdMarca,
 IdModelo=@IdModelo,
 Año=@Año,
 Ancho=@Ancho,
 Largo=@Largo,
 Alto=@Alto,
 ModalidadFacturacion=@ModalidadFacturacion,
 IdTarifaFlete=@IdTarifaFlete,
 PathImagen1=@PathImagen1,
 IdOrigenTransmision=@IdOrigenTransmision
WHERE (IdFlete=@IdFlete)

RETURN(@IdFlete)