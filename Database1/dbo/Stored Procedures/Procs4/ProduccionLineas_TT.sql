CREATE Procedure ProduccionLineas_TT
--@IdArticulo int
AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='011133'
Set @vector_T='011100'
SELECT 
 ProduccionLineas.idProduccionLinea,
 ProduccionSectores.Descripcion as Sector,
 ProduccionLineas. Codigo,
 ProduccionLineas.Descripcion,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionLineas 
LEFT OUTER JOIN ProduccionSectores ON  ProduccionLineas.IdProduccionSector = ProduccionSectores.IdProduccionSector 
