CREATE Procedure [dbo].[PresupuestoObrasRedeterminaciones_EliminarPorIdObra]

@IdObra int,
@Año int = Null,
@Mes int = Null

AS 

SET @Año=IsNull(@Año,-1)
SET @Mes=IsNull(@Mes,-1)

DELETE FROM PresupuestoObrasRedeterminaciones 
WHERE IdObra=@IdObra and (@Año=-1 or Año=@Año) and (@Mes=-1 or Mes=@Mes)
