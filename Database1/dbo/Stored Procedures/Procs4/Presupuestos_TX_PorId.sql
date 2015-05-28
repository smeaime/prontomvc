




CREATE Procedure [dbo].[Presupuestos_TX_PorId]
@IdPresupuesto int
AS 
SELECT * 
FROM Presupuestos
WHERE (IdPresupuesto=@IdPresupuesto)




