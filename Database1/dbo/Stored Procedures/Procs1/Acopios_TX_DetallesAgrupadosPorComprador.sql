































CREATE PROCEDURE [dbo].[Acopios_TX_DetallesAgrupadosPorComprador]
@IdAcopio int
AS
SELECT DetAco.IdComprador
FROM DetalleAcopios DetAco
WHERE DetAco.IdAcopio=@IdAcopio and DetAco.IdComprador is not null  
GROUP By DetAco.IdComprador
































