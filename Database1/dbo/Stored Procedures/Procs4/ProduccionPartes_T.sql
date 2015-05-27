CREATE  Procedure ProduccionPartes_T
@IdProduccionParte int
AS 

--SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)

SELECT *
FROM ProduccionPartes p
WHERE (p.IdProduccionParte=@IdProduccionParte)
