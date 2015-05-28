CREATE Procedure [dbo].[Clientes_EliminacionComprobante]

@IdTipoComprobante int,
@IdComprobante int,
@IdUsuario int

AS

DECLARE @Comprobante varchar(5), @Usuario varchar(50), @NumeroComprobante varchar(20)

IF @IdTipoComprobante=1
  BEGIN
	SET @NumeroComprobante=IsNull((Select Top 1 TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,IsNull(PuntoVenta,0))))+Convert(varchar,IsNull(PuntoVenta,0))+'-'+
												Substring('00000000',1,8-Len(Convert(varchar,NumeroFactura)))+Convert(varchar,NumeroFactura)
									From Facturas Where IdFactura=@IdComprobante),'')

	DELETE DetalleFacturasOrdenesCompra WHERE IdFactura=@IdComprobante
	DELETE DetalleFacturasProvincias WHERE IdFactura=@IdComprobante
	DELETE DetalleFacturasRemitos WHERE IdFactura=@IdComprobante
	DELETE DetalleFacturas WHERE IdFactura=@IdComprobante
	DELETE Facturas WHERE IdFactura=@IdComprobante
  END
  	
IF @IdTipoComprobante=3
  BEGIN
	SET @NumeroComprobante=IsNull((Select Top 1 TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,IsNull(PuntoVenta,0))))+Convert(varchar,IsNull(PuntoVenta,0))+'-'+
												Substring('00000000',1,8-Len(Convert(varchar,NumeroNotaDebito)))+Convert(varchar,NumeroNotaDebito)
									From NotasDebito Where IdNotaDebito=@IdComprobante),'')

	DELETE DetalleNotasDebitoProvincias WHERE IdNotaDebito=@IdComprobante
	DELETE DetalleNotasDebito WHERE IdNotaDebito=@IdComprobante
	DELETE NotasDebito WHERE IdNotaDebito=@IdComprobante
  END

IF @IdTipoComprobante=4
  BEGIN
	SET @NumeroComprobante=IsNull((Select Top 1 TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,IsNull(PuntoVenta,0))))+Convert(varchar,IsNull(PuntoVenta,0))+'-'+
												Substring('00000000',1,8-Len(Convert(varchar,NumeroNotaCredito)))+Convert(varchar,NumeroNotaCredito)
									From NotasCredito Where IdNotaCredito=@IdComprobante),'')

	DELETE DetalleNotasCreditoOrdenesCompra WHERE IdNotaCredito=@IdComprobante
	DELETE DetalleNotasCreditoProvincias WHERE IdNotaCredito=@IdComprobante
	DELETE DetalleNotasCreditoImputaciones WHERE IdNotaCredito=@IdComprobante
	DELETE DetalleNotasCredito WHERE IdNotaCredito=@IdComprobante
	DELETE NotasCredito WHERE IdNotaCredito=@IdComprobante
  END

DELETE CuentasCorrientesDeudores WHERE IdTipoComp=@IdTipoComprobante and IdComprobante=@IdComprobante

SET @Usuario=IsNull((Select Top 1 Nombre From Empleados Where IdEmpleado=@IdUsuario),'')
SET @Comprobante=IsNull((Select Top 1 DescripcionAb From TiposComprobante Where IdTipoComprobante=@IdTipoComprobante),'')

INSERT INTO Log
(Tipo, IdComprobante, FechaRegistro, Detalle, AuxString5)
VALUES
('ELIM', @IdComprobante, getdate(), @Comprobante+' '+@NumeroComprobante, @Usuario)
