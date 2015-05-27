CREATE Procedure [dbo].[PresupuestoObrasNodos_ActualizarDetallesPorDiaInicializar]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int,
@Mes int,
@Año int,
@IdentificadorSesion int = Null

AS

SET @IdentificadorSesion=IsNull(@IdentificadorSesion,-1)

IF @IdentificadorSesion<=0
	UPDATE PresupuestoObrasNodosPxQxPresupuestoPorDia
	SET CantidadAvance=0
	WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Mes=@Mes and Año=@Año
ELSE
	UPDATE _TempPresupuestoObrasNodosPxQxPresupuestoPorDia
	SET CantidadAvance=0
	WHERE IdentificadorSesion=@IdentificadorSesion and IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Mes=@Mes and Año=@Año