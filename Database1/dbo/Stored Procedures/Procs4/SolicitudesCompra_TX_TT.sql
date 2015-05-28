



CREATE  Procedure [dbo].[SolicitudesCompra_TX_TT]

@IdSolicitudCompra int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111133'
set @vector_T='0594100'

SELECT 
 SolicitudesCompra.IdSolicitudCompra,
 SolicitudesCompra.NumeroSolicitud as [Nro.solicitud],
 SolicitudesCompra.IdSolicitudCompra as [IdSol],
 SolicitudesCompra.FechaSolicitud as [Fecha],
 Empleados.Nombre as [Confecciono],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM SolicitudesCompra
LEFT OUTER JOIN Empleados ON SolicitudesCompra.Confecciono=Empleados.IdEmpleado
WHERE (IdSolicitudCompra=@IdSolicitudCompra)



