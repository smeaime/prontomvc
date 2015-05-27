CREATE PROCEDURE [dbo].[DetRecibosRubrosContables_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01633'
SET @vector_T='00100'

SELECT TOP 1
 DetRE.IdDetalleReciboRubrosContables,
 RubrosContables.Descripcion as [Rubro contable],
 DetRE.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecibosRubrosContables DetRE
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetRE.IdRubroContable