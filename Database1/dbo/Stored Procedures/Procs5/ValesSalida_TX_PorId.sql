




CREATE Procedure [dbo].[ValesSalida_TX_PorId]
@IdValeSalida int
AS 
SELECT * 
FROM ValesSalida
WHERE (IdValeSalida=@IdValeSalida)





