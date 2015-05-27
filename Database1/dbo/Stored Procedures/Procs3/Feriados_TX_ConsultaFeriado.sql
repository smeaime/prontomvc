CREATE Procedure [dbo].[Feriados_TX_ConsultaFeriado]

@Fecha datetime

AS 

SELECT *
FROM Feriados
WHERE Fecha=@Fecha