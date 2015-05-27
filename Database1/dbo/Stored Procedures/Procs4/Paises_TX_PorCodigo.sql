





























CREATE Procedure [dbo].[Paises_TX_PorCodigo]
@Codigo varchar(3)
AS 
SELECT *
FROM Paises
WHERE (Codigo=@Codigo)





























