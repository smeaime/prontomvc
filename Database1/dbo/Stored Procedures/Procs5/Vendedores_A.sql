CREATE Procedure [dbo].[Vendedores_A]

@IdVendedor int output,
@CodigoVendedor int,
@Nombre varchar(50),
@Direccion varchar(50),
@IdLocalidad smallint,
@CodigoPostal int,
@IdProvincia tinyint,
@Telefono varchar(50),
@Fax varchar(50),
@Email varchar(50),
@Comision numeric(6,2),
@IdEmpleado int,
@Cuit varchar(13),
@TodasLasZonas varchar(2),
@EmiteComision varchar(2),
@IdsVendedoresAsignados varchar(1000)

AS 

INSERT INTO Vendedores
(
 CodigoVendedor,
 Nombre,
 Direccion,
 IdLocalidad,
 CodigoPostal,
 IdProvincia,
 Telefono,
 Fax,
 Email,
 Comision,
 IdEmpleado,
 Cuit,
 TodasLasZonas,
 EmiteComision,
 IdsVendedoresAsignados
) 
VALUES 
(
 @CodigoVendedor,
 @Nombre,
 @Direccion,
 @IdLocalidad,
 @CodigoPostal,
 @IdProvincia,
 @Telefono,
 @Fax,
 @Email,
 @Comision,
 @IdEmpleado,
 @Cuit,
 @TodasLasZonas,
 @EmiteComision,
 @IdsVendedoresAsignados
)

SELECT @IdVendedor=@@identity

RETURN(@IdVendedor)