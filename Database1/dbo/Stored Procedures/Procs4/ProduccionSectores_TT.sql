CREATE Procedure ProduccionSectores_TT
--@IdArticulo int
AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='011133'
Set @vector_T='011100'
SELECT 
 ProduccionSectores.idProduccionSector,
 ProduccionAreas.Descripcion as Area,
 ProduccionSectores.Codigo,
 ProduccionSectores.Descripcion,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionSectores
LEFT OUTER JOIN ProduccionAreas ON  ProduccionAreas.IdProduccionArea = ProduccionSectores.IdProduccionArea
