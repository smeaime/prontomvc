
CREATE Procedure [dbo].[wFondosFijos_A]

@IdFondoFijo int,
@IdProveedor int,
@IdTipoComprobante int,
@FechaComprobante datetime,
@Letra varchar(1),
@NumeroComprobante1 int,
@NumeroComprobante2 int,
@TotalBruto numeric(18,2),
@TotalIva1 numeric(18,2),
@TotalComprobante numeric(18,2),
@Observaciones ntext,
@IdObra int,
@IdProveedorEventual int,
@IdCuenta int,
@TotalIvaNoDiscriminado numeric(18,2),
@IVAComprasImporte1 numeric(18,2),
@IdCuentaIvaCompras1 int,
@IvaComprasPorcentaje1 numeric(6,2),
@NumeroCAI varchar(20),
@FechaVencimientoCAI datetime,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdCodigoIva int,
@Cuit varchar(13)

AS

DECLARE @ReturnValue int

IF IsNull(@IdFondoFijo,0)<=0
    BEGIN
	BEGIN TRAN
	INSERT INTO FondosFijos
	(
	 IdProveedor,
	 IdTipoComprobante,
	 FechaComprobante,
	 Letra,
	 NumeroComprobante1,
	 NumeroComprobante2,
	 TotalBruto,
	 TotalIva1,
	 TotalComprobante,
	 Observaciones,
	 IdObra,
	 IdProveedorEventual,
	 IdCuenta,
	 TotalIvaNoDiscriminado,
	 IVAComprasImporte1,
	 IdCuentaIvaCompras1,
	 IvaComprasPorcentaje1,
	 NumeroCAI,
	 FechaVencimientoCAI,
	 IdUsuarioIngreso,
	 FechaIngreso,
	 IdCodigoIva,
	 Cuit
	)
	VALUES
	(
	 @IdProveedor,
	 @IdTipoComprobante,
	 @FechaComprobante,
	 @Letra,
	 @NumeroComprobante1,
	 @NumeroComprobante2,
	 @TotalBruto,
	 @TotalIva1,
	 @TotalComprobante,
	 @Observaciones,
	 @IdObra,
	 @IdProveedorEventual,
	 @IdCuenta,
	 @TotalIvaNoDiscriminado,
	 @IVAComprasImporte1,
	 @IdCuentaIvaCompras1,
	 @IvaComprasPorcentaje1,
	 @NumeroCAI,
	 @FechaVencimientoCAI,
	 @IdUsuarioIngreso,
	 @FechaIngreso,
	 @IdCodigoIva,
	 @Cuit
	)
	
	SELECT @ReturnValue = SCOPE_IDENTITY()
	
	IF @@ERROR <> 0
	    BEGIN
		ROLLBACK TRAN
		RETURN -1
	    END
	ELSE
	    BEGIN
		COMMIT TRAN
	    END
    END
ELSE
    BEGIN
	UPDATE FondosFijos
	SET 
	 IdProveedor=@IdProveedor,
	 IdTipoComprobante=@IdTipoComprobante,
	 FechaComprobante=@FechaComprobante,
	 Letra=@Letra,
	 NumeroComprobante1=@NumeroComprobante1,
	 NumeroComprobante2=@NumeroComprobante2,
	 TotalBruto=@TotalBruto,
	 TotalIva1=@TotalIva1,
	 TotalComprobante=@TotalComprobante,
	 Observaciones=@Observaciones,
	 IdObra=@IdObra,
	 IdProveedorEventual=@IdProveedorEventual,
	 IdCuenta=@IdCuenta,
	 TotalIvaNoDiscriminado=@TotalIvaNoDiscriminado,
	 IVAComprasImporte1=@IVAComprasImporte1,
	 IdCuentaIvaCompras1=@IdCuentaIvaCompras1,
	 IvaComprasPorcentaje1=@IvaComprasPorcentaje1,
	 NumeroCAI=@NumeroCAI,
	 FechaVencimientoCAI=@FechaVencimientoCAI,
	 IdUsuarioIngreso=@IdUsuarioIngreso,
	 FechaIngreso=@FechaIngreso,
	 IdCodigoIva=@IdCodigoIva,
	 Cuit=@Cuit
	WHERE (IdFondoFijo=@IdFondoFijo)

	SELECT @ReturnValue = @IdFondoFijo
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @ReturnValue

