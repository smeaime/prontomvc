
CREATE Procedure ProduccionPartes_TX_PorProceso
As
SELECT 
 ProduccionProcesos.Descripcion,PARTES.idProduccionProceso
FROM ProduccionPartes PARTES
LEFT OUTER JOIN ProduccionProcesos ON  PARTES.IdProduccionProceso = ProduccionProcesos.IdProduccionProceso
WHERE PARTES.idProduccionProceso is not null
GROUP BY  ProduccionProcesos.Descripcion,PARTES.idProduccionProceso 
ORDER by  PARTES.idProduccionProceso desc
