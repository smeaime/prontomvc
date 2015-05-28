CREATE Procedure [dbo].[UnidadesEmpaque_TX_NuevoNumero]

AS 

SET NOCOUNT ON

DECLARE @NumeroUnidad1 int

SET @NumeroUnidad1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ProximoNumeroCajaStock'),0)
UPDATE Parametros2
SET Valor=Convert(varchar,@NumeroUnidad1+1)
WHERE IsNull(Campo,'')='ProximoNumeroCajaStock'

SET NOCOUNT OFF

SELECT @NumeroUnidad1