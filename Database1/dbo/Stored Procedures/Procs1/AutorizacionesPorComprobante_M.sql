
CREATE  Procedure [dbo].[AutorizacionesPorComprobante_M]

@IdAutorizacionPorComprobante int,
@IdFormulario int,
@IdComprobante int,
@OrdenAutorizacion int,
@IdAutorizo int,
@FechaAutorizacion datetime,
@Visto varchar(2)

AS

UPDATE AutorizacionesPorComprobante
SET
 IdFormulario=@IdFormulario,
 IdComprobante=@IdComprobante,
 OrdenAutorizacion=@OrdenAutorizacion,
 IdAutorizo=@IdAutorizo,
 FechaAutorizacion=@FechaAutorizacion,
 Visto=@Visto
WHERE (IdAutorizacionPorComprobante=@IdAutorizacionPorComprobante)

RETURN(@IdAutorizacionPorComprobante)
