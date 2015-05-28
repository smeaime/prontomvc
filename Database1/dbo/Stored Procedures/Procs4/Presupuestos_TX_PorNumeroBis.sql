





























CREATE Procedure [dbo].[Presupuestos_TX_PorNumeroBis]
@Numero int
AS 
SELECT 
IdPresupuesto,
SubNumero
FROM Presupuestos
WHERE Numero=@Numero






























