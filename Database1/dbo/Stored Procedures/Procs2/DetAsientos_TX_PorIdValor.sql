


CREATE Procedure [dbo].[DetAsientos_TX_PorIdValor]
@IdValor int
AS 
SELECT *
FROM DetalleAsientos
WHERE (IdValor=@IdValor)


