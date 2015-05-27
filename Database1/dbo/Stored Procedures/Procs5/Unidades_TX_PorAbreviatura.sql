CREATE Procedure [dbo].[Unidades_TX_PorAbreviatura]

@Abreviatura varchar(15)

AS 

SELECT *
FROM Unidades
WHERE (Abreviatura=@Abreviatura)