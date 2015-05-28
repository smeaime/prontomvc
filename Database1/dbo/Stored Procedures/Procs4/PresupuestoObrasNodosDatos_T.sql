
CREATE Procedure [dbo].[PresupuestoObrasNodosDatos_T]

@IdPresupuestoObrasNodoDatos int

AS 

SELECT *
FROM PresupuestoObrasNodosDatos 
WHERE IdPresupuestoObrasNodoDatos=@IdPresupuestoObrasNodoDatos
