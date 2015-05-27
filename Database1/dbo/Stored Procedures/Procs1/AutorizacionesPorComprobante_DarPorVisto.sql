
CREATE Procedure [dbo].[AutorizacionesPorComprobante_DarPorVisto]

@IdAutorizacionPorComprobante int

AS 

UPDATE AutorizacionesPorComprobante
SET Visto='SI'
WHERE (IdAutorizacionPorComprobante=@IdAutorizacionPorComprobante)
