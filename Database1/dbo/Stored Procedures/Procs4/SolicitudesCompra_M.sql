



CREATE Procedure [dbo].[SolicitudesCompra_M]
@IdSolicitudCompra int,
@NumeroSolicitud int,
@FechaSolicitud datetime,
@Confecciono int
As
Update SolicitudesCompra
Set 
 NumeroSolicitud=@NumeroSolicitud,
 FechaSolicitud=@FechaSolicitud,
 Confecciono=@Confecciono
Where (IdSolicitudCompra=@IdSolicitudCompra)
Return(@IdSolicitudCompra)



