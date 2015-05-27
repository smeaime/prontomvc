CREATE  Procedure [dbo].[Empresa_A]

@IdEmpresa int  output,
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

SELECT @IdEmpresa=@@identity

RETURN(@IdEmpresa)