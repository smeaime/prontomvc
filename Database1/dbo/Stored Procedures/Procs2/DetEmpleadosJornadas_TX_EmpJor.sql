





CREATE PROCEDURE [dbo].[DetEmpleadosJornadas_TX_EmpJor]
@IdEmpleado int
AS
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='001133'
set @vector_T='005500'
SELECT
DetEmpJor.IdDetalleEmpleadoJornada,
DetEmpJor.IdEmpleado,
DetEmpJor.FechaCambio as [Fecha cambio],
DetEmpJor.HorasJornada as [Horas jornada],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleEmpleadosJornadas DetEmpJor
WHERE (DetEmpJor.IdEmpleado = @IdEmpleado)
ORDER by DetEmpJor.FechaCambio desc





