




CREATE Procedure [dbo].[Requerimientos_EliminarRequerimientosAConfirmar]

@IdRequerimiento int

AS 

Delete From DetalleRequerimientos
Where DetalleRequerimientos.IdRequerimiento=@IdRequerimiento and 
	(Select Top 1 Req.Confirmado From Requerimientos Req
	 Where Req.IdRequerimiento=DetalleRequerimientos.IdRequerimiento) is not null and 
	(Select Top 1 Req.Confirmado From Requerimientos Req
	 Where Req.IdRequerimiento=DetalleRequerimientos.IdRequerimiento)='NO'

Delete From Requerimientos
Where Requerimientos.IdRequerimiento=@IdRequerimiento and 
	Requerimientos.Confirmado is not null and Requerimientos.Confirmado='NO'




