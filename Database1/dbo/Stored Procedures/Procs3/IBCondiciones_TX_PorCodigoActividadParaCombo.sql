CREATE Procedure [dbo].[IBCondiciones_TX_PorCodigoActividadParaCombo]

AS 

DECLARE @CodigoActividadIIBB int

SET @CodigoActividadIIBB=IsNull((Select Top 1 CodigoActividadIIBB From Empresa Where IdEmpresa=1),0)

SELECT IsNull(CodigoActividad,@CodigoActividadIIBB) as [CodigoActividad], IsNull(CodigoActividad,@CodigoActividadIIBB) as [Titulo]
FROM IBCondiciones
GROUP BY IsNull(CodigoActividad,@CodigoActividadIIBB)
ORDER BY IsNull(CodigoActividad,@CodigoActividadIIBB)