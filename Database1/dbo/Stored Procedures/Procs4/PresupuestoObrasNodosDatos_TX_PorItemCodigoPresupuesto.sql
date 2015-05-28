
CREATE Procedure [dbo].[PresupuestoObrasNodosDatos_TX_PorItemCodigoPresupuesto]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int

AS 

SELECT *
FROM PresupuestoObrasNodosDatos 
WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto
