
CREATE Procedure [dbo].[AutorizacionesCompra_M]

@IdAutorizacionCompra int,
@Numero int,
@Fecha datetime,
@IdObra int,
@IdProveedor int, 
@Observaciones ntext,
@IdRealizo int,
@IdAprobo int,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@CircuitoFirmasCompleto varchar(2)

AS

UPDATE AutorizacionesCompra
SET
 Numero=@Numero,
 Fecha=@Fecha,
 IdObra=@IdObra,
 IdProveedor=@IdProveedor,
 Observaciones=@Observaciones,
 IdRealizo=@IdRealizo,
 IdAprobo=@IdAprobo,
 IdUsuarioIngreso=@IdUsuarioIngreso,
 FechaIngreso=@FechaIngreso,
 IdUsuarioModifico=@IdUsuarioModifico,
 FechaModifico=@FechaModifico,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto
WHERE (IdAutorizacionCompra=@IdAutorizacionCompra)

RETURN(@IdAutorizacionCompra)
