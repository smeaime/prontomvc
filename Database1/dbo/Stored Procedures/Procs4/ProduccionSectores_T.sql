
create Procedure ProduccionSectores_T
@IdProduccionSector int
AS 
SELECT * 
FROM ProduccionSectores
WHERE (IdProduccionSector=@IdProduccionSector)
