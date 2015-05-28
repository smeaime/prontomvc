CREATE PROCEDURE [dbo].[DetEmpleadosSectores_TX_EmpSec]

@IdEmpleado int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001133'
SET @vector_T='005000'

SELECT
 DetEmpSec.IdDetalleEmpleadoSector,
 DetEmpSec.IdEmpleado,
 DetEmpSec.FechaCambio as [Fecha Cambio],
 Sectores.Descripcion as [Sector nuevo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleEmpleadosSectores DetEmpSec
LEFT OUTER JOIN Sectores ON Sectores.IdSector=DetEmpSec.IdSectorNuevo
WHERE (DetEmpSec.IdEmpleado = @IdEmpleado)
ORDER by DetEmpSec.FechaCambio