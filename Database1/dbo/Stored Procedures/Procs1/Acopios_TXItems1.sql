































CREATE Procedure [dbo].[Acopios_TXItems1]
@IdAcopio int,
@NumeroItem int
AS 
SELECT *
FROM DetalleAcopios
where (IdAcopio=@IdAcopio and NumeroItem=@NumeroItem)
































