



CREATE  Procedure [dbo].[Comparativas_TX_PorPresupuesto]
@Numero int
AS 
SELECT 
	Cmp.IdComparativa,
	(Select Top 1 IdPresupuesto
	 From Presupuestos 
	 Where Cmp.PresupuestoSeleccionado=Presupuestos.Numero and 
		Cmp.SubNumeroSeleccionado=Presupuestos.SubNumero ) as [IdPresupuesto]
FROM Comparativas Cmp
WHERE Numero=@Numero



