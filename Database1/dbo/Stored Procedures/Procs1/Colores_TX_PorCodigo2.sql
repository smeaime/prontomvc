CREATE Procedure [dbo].[Colores_TX_PorCodigo2]

@Codigo2 varchar(5)

AS 

SELECT TOP 1 * 
FROM Colores
WHERE IsNull(Codigo2,'-1')=@Codigo2