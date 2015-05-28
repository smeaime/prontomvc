
CREATE Procedure [dbo].[PresupuestoObrasRubros_TT]

AS 

SELECT
 IdPresupuestoObraRubro,
 Descripcion,
 Case When IsNull(TipoConsumo,3)=1 Then 'Directo'
	When IsNull(TipoConsumo,3)=2 Then 'Indirecto'
	Else 'Ambos'
 End as [Tipo consumo]
FROM PresupuestoObrasRubros
ORDER BY Descripcion
