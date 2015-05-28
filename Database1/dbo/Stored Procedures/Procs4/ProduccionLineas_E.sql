create Procedure ProduccionLineas_E
@IdProduccionLinea int
AS 
DELETE [ProduccionLineas]
WHERE (IdProduccionLinea=@IdProduccionLinea)


