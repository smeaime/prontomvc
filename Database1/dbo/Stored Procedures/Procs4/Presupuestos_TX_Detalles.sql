




CREATE Procedure [dbo].[Presupuestos_TX_Detalles]
@IdPresupuesto int
AS 
SELECT 
 dp.*,
 Articulos.Descripcion
FROM DetallePresupuestos dp
Left Outer Join Articulos On Articulos.IdArticulo=dp.IdArticulo
WHERE dp.IdPresupuesto = @IdPresupuesto




