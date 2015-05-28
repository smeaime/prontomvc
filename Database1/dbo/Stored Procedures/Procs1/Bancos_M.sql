CREATE  Procedure [dbo].[Bancos_M]

@IdBanco int ,
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

UPDATE Bancos
SET 
 Nombre=@Nombre,
 IdCuenta=@IdCuenta,
 CodigoCuenta=@CodigoCuenta,
 NombreDatanet=@NombreDatanet,
 Cuit=@Cuit,
 Codigo=@Codigo,
 IdCodigoIva=@IdCodigoIva,
 CodigoUniversal=@CodigoUniversal,
 IdCuentaParaChequesDiferidos=@IdCuentaParaChequesDiferidos,
 CodigoResumen=@CodigoResumen,
 Entidad=@Entidad,
 Subentidad=@Subentidad
WHERE (IdBanco=@IdBanco)

RETURN(@IdBanco)