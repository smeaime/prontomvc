CREATE Procedure [dbo].[Bancos_TX_PorCodigoUnico]

@CodigoUniversal int

AS 

SELECT *
FROM Bancos
WHERE (CodigoUniversal=@CodigoUniversal)