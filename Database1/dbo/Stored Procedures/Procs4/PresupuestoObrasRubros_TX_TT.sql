
CREATE Procedure [dbo].[PresupuestoObrasRubros_TX_TT]
@IdPresupuestoObraRubro int
AS 
SELECT 
 IdPresupuestoObraRubro,
 Descripcion,
 Case When IsNull(TipoConsumo,3)=1 Then 'Directo'
	When IsNull(TipoConsumo,3)=2 Then 'Indirecto'
	Else 'Ambos'
 End as [Tipo consumo]
FROM PresupuestoObrasRubros
WHERE (IdPresupuestoObraRubro=@IdPresupuestoObraRubro)
