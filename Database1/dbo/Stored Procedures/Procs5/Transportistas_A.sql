CREATE Procedure [dbo].[Transportistas_A]

@IdTransportista int output,
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

INSERT INTO Transportistas
(
 RazonSocial,
 Direccion,
 IdLocalidad,
 CodigoPostal,
 IdProvincia,
 IdPais,
 Telefono,
 Fax,
 Email,
 IdCodigoIva,
 Cuit,
 Contacto,
 Observaciones,
 Horario,
 Celular,
 EnviarEmail,
 IdProveedor,
 Codigo
)
 VALUES 
(
 @RazonSocial,
 @Direccion,
 @IdLocalidad,
 @CodigoPostal,
 @IdProvincia,
 @IdPais,
 @Telefono,
 @Fax,
 @Email,
 @IdCodigoIva,
 @Cuit,
 @Contacto,
 @Observaciones,
 @Horario,
 @Celular,
 @EnviarEmail,
 @IdProveedor,
 @Codigo
)

SELECT @IdTransportista=@@identity

RETURN(@IdTransportista)