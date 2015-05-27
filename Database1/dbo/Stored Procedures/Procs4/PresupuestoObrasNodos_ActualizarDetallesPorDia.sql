CREATE Procedure [dbo].[PresupuestoObrasNodos_ActualizarDetallesPorDia]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int,
@Dia int,
@Mes int,
@Año int,
@CantidadAvance numeric(18,8),
@IdentificadorSesion int = Null

AS

SET NOCOUNT ON

SET @IdentificadorSesion=IsNull(@IdentificadorSesion,-1)

DECLARE @IdPresupuestoObrasNodosPxQxPresupuestoPorDia int, @Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia int

IF @IdentificadorSesion<=0
  BEGIN
	SET @IdPresupuestoObrasNodosPxQxPresupuestoPorDia=IsNull((Select Top 1 IdPresupuestoObrasNodosPxQxPresupuestoPorDia From PresupuestoObrasNodosPxQxPresupuestoPorDia 
									Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Dia=@Dia and Mes=@Mes and Año=@Año),0)
	IF @IdPresupuestoObrasNodosPxQxPresupuestoPorDia=0
	    BEGIN
		INSERT INTO [PresupuestoObrasNodosPxQxPresupuestoPorDia]
		(IdPresupuestoObrasNodo, CodigoPresupuesto, Dia, Mes, Año, CantidadAvance)
		VALUES
		(@IdPresupuestoObrasNodo, 0, @Dia, @Mes, @Año, Case When @CantidadAvance>0 Then @CantidadAvance Else Null End)
		
		SELECT @IdPresupuestoObrasNodosPxQxPresupuestoPorDia=@@identity
	    END
	ELSE
	    BEGIN
		UPDATE PresupuestoObrasNodosPxQxPresupuestoPorDia
		SET CantidadAvance=@CantidadAvance
		WHERE IdPresupuestoObrasNodosPxQxPresupuestoPorDia=@IdPresupuestoObrasNodosPxQxPresupuestoPorDia
	    END
  END
ELSE
  BEGIN
	SET @Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia=IsNull((Select Top 1 Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia From _TempPresupuestoObrasNodosPxQxPresupuestoPorDia 
									Where IdentificadorSesion=@IdentificadorSesion and IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Dia=@Dia and Mes=@Mes and Año=@Año),0)
	IF @Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia=0
	    BEGIN
		INSERT INTO [_TempPresupuestoObrasNodosPxQxPresupuestoPorDia]
		(IdPresupuestoObrasNodosPxQxPresupuestoPorDia, IdPresupuestoObrasNodo, CodigoPresupuesto, Dia, Mes, Año, CantidadAvance, IdentificadorSesion, FechaSesion)
		VALUES
		(-1, @IdPresupuestoObrasNodo, 0, @Dia, @Mes, @Año, Case When @CantidadAvance>0 Then @CantidadAvance Else Null End, @IdentificadorSesion, GetDate())
		
		SELECT @Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia=@@identity
	    END
	ELSE
	    BEGIN
		UPDATE _TempPresupuestoObrasNodosPxQxPresupuestoPorDia
		SET CantidadAvance=@CantidadAvance
		WHERE Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia=@Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia
	    END
  END

SET NOCOUNT ON