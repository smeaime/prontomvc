CREATE Procedure [dbo].[PresupuestoObrasNodos_ActualizarDetalles]

@IdPresupuestoObrasNodo int,
@Mes int,
@Año int,
@Importe numeric(18,4),
@Cantidad numeric(18,8),
@ImporteAvance numeric(18,4),
@CantidadAvance numeric(18,8),
@CodigoPresupuesto int,
@Certificado numeric(18,4) = Null,
@IdentificadorSesion int = Null,
@CantidadTeorica numeric(18,4) = Null

AS

SET @Certificado=IsNull(@Certificado,-1)
SET @IdentificadorSesion=IsNull(@IdentificadorSesion,-1)
SET @CantidadTeorica=IsNull(@CantidadTeorica,-1)

DECLARE @IdPresupuestoObrasNodosPxQxPresupuesto int, @Id_TempPresupuestoObrasNodosPxQxPresupuesto int, @TotalCantidadTeorica numeric(18,4)

IF @IdentificadorSesion<=0
  BEGIN
	SET @IdPresupuestoObrasNodosPxQxPresupuesto=IsNull((Select Top 1 IdPresupuestoObrasNodosPxQxPresupuesto 
														From PresupuestoObrasNodosPxQxPresupuesto 
														Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto and Mes=@Mes and Año=@Año),0)
	IF @IdPresupuestoObrasNodosPxQxPresupuesto=0
	  BEGIN
		INSERT INTO [PresupuestoObrasNodosPxQxPresupuesto]
		(IdPresupuestoObrasNodo, Mes, Año, Importe, Cantidad, ImporteAvance, CantidadAvance, CodigoPresupuesto, Certificado)
		VALUES
		(@IdPresupuestoObrasNodo, @Mes, @Año, Case When @Importe<>-1 Then @Importe Else Null End, 
		 Case When @Cantidad<>-1 Then @Cantidad Else Null End,  Case When @ImporteAvance<>-1 Then @ImporteAvance Else Null End, 
		 Case When @CantidadAvance<>-1 Then @CantidadAvance Else Null End, @CodigoPresupuesto, Case When @Certificado<>-1 Then @Certificado Else Null End)
		
		SELECT @IdPresupuestoObrasNodosPxQxPresupuesto=@@identity
	  END
	ELSE
	  BEGIN
		UPDATE PresupuestoObrasNodosPxQxPresupuesto
		SET Importe=Case When @Importe<>-1 Then @Importe Else Importe End,
			Cantidad=Case When @Cantidad<>-1 Then @Cantidad Else Cantidad End,
			ImporteAvance=Case When @ImporteAvance<>-1 Then @ImporteAvance Else ImporteAvance End,
			Certificado=Case When @Certificado<>-1 Then @Certificado Else Certificado End
		WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto
	  END

	-- Esto es solo cuando importa cantidades teoricas en el Carga diaria de presupuesto de obra, tengo que recalcular los %, son padres
	IF @CantidadTeorica>=0
	  BEGIN
		UPDATE PresupuestoObrasNodosPxQxPresupuesto
		SET CantidadTeorica=@CantidadTeorica
		WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto

		SET @TotalCantidadTeorica=IsNull((Select Sum(IsNull(CantidadTeorica,0)) From PresupuestoObrasNodosPxQxPresupuesto 
											Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)

		UPDATE PresupuestoObrasNodosPxQxPresupuesto
		SET Cantidad = Case When @TotalCantidadTeorica<>0 Then CantidadTeorica/@TotalCantidadTeorica*100 Else 0 End
		WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto
		
		UPDATE PresupuestoObrasNodosDatos
		SET Cantidad=@TotalCantidadTeorica
		WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto
	  END

	IF @CantidadAvance>=0
	  BEGIN
		SET @IdPresupuestoObrasNodosPxQxPresupuesto=IsNull((Select Top 1 IdPresupuestoObrasNodosPxQxPresupuesto 
															From PresupuestoObrasNodosPxQxPresupuesto 
															Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Mes=@Mes and Año=@Año),0)
		IF @IdPresupuestoObrasNodosPxQxPresupuesto=0
		  BEGIN
			INSERT INTO [PresupuestoObrasNodosPxQxPresupuesto]
			(IdPresupuestoObrasNodo, Mes, Año, Importe, Cantidad, ImporteAvance, CantidadAvance, CodigoPresupuesto, Certificado)
			VALUES
			(@IdPresupuestoObrasNodo, @Mes, @Año, Null, Null, Null, @CantidadAvance, 0, Null)
			
			SELECT @IdPresupuestoObrasNodosPxQxPresupuesto=@@identity
		  END
		ELSE
		  BEGIN
			UPDATE PresupuestoObrasNodosPxQxPresupuesto
			SET CantidadAvance=@CantidadAvance
			WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto
		  END
	  END
  END
ELSE
  BEGIN
	SET @Id_TempPresupuestoObrasNodosPxQxPresupuesto=IsNull((Select Top 1 Id_TempPresupuestoObrasNodosPxQxPresupuesto 
															 From _TempPresupuestoObrasNodosPxQxPresupuesto 
															 Where IdentificadorSesion=@IdentificadorSesion and IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Mes=@Mes and Año=@Año),0)
	IF @Id_TempPresupuestoObrasNodosPxQxPresupuesto=0
	  BEGIN
		INSERT INTO [_TempPresupuestoObrasNodosPxQxPresupuesto]
		(IdPresupuestoObrasNodosPxQxPresupuesto, IdPresupuestoObrasNodo, Mes, Año, Importe, Cantidad, ImporteAvance, CantidadAvance, CodigoPresupuesto, Certificado, IdentificadorSesion, FechaSesion)
		VALUES
		(-1, @IdPresupuestoObrasNodo, @Mes, @Año, Case When @Importe<>-1 Then @Importe Else Null End, 
		 Case When @Cantidad<>-1 Then @Cantidad Else Null End,  Case When @ImporteAvance<>-1 Then @ImporteAvance Else Null End, 
		 Case When @CantidadAvance<>-1 Then @CantidadAvance Else Null End, 0, Case When @Certificado<>-1 Then @Certificado Else Null End, @IdentificadorSesion, GetDate())
		
		SELECT @Id_TempPresupuestoObrasNodosPxQxPresupuesto=@@identity
	  END
	ELSE
	  BEGIN
		UPDATE _TempPresupuestoObrasNodosPxQxPresupuesto
		SET Importe=Case When @Importe<>-1 Then @Importe Else Importe End,
			Cantidad=Case When @Cantidad<>-1 Then @Cantidad Else Cantidad End,
			ImporteAvance=Case When @ImporteAvance<>-1 Then @ImporteAvance Else ImporteAvance End,
			CantidadAvance=Case When @CantidadAvance<>-1 Then @CantidadAvance Else CantidadAvance End,
			Certificado=Case When @Certificado<>-1 Then @Certificado Else Certificado End
		WHERE Id_TempPresupuestoObrasNodosPxQxPresupuesto=@Id_TempPresupuestoObrasNodosPxQxPresupuesto
	  END

	-- Esto es solo cuando importa cantidades teoricas en el Carga diaria de presupuesto de obra, tengo que recalcular los %, son padres
	IF @CantidadTeorica>=0
	  BEGIN
		UPDATE _TempPresupuestoObrasNodosPxQxPresupuesto
		SET CantidadTeorica=@CantidadTeorica
		WHERE Id_TempPresupuestoObrasNodosPxQxPresupuesto=@Id_TempPresupuestoObrasNodosPxQxPresupuesto

		SET @TotalCantidadTeorica=IsNull((Select Sum(IsNull(CantidadTeorica,0)) From _TempPresupuestoObrasNodosPxQxPresupuesto 
											Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and IdentificadorSesion=@IdentificadorSesion),0)
		IF @TotalCantidadTeorica<>0
			UPDATE _TempPresupuestoObrasNodosPxQxPresupuesto
			SET Cantidad=CantidadTeorica/@TotalCantidadTeorica*100
			WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and IdentificadorSesion=@IdentificadorSesion
	  END
  END