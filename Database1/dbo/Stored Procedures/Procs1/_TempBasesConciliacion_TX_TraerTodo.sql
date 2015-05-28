




CREATE Procedure [dbo].[_TempBasesConciliacion_TX_TraerTodo]
AS
SELECT 
 0 as [IdAux],
 Orden,
 BaseDatos as [Base de datos],
 Numeral
FROM [_TempBasesConciliacion]
ORDER BY Orden




