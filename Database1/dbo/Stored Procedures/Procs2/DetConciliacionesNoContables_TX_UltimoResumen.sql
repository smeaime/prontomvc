
CREATE PROCEDURE [dbo].[DetConciliacionesNoContables_TX_UltimoResumen]

@IdCuentaBancaria int

AS

SET NOCOUNT ON

DECLARE @IdConciliacion int

SET @IdConciliacion=IsNull((Select Top 1 C.IdConciliacion From Conciliaciones C 
				Where C.IdCuentaBancaria=@IdCuentaBancaria Order By C.FechaFinal Desc),0)

SET NOCOUNT OFF

SELECT *
FROM DetalleConciliacionesNoContables DetConc
WHERE DetConc.IdConciliacion=@IdConciliacion
