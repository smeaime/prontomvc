



CREATE Procedure [dbo].[DetPresupuestos_TX_PreSF]
@IdPresupuesto int
AS 
SELECT *
FROM [DetallePresupuestos]
WHERE (IdPresupuesto=@IdPresupuesto)
ORDER BY NumeroItem



