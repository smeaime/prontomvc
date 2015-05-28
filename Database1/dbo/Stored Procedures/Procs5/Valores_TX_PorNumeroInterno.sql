CREATE Procedure [dbo].[Valores_TX_PorNumeroInterno]

@NumeroInterno int

AS 

SELECT TOP 1 
 Valores.*,
 Bancos.Nombre as [Banco]
FROM Valores
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
WHERE (NumeroInterno=@NumeroInterno)