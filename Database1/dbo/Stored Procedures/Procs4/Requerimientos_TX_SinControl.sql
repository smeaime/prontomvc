






























CREATE Procedure [dbo].[Requerimientos_TX_SinControl]
@IdRequerimiento int
AS 
Select
DetReq.IdDetalleRequerimiento
From DetalleRequerimientos DetReq
Where DetReq.IdRequerimiento=@IdRequerimiento and DetReq.IdControlCalidad is null































