create Procedure ProduccionProcesos_E
@IdProduccionProceso int
AS 
DELETE [ProduccionProcesos]
WHERE (IdProduccionProceso=@IdProduccionProceso)


