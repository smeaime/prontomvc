





























CREATE Procedure [dbo].[DetAcopios_TXAcoSF]
@IdAcopio int
AS 
SELECT *
FROM [DetalleAcopios]
where (IdAcopio=@IdAcopio)






























