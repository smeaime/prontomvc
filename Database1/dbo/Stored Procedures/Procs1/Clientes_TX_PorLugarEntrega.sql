CREATE Procedure [dbo].[Clientes_TX_PorLugarEntrega]

@IdCliente int,
@IdDetalleClienteLugarEntrega int

AS 

IF @IdDetalleClienteLugarEntrega<=0
	SELECT
		Clientes.CodigoCliente as [CodigoCliente],
		Clientes.RazonSocial as [Cliente],
		Clientes.Direccion as [DireccionEntrega],
		Localidades.Nombre as [LocalidadEntrega],
		Provincias.Nombre as [ProvinciaEntrega],
		Transportistas.RazonSocial as [Transportista]
	FROM Clientes
	LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad = Localidades.IdLocalidad
	LEFT OUTER JOIN Provincias ON Clientes.IdProvincia = Provincias.IdProvincia
	LEFT OUTER JOIN Transportistas ON Clientes.IdTransportista = Transportistas.IdTransportista
	WHERE Clientes.IdCliente = @IdCliente
ELSE
	SELECT
		Clientes.CodigoCliente as [CodigoCliente],
		Clientes.RazonSocial as [Cliente],
		Det.DireccionEntrega as [DireccionEntrega],
		Localidades.Nombre as [LocalidadEntrega],
		Provincias.Nombre as [ProvinciaEntrega],
		Transportistas.RazonSocial as [Transportista]
	FROM DetalleClientesLugaresEntrega Det
	LEFT OUTER JOIN Clientes ON Det.IdCliente = Clientes.IdCliente
	LEFT OUTER JOIN Localidades ON Det.IdLocalidadEntrega = Localidades.IdLocalidad
	LEFT OUTER JOIN Provincias ON Det.IdProvinciaEntrega = Provincias.IdProvincia
	LEFT OUTER JOIN Transportistas ON Clientes.IdTransportista = Transportistas.IdTransportista
	WHERE Det.IdCliente = @IdCliente and Det.IdDetalleClienteLugarEntrega=@IdDetalleClienteLugarEntrega
