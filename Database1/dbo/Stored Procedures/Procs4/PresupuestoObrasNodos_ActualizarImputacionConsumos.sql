CREATE Procedure [dbo].[PresupuestoObrasNodos_ActualizarImputacionConsumos]

@IdPresupuestoObrasNodo int,
@TipoComprobante varchar(2),
@IdComprobante int,
@IdComprobanteDetalle int

AS

DECLARE @Cantidad numeric(18,2)

IF @TipoComprobante='CP'
	UPDATE DetalleComprobantesProveedores
	SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
	WHERE IdDetalleComprobanteProveedor=@IdComprobante

IF @TipoComprobante='SM'
   BEGIN
	IF @IdComprobanteDetalle<=0
	   BEGIN
		SET @IdComprobanteDetalle=IsNull((Select Top 1 IdDetalleSalidaMaterialesPresupuestosObras From DetalleSalidasMaterialesPresupuestosObras Where IdDetalleSalidaMateriales=@IdComprobante),0)
		SET @Cantidad=IsNull((Select Top 1 Cantidad From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdComprobante),0)
		IF @IdComprobanteDetalle=0
			IF @IdPresupuestoObrasNodo>0
				INSERT INTO [DetalleSalidasMaterialesPresupuestosObras]
				(IdDetalleSalidaMateriales, IdPresupuestoObrasNodo, Cantidad, IdDetalleSalidaMaterialesKit)
				VALUES 
				(@IdComprobante, @IdPresupuestoObrasNodo, @Cantidad, Null)
		ELSE
			UPDATE [DetalleSalidasMaterialesPresupuestosObras]
			SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
			WHERE IdDetalleSalidaMaterialesPresupuestosObras=@IdComprobanteDetalle
	   END
	ELSE
	   BEGIN
		UPDATE [DetalleSalidasMaterialesPresupuestosObras]
		SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
		WHERE IdDetalleSalidaMaterialesPresupuestosObras=@IdComprobanteDetalle
	   END
	UPDATE DetalleSalidasMateriales
	SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
	WHERE IdDetalleSalidaMateriales=@IdComprobante
   END

IF @TipoComprobante='SK'
   BEGIN
	IF @IdComprobanteDetalle<=0
	   BEGIN
		SET @IdComprobanteDetalle=IsNull((Select Top 1 IdDetalleSalidaMaterialesPresupuestosObras From DetalleSalidasMaterialesPresupuestosObras 
							Where IdDetalleSalidaMaterialesKit=@IdComprobante),0)
		SET @Cantidad=IsNull((Select Top 1 Cantidad From DetalleSalidasMaterialesKits Where IdDetalleSalidaMaterialesKit=@IdComprobante),0)
		IF @IdComprobanteDetalle=0
			IF @IdPresupuestoObrasNodo>0
				INSERT INTO [DetalleSalidasMaterialesPresupuestosObras]
				(IdDetalleSalidaMateriales, IdPresupuestoObrasNodo, Cantidad, IdDetalleSalidaMaterialesKit)
				VALUES 
				(Null, @IdPresupuestoObrasNodo, @Cantidad, @IdComprobante)
		ELSE
			UPDATE [DetalleSalidasMaterialesPresupuestosObras]
			SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
			WHERE IdDetalleSalidaMaterialesPresupuestosObras=@IdComprobanteDetalle
	   END
	ELSE
	   BEGIN
		UPDATE [DetalleSalidasMaterialesPresupuestosObras]
		SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
		WHERE IdDetalleSalidaMaterialesPresupuestosObras=@IdComprobanteDetalle
	   END
   END

IF @TipoComprobante='FI'
	UPDATE DetalleSalidasMateriales
	SET IdPresupuestoObrasNodoFleteInterno=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
	WHERE IdDetalleSalidaMateriales=@IdComprobanteDetalle

IF @TipoComprobante='FL'
	UPDATE DetalleSalidasMateriales
	SET IdPresupuestoObrasNodoFleteLarga=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
	WHERE IdDetalleSalidaMateriales=@IdComprobanteDetalle

IF @TipoComprobante='SC'
	UPDATE SubcontratosPxQ
	SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
	WHERE IdSubcontratoPxQ=@IdComprobante

IF @TipoComprobante='PP'
	UPDATE PartesProduccion
	SET IdPresupuestoObrasNodo=Case When @IdPresupuestoObrasNodo>0 Then @IdPresupuestoObrasNodo Else Null End
	WHERE IdParteProduccion=@IdComprobante