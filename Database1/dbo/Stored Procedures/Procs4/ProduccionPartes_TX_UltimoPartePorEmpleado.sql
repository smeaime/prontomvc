
create procedure ProduccionPartes_TX_UltimoPartePorEmpleado

@IdEmpleado int

AS 

SELECT top 1 *
FROM ProduccionPartes
WHERE IdEmpleado=@IdEmpleado
ORDER by IdProduccionParte DESC

