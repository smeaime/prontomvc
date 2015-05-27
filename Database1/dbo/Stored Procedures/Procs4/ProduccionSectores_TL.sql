CREATE Procedure ProduccionSectores_TL
AS 
Select 
IdProduccionSector, Descripcion as [Titulo]
FROM ProduccionSectores 
ORDER by IdProduccionSector
