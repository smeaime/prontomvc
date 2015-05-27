




CREATE Procedure [dbo].[Presupuestos_T]
@IdPresupuesto int
AS 
SELECT * 
FROM Presupuestos
WHERE (IdPresupuesto=@IdPresupuesto)




