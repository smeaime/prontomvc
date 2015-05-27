































CREATE Procedure [dbo].[Acopios_TX_SinFechaNecesidad]
@IdAcopio int
AS 
Select
DetAco.IdDetalleAcopios
From DetalleAcopios DetAco
LEFT OUTER JOIN Acopios ON DetAco.IdAcopio=Acopios.IdAcopio
LEFT OUTER JOIN Obras ON Acopios.IdObra=Obras.IdObra
Where 	DetAco.IdAcopio=@IdAcopio and DetAco.FechaNecesidad is null and 
	Substring(Obras.NumeroObra,1,3)='OBT'
































