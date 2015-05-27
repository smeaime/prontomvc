CREATE  Procedure [dbo].[Empresa_M]

@IdEmpresa int,
@Nombre varchar(100),
@DetalleNombre varchar(100),
@Direccion varchar(100),
@Localidad varchar(100),
@CodigoPostal varchar(10),
@Provincia varchar(100),
@Telefono1 varchar(100),
@Telefono2 varchar(100),
@Email varchar(50),
@Cuit varchar(13),
@CondicionIva varchar(50),
@DatosAdicionales1 varchar(100),
@DatosAdicionales2 varchar(100),
@DatosAdicionales3 varchar(100),
@IdCodigoIva int,
@ArchivoAFIP varchar(50),
@NumeroAgentePercepcionIIBB int,
@DigitoVerificadorNumeroAgentePercepcionIIBB int,
@ModalidadFacturacionAPrueba varchar(2),
@CodigoActividadIIBB int,
@ActividadComercializacionGranos varchar(2),
@TipoActividadComercializacionGranos int

AS

IF Not Exists(Select Top 1 IdEmpresa From Empresa Where IdEmpresa=@IdEmpresa)
	INSERT INTO Empresa 
	(
	 Nombre,
	 DetalleNombre,
	 Direccion,
	 Localidad,
	 CodigoPostal,
	 Provincia,
	 Telefono1,
	 Telefono2,
	 Email,
	 Cuit,
	 CondicionIva,
	 DatosAdicionales1,
	 DatosAdicionales2,
	 DatosAdicionales3,
	 IdCodigoIva,
	 ArchivoAFIP,
	 NumeroAgentePercepcionIIBB,
	 DigitoVerificadorNumeroAgentePercepcionIIBB,
	 ModalidadFacturacionAPrueba,
	 CodigoActividadIIBB,
	 ActividadComercializacionGranos,
	 TipoActividadComercializacionGranos
	) 
	VALUES 
	(
	 @Nombre,
	 @DetalleNombre,
	 @Direccion,
	 @Localidad,
	 @CodigoPostal,
	 @Provincia,
	 @Telefono1,
	 @Telefono2,
	 @Email,
	 @Cuit,
	 @CondicionIva,
	 @DatosAdicionales1,
	 @DatosAdicionales2,
	 @DatosAdicionales3,
	 @IdCodigoIva,
	 @ArchivoAFIP,
	 @NumeroAgentePercepcionIIBB,
	 @DigitoVerificadorNumeroAgentePercepcionIIBB,
	 @ModalidadFacturacionAPrueba,
	 @CodigoActividadIIBB,
	 @ActividadComercializacionGranos,
	 @TipoActividadComercializacionGranos
	)
ELSE
	UPDATE Empresa
	SET
	 Nombre=@Nombre,
	 DetalleNombre=@DetalleNombre,
	 Direccion=@Direccion,
	 Localidad=@Localidad,
	 CodigoPostal=@CodigoPostal,
	 Provincia=@Provincia,
	 Telefono1=@Telefono1,
	 Telefono2=@Telefono2,
	 Email=@Email,
	 Cuit=@Cuit,
	 CondicionIva=@CondicionIva,
	 DatosAdicionales1=@DatosAdicionales1,
	 DatosAdicionales2=@DatosAdicionales2,
	 DatosAdicionales3=@DatosAdicionales3,
	 IdCodigoIva=@IdCodigoIva,
	 ArchivoAFIP=@ArchivoAFIP,
	 NumeroAgentePercepcionIIBB=@NumeroAgentePercepcionIIBB,
	 DigitoVerificadorNumeroAgentePercepcionIIBB=@DigitoVerificadorNumeroAgentePercepcionIIBB,
	 ModalidadFacturacionAPrueba=@ModalidadFacturacionAPrueba,
	 CodigoActividadIIBB=@CodigoActividadIIBB,
	 ActividadComercializacionGranos=@ActividadComercializacionGranos,
	 TipoActividadComercializacionGranos=@TipoActividadComercializacionGranos
	WHERE (IdEmpresa=@IdEmpresa)

RETURN(@IdEmpresa)