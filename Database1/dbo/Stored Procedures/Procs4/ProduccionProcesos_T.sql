
create Procedure ProduccionProcesos_T
@IdProduccionProceso int
AS 
SELECT * 
FROM ProduccionProcesos
WHERE (IdProduccionProceso=@IdProduccionProceso)
