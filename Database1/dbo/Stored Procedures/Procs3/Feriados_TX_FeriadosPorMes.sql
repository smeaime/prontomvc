CREATE Procedure [dbo].[Feriados_TX_FeriadosPorMes]

@Fecha datetime

AS 

SELECT *
FROM Feriados
WHERE Year(Fecha)=Year(@Fecha) and Month(Fecha)=Month(@Fecha)