CREATE Procedure [dbo].[PresupuestoObrasNodosPxQxPresupuestoPorDia_TX_PorDia]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int,
@Dia int,
@Mes int,
@Año int,
@IdentificadorSesion int = Null

AS

SET NOCOUNT ON

SET @IdentificadorSesion=IsNull(@IdentificadorSesion,-1)

DECLARE @CantidadAvance numeric(18,8)

IF @IdentificadorSesion<=0
	SET @CantidadAvance=IsNull((Select Top 1 CantidadAvance From PresupuestoObrasNodosPxQxPresupuestoPorDia 
					Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Dia=@Dia and Mes=@Mes and Año=@Año),0)
ELSE
	SET @CantidadAvance=IsNull((Select Top 1 CantidadAvance From _TempPresupuestoObrasNodosPxQxPresupuestoPorDia 
					Where IdentificadorSesion=@IdentificadorSesion and IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=0 and Dia=@Dia and Mes=@Mes and Año=@Año),0)

SET NOCOUNT ON

SELECT @CantidadAvance as [CantidadAvance]