
CREATE Procedure [dbo].[PresupuestoObrasRubros_TL]
AS 
SELECT 
 IdPresupuestoObraRubro,
 Descripcion as [Titulo],
 TipoConsumo
FROM PresupuestoObrasRubros
ORDER BY Descripcion
