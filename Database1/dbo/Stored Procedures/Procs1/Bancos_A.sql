CREATE Procedure [dbo].[Bancos_A]

@IdBanco int  output,
@Nombre varchar(50),
@IdCuenta int,
@CodigoCuenta varchar(10),
@NombreDatanet varchar(50),
@Cuit varchar(13),
@Codigo int,
@IdCodigoIva int,
@CodigoUniversal int,
@IdCuentaParaChequesDiferidos int,
@CodigoResumen int,
@Entidad int,
@Subentidad int

AS 

INSERT INTO [Bancos]
(
 Nombre,
 IdCuenta,
 CodigoCuenta,
 NombreDatanet,
 Cuit,
 Codigo,
 IdCodigoIva,
 CodigoUniversal,
 IdCuentaParaChequesDiferidos,
 CodigoResumen,
 Entidad,
 Subentidad
)
VALUES 
(
 @Nombre,
 @IdCuenta,
 @CodigoCuenta,
 @NombreDatanet,
 @Cuit,
 @Codigo,
 @IdCodigoIva,
 @CodigoUniversal,
 @IdCuentaParaChequesDiferidos,
 @CodigoResumen,
 @Entidad,
 @Subentidad
)

SELECT @IdBanco=@@identity

RETURN(@IdBanco)