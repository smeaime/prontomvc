CREATE Procedure [dbo].[_TempCargaParcialComprobantes_Eliminar]

@IdEntidad int,
@IdTipoComprobante int,
@IdPuntoVenta int,
@NumeroComprobante int,
@IdUsuario int

AS 

DELETE [_TempCargaParcialComprobantes]
WHERE (IdEntidad=@IdEntidad and IdTipoComprobante=@IdTipoComprobante and IdPuntoVenta=@IdPuntoVenta and NumeroComprobante=@NumeroComprobante and IdUsuario=@IdUsuario) or DATEDIFF(day, Fecha, GetDate())>2