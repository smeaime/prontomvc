CREATE  Procedure [dbo].[Transportistas_M]

@IdTransportista int,
@RazonSocial varchar(50),
@Direccion varchar(50),
@IdLocalidad int,
@CodigoPostal varchar(30),
@IdProvincia int,
@IdPais int,
@Telefono varchar(50),
@Fax varchar(50),
@Email varchar(50),
@IdCodigoIva tinyint,
@Cuit varchar(13),
@Contacto varchar(50),
@Observaciones ntext,
@Horario varchar(50),
@Celular varchar(50),
@EnviarEmail tinyint,
@IdProveedor int,
@Codigo int

AS 

UPDATE Transportistas
SET
 RazonSocial=@RazonSocial,
 Direccion=@Direccion,
 IdLocalidad=@IdLocalidad,
 CodigoPostal=@CodigoPostal,
 IdProvincia=@IdProvincia,
 IdPais=@IdPais,
 Telefono=@Telefono,
 Fax=@Fax,
 Email=@Email,
 IdCodigoIva=@IdCodigoIva,
 Cuit=@Cuit,
 Contacto=@Contacto,
 Observaciones=@Observaciones,
 Horario=@Horario,
 Celular=@Celular,
 EnviarEmail=@EnviarEmail,
 IdProveedor=@IdProveedor,
 Codigo=@Codigo
WHERE IdTransportista=@IdTransportista

RETURN(@IdTransportista)