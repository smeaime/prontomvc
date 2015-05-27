





























CREATE Procedure [dbo].[ValesSalida_T]
@IdValeSalida int
AS 
SELECT * 
FROM ValesSalida
WHERE (IdValeSalida=@IdValeSalida)






























