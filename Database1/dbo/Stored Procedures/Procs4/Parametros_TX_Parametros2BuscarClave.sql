


CREATE Procedure [dbo].[Parametros_TX_Parametros2BuscarClave]

@Campo varchar(50)

AS 

SELECT Valor
FROM Parametros2
WHERE Campo=@Campo


