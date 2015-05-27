
CREATE Procedure [dbo].[ArchivosATransmitirDestinos_A]

@IdArchivoATransmitirDestino int  output,
@Descripcion varchar(50),
@Tipo int,
@Email varchar(50),
@Activo varchar(2),
@Nombre varchar(50),
@Direccion varchar(50),
@Localidad varchar(50),
@Telefono varchar(50),
@Celular varchar(50),
@Horario varchar(50),
@Contacto varchar(50),
@Observaciones ntext,
@Sistema varchar(20),
@IdObra int

As 

Insert into [ArchivosATransmitirDestinos]
(
 Descripcion,
 Tipo,
 Email,
 Activo,
 Nombre,
 Direccion,
 Localidad,
 Telefono,
 Celular,
 Horario,
 Contacto,
 Observaciones,
 Sistema,
 IdObra
)
Values
(
 @Descripcion,
 @Tipo,
 @Email,
 @Activo,
 @Nombre,
 @Direccion,
 @Localidad,
 @Telefono,
 @Celular,
 @Horario,
 @Contacto,
 @Observaciones,
 @Sistema,
 @IdObra
)

Select @IdArchivoATransmitirDestino=@@identity
Return(@IdArchivoATransmitirDestino)
