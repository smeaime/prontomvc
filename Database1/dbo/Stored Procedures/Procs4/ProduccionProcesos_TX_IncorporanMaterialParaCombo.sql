
CREATE Procedure ProduccionProcesos_TX_IncorporanMaterialParaCombo

AS 

SELECT 
 IdProduccionProceso,
 ProduccionProcesos.Descripcion as Titulo
FROM ProduccionProcesos
LEFT OUTER JOIN ProduccionSectores ON  ProduccionProcesos.IdProduccionSector = ProduccionSectores.IdProduccionSector 
WHERE (Incorpora='SI')

