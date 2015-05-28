
CREATE FUNCTION [dbo].[NodoRoot] (@IdPresupuestoObrasNodo int)
RETURNS INTEGER

BEGIN
	DECLARE @IdPresupuestoObrasNodoPadre int, @IdNodoPadre int

	SET @IdNodoPadre=IsNull((Select Top 1 IdNodoPadre From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)
	IF @IdNodoPadre=0
		SET @IdPresupuestoObrasNodoPadre=@IdPresupuestoObrasNodo
	ELSE 
		EXEC @IdPresupuestoObrasNodoPadre = NodoRoot @IdNodoPadre

	RETURN(@IdPresupuestoObrasNodoPadre)
END


