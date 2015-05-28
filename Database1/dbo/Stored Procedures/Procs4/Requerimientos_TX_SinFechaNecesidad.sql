






























CREATE Procedure [dbo].[Requerimientos_TX_SinFechaNecesidad]
@IdRequerimiento int
AS 
Select
DetReq.IdDetalleRequerimiento
From DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento=Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
Where 	DetReq.IdRequerimiento=@IdRequerimiento and DetReq.FechaEntrega is null and 
	Substring(Obras.NumeroObra,1,3)='OBT'































