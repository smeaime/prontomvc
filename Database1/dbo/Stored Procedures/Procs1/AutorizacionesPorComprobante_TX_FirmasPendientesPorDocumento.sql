CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_FirmasPendientesPorDocumento]

@IdFormulario int,
@IdComprobante int

AS

SELECT *
FROM _TempAutorizaciones
WHERE IdFormulario=@IdFormulario and IdComprobante=@IdComprobante
ORDER BY OrdenAutorizacion