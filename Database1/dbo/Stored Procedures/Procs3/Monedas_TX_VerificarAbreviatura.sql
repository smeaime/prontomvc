CREATE Procedure [dbo].[Monedas_TX_VerificarAbreviatura]

@Abreviatura varchar(15),
@IdMoneda int = Null

AS 

SET @IdMoneda=IsNull(@IdMoneda,0)

SELECT * 
FROM Monedas 
WHERE IdMoneda<>@IdMoneda and Abreviatura=@Abreviatura