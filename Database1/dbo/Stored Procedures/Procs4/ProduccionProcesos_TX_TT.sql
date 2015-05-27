CREATE Procedure ProduccionProcesos_TX_TT

@IdProduccionProceso int

AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='011133'
Set @vector_T='011100'
SELECT 
 ProduccionProcesos.idProduccionProceso,
 ProduccionSectores.Descripcion as Sector,
 ProduccionProcesos. Codigo,
 ProduccionProcesos.Descripcion,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionProcesos
LEFT OUTER JOIN ProduccionSectores ON  ProduccionProcesos.IdProduccionSector = ProduccionSectores.IdProduccionSector 
WHERE (IdProduccionProceso=@IdProduccionProceso)
