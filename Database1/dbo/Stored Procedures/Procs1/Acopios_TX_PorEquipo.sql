































CREATE  Procedure [dbo].[Acopios_TX_PorEquipo]
@IdEquipo int
AS 
SELECT DISTINCT 
Acopios.IdAcopio,
Acopios.Nombre,
Acopios.Fecha
FROM DetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio=Acopios.IdAcopio
WHERE DetalleAcopios.IdEquipo=@IdEquipo
ORDER BY Acopios.Fecha
































