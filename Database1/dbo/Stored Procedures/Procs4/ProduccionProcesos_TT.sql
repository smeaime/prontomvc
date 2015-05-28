CREATE Procedure ProduccionProcesos_TT
--@IdArticulo int
AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='0111111133'
Set @vector_T='0111111100'
SELECT 
 ProduccionProcesos.idProduccionProceso,
 ProduccionSectores.Descripcion as Sector,
 ProduccionProcesos. Codigo,
 ProduccionProcesos.Descripcion,
 Obligatorio,
 Valida as [Valida inicio],
 ValidaFinal as [Valida final],
 Incorpora ,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionProcesos
LEFT OUTER JOIN ProduccionSectores ON  ProduccionProcesos.IdProduccionSector = ProduccionSectores.IdProduccionSector 
