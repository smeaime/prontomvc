





























CREATE Procedure [dbo].[AutorizacionesPorComprobante_T]
@IdAutorizacionPorComprobante int
AS 
SELECT *
FROM AutorizacionesPorComprobante
where (IdAutorizacionPorComprobante=@IdAutorizacionPorComprobante)






























