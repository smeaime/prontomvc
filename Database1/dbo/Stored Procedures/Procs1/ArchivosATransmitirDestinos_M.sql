






CREATE  Procedure [dbo].[ArchivosATransmitirDestinos_M]
@IdArchivoATransmitirDestino int ,
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
Update ArchivosATransmitirDestinos
Set
 Descripcion=@Descripcion,
 Tipo=@Tipo,
 Email=@Email,
 Activo=@Activo,
 Nombre=@Nombre,
 Direccion=@Direccion,
 Localidad=@Localidad,
 Telefono=@Telefono,
 Celular=@Celular,
 Horario=@Horario,
 Contacto=@Contacto,
 Observaciones=@Observaciones,
 Sistema=@Sistema,
 IdObra=@IdObra
Where (IdArchivoATransmitirDestino=@IdArchivoATransmitirDestino)
Return(@IdArchivoATransmitirDestino)






