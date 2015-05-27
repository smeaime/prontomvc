CREATE  Procedure [dbo].[Vendedores_M]

@idVendedor int,
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

UPDATE Vendedores
SET 
 CodigoVendedor=@CodigoVendedor,
 Nombre=@Nombre,
 Direccion=@Direccion,
 IdLocalidad=@IdLocalidad,
 CodigoPostal=@CodigoPostal,
 IdProvincia=@IdProvincia,
 Telefono=@Telefono,
 Fax=@Fax,
 Email=@Email,
 Comision=@Comision,
 IdEmpleado=@IdEmpleado,
 Cuit=@Cuit,
 TodasLasZonas=@TodasLasZonas,
 EmiteComision=@EmiteComision,
 IdsVendedoresAsignados=@IdsVendedoresAsignados
WHERE IdVendedor = @IdVendedor

RETURN(@IdVendedor)