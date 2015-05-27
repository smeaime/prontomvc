
create Procedure ProduccionLineas_T
@IdProduccionLinea int
AS 
SELECT * 
FROM ProduccionLineas
WHERE (IdProduccionLinea=@IdProduccionLinea)
