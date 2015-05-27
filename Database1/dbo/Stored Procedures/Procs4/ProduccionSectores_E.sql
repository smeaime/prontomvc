create Procedure ProduccionSectores_E
@IdProduccionSector int
AS 
DELETE [ProduccionSectores]
WHERE (IdProduccionSector=@IdProduccionSector)


