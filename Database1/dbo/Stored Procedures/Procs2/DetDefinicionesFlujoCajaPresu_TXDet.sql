


CREATE PROCEDURE [dbo].[DetDefinicionesFlujoCajaPresu_TXDet]

@IdDefinicionFlujoCaja int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011133'
Set @vector_T='000300'

SELECT 
 dfc.IdDetalleDefinicionFlujoCaja as [IdAux],
 dfc.Mes as [Mes],
 dfc.Año as [Año],
 dfc.Presupuesto as [Presupuesto],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDefinicionesFlujoCajaPresupuestos dfc 
WHERE (dfc.IdDefinicionFlujoCaja = @IdDefinicionFlujoCaja)
ORDER by dfc.Año, dfc.Mes


