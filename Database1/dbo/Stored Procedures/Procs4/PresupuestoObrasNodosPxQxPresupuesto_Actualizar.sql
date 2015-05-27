CREATE Procedure [dbo].[PresupuestoObrasNodosPxQxPresupuesto_Actualizar]

@IdPresupuestoObrasNodosPxQxPresupuesto int output,
@IdPresupuestoObrasNodo int,
@Mes int,
@Año int,
@Importe numeric(18,4),
@Cantidad numeric(18,8),
@ImporteAvance numeric(18,4),
@CantidadAvance numeric(18,8),
@CodigoPresupuesto int,
@Certificado numeric(18,4),
@PrecioVentaUnitario numeric(18,2)

AS

IF @IdPresupuestoObrasNodosPxQxPresupuesto=0
  BEGIN
	INSERT INTO [PresupuestoObrasNodosPxQxPresupuesto]
	(IdPresupuestoObrasNodo, Mes, Año, Importe, Cantidad, ImporteAvance, CantidadAvance, CodigoPresupuesto, Certificado, PrecioVentaUnitario)
	VALUES
	(@IdPresupuestoObrasNodo, @Mes, @Año, Case When @Importe<>-1 Then @Importe Else Null End, 
	 Case When @Cantidad<>-1 Then @Cantidad Else Null End,  Case When @ImporteAvance<>-1 Then @ImporteAvance Else Null End, 
	 Case When @CantidadAvance<>-1 Then @CantidadAvance Else Null End, @CodigoPresupuesto, Case When @Certificado<>-1 Then @Certificado Else Null End, 
	 Case When @PrecioVentaUnitario<>-1 Then @PrecioVentaUnitario Else Null End)
	
	SELECT @IdPresupuestoObrasNodosPxQxPresupuesto=@@identity
  END
ELSE
  BEGIN
	UPDATE PresupuestoObrasNodosPxQxPresupuesto
	SET Importe=Case When @Importe<>-1 Then @Importe Else Importe End,
		Cantidad=Case When @Cantidad<>-1 Then @Cantidad Else Cantidad End,
		ImporteAvance=Case When @ImporteAvance<>-1 Then @ImporteAvance Else ImporteAvance End,
		CantidadAvance=Case When @CantidadAvance<>-1 Then @CantidadAvance Else CantidadAvance End,
		Certificado=Case When @Certificado<>-1 Then @Certificado Else Certificado End,
		PrecioVentaUnitario=Case When @PrecioVentaUnitario<>-1 Then @PrecioVentaUnitario Else PrecioVentaUnitario End
	WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto
  END
