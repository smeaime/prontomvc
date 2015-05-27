CREATE Procedure [dbo].[Articulos_TX_PorNumeroPatente]

@NumeroPatente varchar(20)

AS 

SELECT *
FROM Articulos 
WHERE Upper(NumeroPatente)=Upper(@NumeroPatente)